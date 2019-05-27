/*
* Copyright (c) 2011-2019 Your Organization (https://evanbuss.com)
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

namespace YinYang.Plugins {

    public class VSCodeTheme : Plugin {

        private Gtk.CheckButton checkbox;
        private Gtk.Entry light_vscode_entry;
        private Gtk.Entry dark_vscode_entry;
        private string config_dir = Environment.get_user_config_dir ();
        private string[] settings_paths;

        public VSCodeTheme () {
            settings_paths = {
                config_dir + "/Code/User/settings.json",
                config_dir + "/VSCodium/User/settings.json",
                config_dir + "/Code - OSS/User/settings.json",
                config_dir + "/Code - Insiders/User/settings.json",
            };
        }

        construct {
            var label = new Gtk.Label ("Visual Studio Code");
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-vscode-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            light_vscode_entry = new Gtk.Entry ();
            light_vscode_entry.width_chars = 15;
            light_vscode_entry.placeholder_text = "Light Theme";
            settings.schema.bind ("vscode-theme-light", light_vscode_entry, "text", SettingsBindFlags.DEFAULT);

            dark_vscode_entry = new Gtk.Entry ();
            dark_vscode_entry.width_chars = 15;
            dark_vscode_entry.placeholder_text = "Dark Theme";
            settings.schema.bind ("vscode-theme-dark", dark_vscode_entry, "text", SettingsBindFlags.DEFAULT);


            box.add (checkbox);
            box.add (light_vscode_entry);
            box.add (dark_vscode_entry);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        public override void set_light () {
            if (checkbox.active && light_vscode_entry.text != "") {
                write_json (light_vscode_entry.text);
            }
        }

        public override void set_dark () {
            if (checkbox.active && dark_vscode_entry.text != "") {
                write_json (dark_vscode_entry.text);
            }
        }

        /*
            Write the given theme string to the VSCode settings file if it exists
         */
        private void write_json (string theme_string) {
            foreach (var path in settings_paths) {
                if (FileUtils.test (path, FileTest.EXISTS)) {
                    try {
                        var parser = new Json.Parser ();
                        parser.load_from_file (path);

                        var root_object = parser.get_root ().get_object ();
                        root_object.set_string_member ("workbench.colorTheme", theme_string);

                        var generator = new Json.Generator ();
                        generator.set_root (parser.get_root ());
                        generator.pretty = true;
                        generator.indent = 2;
                        generator.to_file (path);
                    } catch (Error e) {
                        message (e.message);
                    }
                }
            }
        }
    }
}
