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
    class CodeTheme : Plugin {

        private Gtk.CheckButton checkbox;
        private Gtk.ComboBoxText light_code_cb;
        private Gtk.ComboBoxText dark_code_cb;
        private Settings code_settings;
        private string[,] theme_choices = {
            {"classic", "Classic"},
            {"solarized-light", "Solarized Light"},
            {"solarized-dark", "Solarized Dark"}
        };

        public CodeTheme () {
             code_settings = new Settings ("io.elementary.code.settings");
        }

        construct {
            var label = new Gtk.Label ("Code");
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-code-theme", checkbox, "active", SettingsBindFlags.DEFAULT);


            light_code_cb = new Gtk.ComboBoxText ();
            dark_code_cb = new Gtk.ComboBoxText ();
            set_dropdown_sensitive (false);


            checkbox.toggled.connect (() => {
                if (checkbox.active) {
                    set_dropdown_sensitive (true);
                } else {
                    set_dropdown_sensitive (false);
                }
            });

            for (int i = 0; i < theme_choices.length[0]; i++) {
                dark_code_cb.append (theme_choices[i,0], theme_choices[i,1]);
                light_code_cb.append (theme_choices[i,0], theme_choices[i,1]);
            }

            box.add (checkbox);
            box.add (light_code_cb);
            box.add (dark_code_cb);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        private void set_dropdown_sensitive (bool is_sens) {
            if (is_sens) {
                light_code_cb.sensitive = true;
                dark_code_cb.sensitive = true;
            } else {
                 light_code_cb.sensitive = false;
                dark_code_cb.sensitive = false;
            }
        }

        public override void set_light () {
            if (checkbox.active && light_code_cb.active != -1) {
                code_settings.set_string ("style-scheme", light_code_cb.active_id);
                code_settings.set_boolean ("prefer-dark-style", false);
            }
        }

        public override void set_dark () {
            if (checkbox.active && dark_code_cb.active != -1) {
                code_settings.set_string ("style-scheme", dark_code_cb.active_id);
                code_settings.set_boolean ("prefer-dark-style", true);
            }
        }
    }
}
