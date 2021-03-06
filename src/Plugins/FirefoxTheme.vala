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

/*
    Sets the active firefox theme
    Only supports the default light and dark theme for now.

    Implementation Details:
        1. Attempt to find "user.js" in the firefox profile folder
        2. Create or update this file with the theme string
            - Dark Theme:
                user_pref("lightweightThemes.selectedThemeID", "firefox-compact-dark@mozilla.org");
            - Light Theme:
                user_pref("lightweightThemes.selectedThemeID", "default-theme@mozilla.org");
*/
namespace YinYang.Plugins {

    class FirefoxTheme : Plugin {

        const string DARK_STRING =
            "user_pref(\"lightweightThemes.selectedThemeID\", \"firefox-compact-dark@mozilla.org\");";
        const string LIGHT_STRING =
            "user_pref(\"lightweightThemes.selectedThemeID\", \"default-theme@mozilla.org\");";

        private Gtk.CheckButton checkbox;
        public string sep = Path.DIR_SEPARATOR_S;
        private string firefox_dir;

        public FirefoxTheme () {
        }

        construct {
            firefox_dir = Environment.get_home_dir () + sep + ".mozilla" + sep + "firefox" + sep;
            /************************
              Label
            ************************/
            var label = new Gtk.Label (_("Firefox (Default Only)"));
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-firefox-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            /************************
              Light Entry
            ************************/
            var light_firefox_entry = new Gtk.Entry ();
            light_firefox_entry.text = "Default Light";
            light_firefox_entry.placeholder_text = _("Light Theme");
            light_firefox_entry.hexpand = true;


            /************************
              Dark Entry
            ************************/
            var dark_firefox_entry = new Gtk.Entry ();
            dark_firefox_entry.text = "Default Dark";
            dark_firefox_entry.placeholder_text = _("Dark Theme");
            dark_firefox_entry.hexpand = true;

            /************************
              Layout Settings
            ************************/
            light_firefox_entry.sensitive = false;
            dark_firefox_entry.sensitive = false;
            //  light_firefox_entry.sensitive = checkbox.active;
            //  dark_firefox_entry.sensitive = checkbox.active;

            //  checkbox.toggled.connect (() => {
            //      light_firefox_entry.sensitive = checkbox.active;
            //      dark_firefox_entry.sensitive = checkbox.active;
            //  });

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            box.pack_start (checkbox, false, false, 0);
            box.pack_start (light_firefox_entry, true, true, 0);
            box.pack_start (dark_firefox_entry, true, true, 0);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        public override void set_dark () {
            if (checkbox.active) {
                set_firefox_theme (DARK_STRING);
            }
        }

        public override void set_light () {
            if (checkbox.active) {
                set_firefox_theme (LIGHT_STRING);
            }
        }

        private void set_firefox_theme (string theme_string) {
            try {
                Dir dir = Dir.open (firefox_dir, 0);
                string name;
                while ((name = dir.read_name ()) != null) {
                    string path = Path.build_filename (firefox_dir, name);
                    if (FileUtils.test (path, FileTest.IS_DIR)) {
                        if (path.split (".", 0)[2] == "default") {
                            // Reference user.js file
                            var file = File.new_for_path (path + sep + "user.js");

                            // delete if file already exists
                            if (file.query_exists ()) {
                                file.delete ();
                            }

                            // Create a new file with this name
                            var file_stream = file.create (FileCreateFlags.NONE);

                            // Write theme string to file
                            var data_stream = new DataOutputStream (file_stream);
                            data_stream.put_string (theme_string);
                        }
                    }
                }
            } catch (Error e) {
                message (e.message);
            }
        }
    }
}
