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

namespace YinYang.Views {

    public class MainView : Gtk.Grid {

        private Services.Settings settings;
        public Gtk.Switch auto_toggle;
        public Granite.Widgets.ModeButton mode_toggle;

        public signal void mode_changed (bool is_dark);

        public MainView () {
            Object (
                halign: Gtk.Align.CENTER,
                margin: 8
            );
        }

        construct {
            settings = Services.Settings.get_default ();

            /************************
              Application Logo
            ************************/
            Gdk.Pixbuf app_icon_pix_buf = null;
            Gtk.Image app_icon = null;
            try {
                app_icon_pix_buf =
                  new Gdk.Pixbuf.from_resource_at_scale ("/com/github/evan-buss/yin-yang/img/logo.svg", 150, -1, true);
                app_icon = new Gtk.Image.from_pixbuf (app_icon_pix_buf);
                app_icon.margin = 20;
            } catch (Error e) {
                debug ("unable to load logo image");
            }

            /************************
              Mode Toggle Area
            ************************/
            var header_label = new Gtk.Label (_("Select Mode"));
            header_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            mode_toggle = new Granite.Widgets.ModeButton ();
            mode_toggle.append_text (_("Light"));
            mode_toggle.append_text (_("Dark"));
            mode_toggle.set_active (settings.dark_mode ? 1 : 0);
            mode_toggle.margin_bottom = 20;

            mode_toggle.mode_changed.connect (() => {
                if (mode_toggle.selected == 1) {
                    message ("mode changed to dark");
                    settings.dark_mode = true;
                    Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", true);
                    mode_changed (true);
                } else {
                    message ("mode changed to light");
                    settings.dark_mode = false;
                    Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", false);
                    mode_changed (false);
                }
            });

            /************************
              Auto-Switch Settings
            ************************/
            var auto_label = new Gtk.Label (_("Enable Automatic Theme Switching"));
            auto_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            auto_toggle = new Gtk.Switch ();
            settings.schema.bind ("enable-auto-switch", auto_toggle, "active", SettingsBindFlags.DEFAULT);
            auto_toggle.valign = Gtk.Align.CENTER;
            auto_toggle.halign = Gtk.Align.CENTER;
            auto_toggle.margin = 5;
            auto_toggle.set_tooltip_text (_("Places icon in the Wingpanel"));

            var details = new Gtk.Label (_("Mode is toggled at sunset and sunrise"));
            details.get_style_context ().add_class (Gtk.STYLE_CLASS_DIM_LABEL);

            attach (app_icon, 0, 0, 1, 1);
            attach (header_label, 0, 1, 1, 1);
            attach (mode_toggle, 0, 2, 1, 1);
            attach (auto_label, 0, 4, 1, 1);
            attach (auto_toggle, 0, 5, 1, 1);
            attach (details, 0, 6, 1, 1);
        }
    }
}
