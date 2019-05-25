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
        public VSCodeTheme() {
        }

        construct {
            var label = new Gtk.Label ("Visual Studio Code");
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            var checkbox = new Gtk.CheckButton ();

            var light_vscode_entry = new Gtk.Entry ();
            light_vscode_entry.placeholder_text = "Light Theme";

            var dark_vscode_entry = new Gtk.Entry ();
            dark_vscode_entry.placeholder_text = "Dark Theme";

            box.add (checkbox);
            box.add (light_vscode_entry);
            box.add (dark_vscode_entry);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }
    }
}
