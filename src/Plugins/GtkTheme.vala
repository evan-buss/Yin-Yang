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

    public class GtkTheme : Plugin {

        private Gtk.CheckButton checkbox;
        private Gtk.Entry light_gtk_entry;
        private Gtk.Entry dark_gtk_entry;
        private Settings gtk_settings;

        public GtkTheme() {
            gtk_settings = new Settings ("org.gnome.desktop.interface");
        }

        construct {
            var label = new Gtk.Label ("GTK Theme");
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-gtk-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            light_gtk_entry = new Gtk.Entry ();
            light_gtk_entry.placeholder_text = "Light Theme";

            dark_gtk_entry = new Gtk.Entry ();
            dark_gtk_entry.placeholder_text = "Dark Theme";

            box.add (checkbox);
            box.add (light_gtk_entry);
            box.add (dark_gtk_entry);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        public override void set_light () {
            if (checkbox.active && light_gtk_entry.text != "") {
                gtk_settings.set_string ("gtk-theme", light_gtk_entry.text);
            }
        }

        public override void set_dark () {
            if (checkbox.active && dark_gtk_entry.text != "") {
                gtk_settings.set_string ("gtk-theme", dark_gtk_entry.text);
            }
        }
    }
}
