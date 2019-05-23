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
        public Views.MainView main_view;
        public Views.SettingsView settings_view;
        public Gtk.Button settings_button { get; construct; }

        public bool show_settings = false;

        public YinYangWindow (Gtk.Button button) {
            Object (
                resizable: false,
                settings_button: button
            );

            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource ("/com/github/evan-buss/yin-yang/css/style.css");

            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );
        }

        construct {
            var stack = new Gtk.Stack ();
            main_view = new Views.MainView (this);
            settings_view = new Views.SettingsView ();
            stack.add_named (main_view, "main");
            stack.add_named (settings_view, "settings");

            settings_button.clicked.connect (() => {
                //  Settings --> Main
                if (stack.visible_child == main_view) {
                    stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);
                    stack.set_visible_child (settings_view);
                } else {
                    // Main --> Settings
                    stack.set_transition_type (Gtk.StackTransitionType.SLIDE_RIGHT);
                    stack.set_visible_child (main_view);
                }
            });

            add (stack);
        }
    }
}

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
