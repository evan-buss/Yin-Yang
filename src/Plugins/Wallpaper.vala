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

namespace YinYang.Plugins {

    public class Wallpaper : Plugin {

        private Gtk.CheckButton checkbox;
        private Gtk.FileChooserButton light_wallpaper_select;
        private Gtk.FileChooserButton dark_wallpaper_select;
        private Settings desktop_settings;

        public Wallpaper () {
            Object (
                column_spacing: 8
            );
            desktop_settings = new Settings ("org.gnome.desktop.background");
        }

        construct {
            var label = new Gtk.Label (_("Background"));
            label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var outer_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
            var inner_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
            inner_box.halign = Gtk.Align.CENTER;
            inner_box.hexpand = true;
            outer_box.hexpand = true;

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-wallpaper-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            /************************
              Light Wallpaper Selector
            ************************/
            light_wallpaper_select = new Gtk.FileChooserButton (_("Light Background"), Gtk.FileChooserAction.OPEN);
            light_wallpaper_select.width_chars = 13;
            light_wallpaper_select.hexpand = true;

            // Load file from preferences or set to default
            if (settings.wallpaper_light == "") {
                light_wallpaper_select.set_current_folder_uri ("~/Pictures");
            } else {
                light_wallpaper_select.set_uri (settings.wallpaper_light);
            }

            // Save users's file selection choice.
            light_wallpaper_select.file_set.connect (() => {
                settings.wallpaper_light = light_wallpaper_select.get_uri ();
            });

            /************************
              Dark Wallpaper Selector
            ************************/
            dark_wallpaper_select = new Gtk.FileChooserButton (_("Dark Background"), Gtk.FileChooserAction.OPEN);
            dark_wallpaper_select.width_chars = 13;
            dark_wallpaper_select.hexpand = true;

            // Load file from preferences or set to default
            if (settings.wallpaper_dark == "") {
                dark_wallpaper_select.set_current_folder_uri ("~/Pictures");
            } else {
                dark_wallpaper_select.set_uri (settings.wallpaper_dark);
            }

            // Save users's file selection choice.
            dark_wallpaper_select.file_set.connect (() => {
                settings.wallpaper_dark = dark_wallpaper_select.get_uri ();
            });

            /************************
              File Chooser Filter
            ************************/
            var filter = new Gtk.FileFilter ();
            filter.add_pattern ("*.png");
            filter.add_pattern ("*.jpg");
            filter.add_pattern ("*.jpeg");

            light_wallpaper_select.add_filter (filter);
            dark_wallpaper_select.add_filter (filter);

            /************************
              Layout Settings
            ************************/
            light_wallpaper_select.sensitive = checkbox.active;
            dark_wallpaper_select.sensitive = checkbox.active;

            checkbox.toggled.connect (() => {
                light_wallpaper_select.sensitive = checkbox.active;
                dark_wallpaper_select.sensitive = checkbox.active;
            });

            inner_box.add (light_wallpaper_select);
            inner_box.add (dark_wallpaper_select);

            outer_box.pack_start (checkbox, false, false, 0);
            outer_box.pack_start (inner_box, true, true, 0);

            attach (label, 0, 0, 1, 1);
            attach (outer_box, 0, 1, 1, 1);
        }

        public override void set_light () {
            if (light_wallpaper_select.get_uri () != null) {
                desktop_settings.set_string ("picture-uri", light_wallpaper_select.get_uri ());
            }
        }

        public override void set_dark () {
             if (dark_wallpaper_select.get_uri () != null) {
                desktop_settings.set_string ("picture-uri", dark_wallpaper_select.get_uri ());
            }
        }
    }
}
