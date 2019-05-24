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

        public Views.MainView main_view;
        public Views.SettingsView settings_view;
        public Settings settings;

        public YinYangWindow () {
            Object (
                resizable: false,
                default_width: 300,
                default_height: 400,
                window_position: Gtk.WindowPosition.CENTER
            );
        }

        construct {
            /************************
              Load Existing Preferences
            ************************/
            settings = new Settings ("com.github.evan-buss.yin-yang");
            if (settings.get_boolean ("dark-mode")) {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", true);
            } else {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", false);
            }

            /************************
              Load External CSS
            ************************/
            var css_provider = new Gtk.CssProvider ();
            css_provider.load_from_resource ("/com/github/evan-buss/yin-yang/css/style.css");
            Gtk.StyleContext.add_provider_for_screen (
                Gdk.Screen.get_default (),
                css_provider,
                Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
            );

            /************************
                Header Bar
            ************************/
            var headerbar = new Gtk.HeaderBar ();
            headerbar.get_style_context ().add_class ("default-decoration");
            headerbar.show_close_button = true;
            set_titlebar (headerbar);
            title = "Yin and Yang";

            /************************
              Settings Toggle Button
            ************************/
            var settings_button = new Gtk.Button.from_icon_name ("open-menu");
            settings_button.valign = Gtk.Align.CENTER;

            headerbar.pack_end (settings_button);

            /************************
              Create Views
            ************************/
            var stack = new Gtk.Stack ();
            main_view = new Views.MainView (this, settings);
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
