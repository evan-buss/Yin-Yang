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

namespace YinYang.Services {

    public class Settings : Granite.Services.Settings {

        private static GLib.Once<Settings> instance;
        public static unowned Settings get_default () {
            return instance.once (() => { return new Settings (); });
        }

        public bool dark_mode { get; set; }

        public bool enable_auto_switch { get; set; }

        public bool enable_dark_desktop { get; set; }

        public bool enable_gtk_theme { get; set; }
        public string gtk_theme_light { get; set; }
        public string gtk_theme_dark { get; set; }

        public bool enable_vscode_theme { get; set; }

        public bool enable_terminal_theme { get; set; }
        public int terminal_theme_light { get; set; }
        public int terminal_theme_dark { get; set; }

        public bool enable_wallpaper_theme { get; set; }
        public string wallpaper_light { get; set; }
        public string wallpaper_dark { get; set; }

        construct {
            // Controls the default application theme mode
            if (dark_mode) {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", true);
            } else {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", false);
            }
        }

        private Settings () {
            base ("com.github.evan-buss.yin-yang.settings");
        }
    }
}
