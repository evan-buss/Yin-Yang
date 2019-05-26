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

    public class DesktopTheme : Plugin {
        private GLib.KeyFile keyfile;
        private string setting_path;
        private Gtk.CheckButton checkbox;

        public DesktopTheme () {
            keyfile = new GLib.KeyFile ();

            try {
                setting_path = GLib.Environment.get_user_config_dir () + "/gtk-3.0/settings.ini";
                keyfile.load_from_file (setting_path, 0);
            }
            catch (Error e) {
                warning ("Error loading GTK+ Keyfile settings.ini: " + e.message);
            }
        }

        construct {
            var label = new Gtk.Label ("Desktop Color Mode");
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;
            checkbox = new Gtk.CheckButton.with_label ("Use Prefer Dark Flag");
            settings.schema.bind ("enable-dark-desktop", checkbox, "active", SettingsBindFlags.DEFAULT);

            attach (label, 0, 0, 1, 1);
            attach (checkbox, 0, 1, 1, 1);
        }

        public override void set_light () {
            if (checkbox.active) {
                prefer_dark_theme = false;
            }
        }

        public override void set_dark () {
            if (checkbox.active) {
                prefer_dark_theme = true;
            }
        }

        /**
         * GTK should prefer the dark theme or not
         */
        public bool prefer_dark_theme {
            get { return (get_integer ("gtk-application-prefer-dark-theme") == 1); }
            set { set_integer ("gtk-application-prefer-dark-theme", value ? 1 : 0); }
        }

        /**
         * Gets an integer from the keyfile at Settings group
         */
        private int get_integer (string key) {
            int key_int = 0;

            try {
                key_int = keyfile.get_integer ("Settings", key);
            }
            catch (Error e) {
                warning ("Error getting GTK+ int setting: " + e.message);
            }

            return key_int;
        }

        /**
         * Sets an integer from the keyfile at Settings group
         */
        private void set_integer (string key, int val) {
            keyfile.set_integer ("Settings", key, val);

            save_keyfile ();
        }

        /**
         * Saves the keyfile to disk
         */
        private void save_keyfile () {
            try {
                string data = keyfile.to_data ();
                FileUtils.set_contents (setting_path, data);
            }
            catch (FileError e) {
                warning ("Error saving GTK+ Keyfile settings.ini: " + e.message);
            }
        }
    }
}
