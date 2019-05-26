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

        public FirefoxTheme () {
        }

        construct {
            var label = new Gtk.Label ("Firefox (Only supports default)");
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            var checkbox = new Gtk.CheckButton ();

            var light_firefox_entry = new Gtk.Entry ();
            light_firefox_entry.sensitive = false;
            light_firefox_entry.text = "Default Light";
            light_firefox_entry.placeholder_text = "Light Theme";

            var dark_firefox_entry = new Gtk.Entry ();
            dark_firefox_entry.sensitive = false;
            dark_firefox_entry.text = "Default Dark";
            dark_firefox_entry.placeholder_text = "Dark Theme";

            box.add (checkbox);
            box.add (light_firefox_entry);
            box.add (dark_firefox_entry);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        //  override public bool set_dark () {

        //  }

        //  override public bool set_light () {

        //  }
    }
}
