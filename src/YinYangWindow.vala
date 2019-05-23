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

namespace YinYang {

    public class YinYangWindow : Gtk.ApplicationWindow {

        // private Settings settings;
        public Gtk.Revealer settings_revealer;

        public YinYangWindow() {
            Object (
                resizable: false
            );
        }

        construct {
            settings_revealer = new Gtk.Revealer ();
            settings_revealer.set_transition_type (Gtk.RevealerTransitionType.CROSSFADE);
            settings_revealer.set_transition_duration(1000);
            var settings_view = new SettingsView ();

            settings_revealer.add (settings_view);

            add (settings_revealer);

            //  settings = new GLib.Settings ("com.github.evan-buss.yin-yang");

            //  var useless_switch = new Gtk.Switch ();
            //  settings.bind ("useless-setting", useless_switch, "active", GLib.SettingsBindFlags.DEFAULT);
            // 255 });

            // primary_color_button.color_set.connect (() => {
            //     Granite.Widgets.Utils.set_color_primary (this, primary_color_button.rgba);
            // });

            // var box = new Gtk.VBox (true, 10);

            // box.pack_start (primary_color_label);
            // box.pack_start (primary_color_button);

        }
    }
}
