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
    Gsettings to manipulate
        background
        foreground
        prefer-dark-style
*/


namespace YinYang.Plugins {
    public class TerminalTheme : Plugin {

        struct theme {
            public string name;
            public string background;
            public string foreground;
            public bool prefer_dark;
        }

        private Settings terminal_settings;
        private Gtk.ListStore model;
        private Gtk.CheckButton checkbox;
        private Gtk.ComboBox light_terminal_cb;
        private Gtk.ComboBox dark_terminal_cb;

        private theme[] themes = {
            theme () {
                name = "Classic",
                background = "#fff",
                foreground = "#333",
                prefer_dark = false
            },
            theme () {
                name = "Solarized Light",
                background = "rgba(253, 246, 227, 0.95)",
                foreground = "#586e75",
                prefer_dark = false
            },
            theme () {
                name = "Solarized Dark",
                background = "rgba(37, 46, 50, 0.95)",
                foreground = "#94a3a5",
                prefer_dark = true
            }
        };

        public TerminalTheme () {
            terminal_settings = new Settings ("io.elementary.terminal.settings");
        }

        construct {
            var label = new Gtk.Label ("Terminal");
            label.get_style_context (). add_class (Granite.STYLE_CLASS_H4_LABEL);
            label.halign = Gtk.Align.START;

            var box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);

            checkbox = new Gtk.CheckButton ();
            settings.schema.bind ("enable-terminal-theme", checkbox, "active", SettingsBindFlags.DEFAULT);

            model = new Gtk.ListStore (4, typeof (string), typeof (string),
                                         typeof (string), typeof (bool));

            light_terminal_cb = new Gtk.ComboBox.with_model (model);
            dark_terminal_cb = new Gtk.ComboBox.with_model (model);

            for (int i = 0; i < themes.length; i++) {
                Gtk.TreeIter iter;
                model.append (out iter);
                model.set (iter, 0, themes[i].name);
                model.set (iter, 1, themes[i].background);
                model.set (iter, 2, themes[i].foreground);
                model.set (iter, 3, themes[i].prefer_dark);
            }

            settings.schema.bind ("terminal-theme-dark", dark_terminal_cb, "active", SettingsBindFlags.DEFAULT);
            settings.schema.bind ("terminal-theme-light", light_terminal_cb, "active", SettingsBindFlags.DEFAULT);

            /* CellRenderers render the data. */
            Gtk.CellRendererText cell = new Gtk.CellRendererText ();
            light_terminal_cb.pack_start (cell, true);
            light_terminal_cb.hexpand = true;
            light_terminal_cb.set_attributes (cell, "text", 0);

            dark_terminal_cb.pack_start (cell, true);
            dark_terminal_cb.hexpand = true;
            dark_terminal_cb.set_attributes (cell, "text", 0);

            light_terminal_cb.sensitive = checkbox.active;
            dark_terminal_cb.sensitive = checkbox.active;

            checkbox.toggled.connect (() => {
                light_terminal_cb.sensitive = checkbox.active;
                dark_terminal_cb.sensitive = checkbox.active;
            });

            box.pack_start (checkbox, false, false, 0);
            box.pack_start (light_terminal_cb, true, true, 0);
            box.pack_start (dark_terminal_cb, true, true, 0);

            attach (label, 0, 0, 1, 1);
            attach (box, 0, 1, 1, 1);
        }

        public override void set_light () {
            if (checkbox.active && light_terminal_cb.active != -1) {
                terminal_settings.set_string
                    ("background", themes[light_terminal_cb.active].background);
                terminal_settings.set_string
                    ("foreground", themes[light_terminal_cb.active].foreground);
                terminal_settings.set_boolean
                    ("prefer-dark-style", themes[light_terminal_cb.active].prefer_dark);
            }
        }

        public override void set_dark () {
            if (checkbox.active && dark_terminal_cb.active != -1) {
                terminal_settings.set_string
                    ("background", themes[dark_terminal_cb.active].background);
                terminal_settings.set_string
                    ("foreground", themes[dark_terminal_cb.active].foreground);
                terminal_settings.set_boolean
                    ("prefer-dark-style", themes[dark_terminal_cb.active].prefer_dark);
            }
        }
    }
}
