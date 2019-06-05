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

//  TODO: Make the selections drop downs that show the currently installed themes
//        Eliminates errors of wrong names, etc.

namespace YinYang.Plugins {

    public class GtkTheme : Plugin {

        private Gtk.CheckButton checkbox;
        private Gtk.Entry light_gtk_entry;
        private Gtk.Entry dark_gtk_entry;
        private Settings gtk_settings;

        public GtkTheme () {
            gtk_settings = new Settings ("org.gnome.desktop.interface");
        }

        construct {

            /************************
              Label
            ************************/
            var label = new Gtk.Label (_("GTK Theme"));
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;
            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-gtk-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            /************************
              Light Theme Selector
            ************************/
            light_gtk_entry = new Gtk.Entry ();
            light_gtk_entry.placeholder_text = _("Light Theme");
            light_gtk_entry.hexpand = true;
            settings.schema.bind ("gtk-theme-light", light_gtk_entry, "text", SettingsBindFlags.DEFAULT);

            /************************
              Dark Theme Selector
            ************************/
            dark_gtk_entry = new Gtk.Entry ();
            dark_gtk_entry.placeholder_text = _("Dark Theme");
            dark_gtk_entry.hexpand = true;
            settings.schema.bind ("gtk-theme-dark", dark_gtk_entry, "text", SettingsBindFlags.DEFAULT);

            /************************
              Layout Settings
            ************************/
            light_gtk_entry.sensitive = checkbox.active;
            dark_gtk_entry.sensitive = checkbox.active;

            checkbox.toggled.connect (() => {
                light_gtk_entry.sensitive = checkbox.active;
                dark_gtk_entry.sensitive = checkbox.active;
            });

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            box.pack_start (checkbox, false, false, 0);
            box.pack_start (light_gtk_entry, true, true, 0);
            box.pack_start (dark_gtk_entry, true, true, 0);

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
