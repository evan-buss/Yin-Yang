/*
* Copyright (c) 2011-2019 Evan Buss (https://evanbuss.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc.,
* 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Evan Buss <evan.buss28@gmail.com>
*/
namespace YinYang {

    public class YinYangApp : Gtk.Application {

        private static YinYangApp app;
        private YinYangWindow window = null;
        private bool headless = false;

        public YinYangApp () {
            Object (
                application_id: "com.github.evan-buss.yin-yang",
                flags: ApplicationFlags.HANDLES_COMMAND_LINE
            );
        }

        construct {
            var quit_action = new SimpleAction ("quit", null);
            quit_action.activate.connect (() => {
                if (window != null) {
                    if (Services.Settings.get_default ().enable_auto_switch == true) {
                        window.hide_on_delete ();
                    } else {
                        DBusServer.get_default ().indicator_state (false);
                        app.quit ();
                    }
                }
            });

            add_action (quit_action);
            set_accels_for_action ("app.quit", {"<Control>q", "Escape"});
        }

        protected override void activate () {
            /************************
              First Run
            ************************/
            var settings = Services.Settings.get_default ();
            if (settings.first_run) {
                message ("installing autostart");
                install_autostart ();
                settings.first_run = false;
            }

            /************************
                Construct Window
            ************************/
            if (window == null) {
                window = new YinYangWindow (this);
                window.set_application (this);

                if (!headless) {
                    window.show_all ();
                }
            }

            //  Present window if already running
            if (window != null && !headless) {
                window.show_all ();
                window.present ();
            }
        }

        //  This only runs when there are command line args
        public override int command_line (ApplicationCommandLine command_line) {
            //  stdout.printf ("Received command line args");
            var headless_mode = false;

            //  "--headless" option
            OptionEntry[] options = new OptionEntry[1];
            options[0] = {
                "headless", 0, 0, OptionArg.NONE,
                ref headless_mode, "Run without window", null
            };

            string[] args = command_line.get_arguments ();
            string[] _args = new string[args.length];
            for (int i = 0; i < args.length; i++) {
                _args[i] = args[i];
            }

            try {
                var ctx = new OptionContext ();
                ctx.set_help_enabled (true);
                ctx.add_main_entries (options, null);
                unowned string[] tmp = _args;
                ctx.parse (ref tmp);
            } catch (OptionError e) {
                command_line.print ("error: %s\n", e.message);
            }

            headless = headless_mode;

            hold ();
            activate ();
            return 0;
        }

        public static int main (string[] args) {
            app = new YinYangApp ();

            if (args.length > 1 && args[1] == "headless") {
                app.headless = true;
            }

            return app.run (args);
        }

        // Create autostart desktop file entry in ~/.config/autostart on first run
        private void install_autostart () {
            var desktop_file_name = application_id + ".desktop";
            var desktop_file_path = new DesktopAppInfo (desktop_file_name).filename;
            var desktop_file = File.new_for_path (desktop_file_path);
            var dest_path = Path.build_path (
                Path.DIR_SEPARATOR_S,
                Environment.get_user_config_dir (),
                "autostart",
                desktop_file_name
            );
            var dest_file = File.new_for_path (dest_path);
            try {
                desktop_file.copy (dest_file, FileCopyFlags.OVERWRITE);
            } catch (Error e) {
                warning ("Error making copy of desktop file for autostart: %s", e.message);
            }

            var keyfile = new KeyFile ();
            try {
                keyfile.load_from_file (dest_path, KeyFileFlags.NONE);
                keyfile.set_boolean ("Desktop Entry", "X-GNOME-Autostart-enabled", true);
                keyfile.set_string ("Desktop Entry", "Exec", application_id + " --headless");
                keyfile.save_to_file (dest_path);
            } catch (Error e) {
                warning ("Error enabling autostart: %s", e.message);
            }
        }
    }
}
