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

namespace YinYang {

    public class YinYangWindow : Gtk.ApplicationWindow {

        public Views.MainView main_view;
        public Views.SettingsView settings_view;
        public Services.Settings settings;
        public DBusServer dbusserver;
        private Gtk.Stack stack;
        private Services.BackgroundManager manager;

        public YinYangWindow (Application app) {
            Object (
                resizable: false,
                default_width: 200,
                default_height: 400,
                window_position: Gtk.WindowPosition.CENTER
            );

            /************************
              DBus Actions
            ************************/
            dbusserver = DBusServer.get_default ();

            //  User selects "quit" from wingpanel indicator
            dbusserver.quit.connect (() => app.quit ());

            //  User selects "show" from wingpanel indicator
            dbusserver.show.connect (() => {
                this.deiconify ();
                this.show_all ();
                this.present ();
            });

            /************************
              Background Manager
            ************************/
            //  Change themes when nightlight starts and ends
            manager.active_changed.connect ((is_dark) => {
                debug ("Nightlight status changed!");
                set_themes(is_dark);              // Load plugin theme settings
                main_view.mode_toggle.set_active (is_dark ? 1 : 0);
            });

            /************************
              Event Listeners
            ************************/
            //  Listen for the mode to be changed (dark/light button clicked)
            main_view.mode_changed.connect ((is_dark) => {
                set_themes (is_dark);
            });

            //  Only show the wingpanel indicator if auto switch enabled
            main_view.auto_toggle.notify["active"].connect (() => {
                dbusserver.indicator_state (settings.enable_auto_switch);
                //  Disable manual theme switching
                main_view.mode_toggle.sensitive = !main_view.auto_toggle.active;
                //  Match theme with nightlight status
                set_themes (manager.active);
                main_view.mode_toggle.set_active (manager.active ? 1 : 0);
            });

            //  Toggle between views using "Ctrl+S"
            key_press_event.connect ((e) => {
                if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    if (e.keyval == Gdk.Key.s) {
                        toggle_view ();
                        return true;
                    }
                }
               return false;
            });

            // Either close the app or hide it depending if the user wants the
            //  them to automatically switch between modes
            delete_event.connect (() => {
                if (settings.enable_auto_switch == true) {
                    this.hide_on_delete ();
                } else {
                    dbusserver.indicator_state (false);
                    app.quit ();
                }
                return true;
            });

            /************************
             Startup Actions
            ************************/
            //  Need to manually set theme on startup if auto-switch enabled.
            //  Other methods only listen for the switch, but if the program isn't
            //  running when night-mode kicks on or off nothing will happen.
            if (main_view.auto_toggle.active) {
                set_themes (manager.active);
                main_view.mode_toggle.set_active (manager.active ? 1 : 0);
            }
        }

        construct {
            /************************
              Load Existing Preferences
            ************************/
            settings = Services.Settings.get_default ();

            /************************
              Load Background Manager
            ************************/
            manager = Services.BackgroundManager.get_instance ();

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
            title = _("Yin and Yang");

            /************************
              Settings Toggle Button
            ************************/
            var settings_button =
            new Gtk.Button.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
            settings_button.valign = Gtk.Align.CENTER;
            settings_button.set_tooltip_text (_("Edit Settings (Ctrl+S)"));

            headerbar.pack_end (settings_button);

            /************************
              Create Views
            ************************/
            stack = new Gtk.Stack ();
            main_view = new Views.MainView ();
            settings_view = new Views.SettingsView ();
            stack.add_named (main_view, "main");
            stack.add_named (settings_view, "settings");

            var settings_style_context = settings_button.get_style_context ();

            settings_button.clicked.connect (() => {
                toggle_view ();
            });

            add (stack);
        }

        /*
            Loop through all plugins and set them as dark if they are enabled
        */
        private void set_all_dark () {
            foreach (var plugin in settings_view.plugin_list) {
                plugin.set_dark ();
            }
        }

        /*
            Loop through all plugins and set them as light if they are enabled
        */
        private void set_all_light () {
            foreach (var plugin in settings_view.plugin_list) {
                plugin.set_light ();
            }
        }

        private void set_themes (bool is_dark) {
            if (is_dark) {
                set_all_dark ();
            } else {
                set_all_light ();
            }
        }

        private void toggle_view () {
            //  Settings --> Main
            if (stack.visible_child == main_view) {
                stack.set_transition_type (Gtk.StackTransitionType.SLIDE_LEFT);
                stack.set_visible_child (settings_view);
            } else {
                // Main --> Settings
                set_themes (settings.dark_mode); // Re-apply changed settings
                stack.set_transition_type (Gtk.StackTransitionType.SLIDE_RIGHT);
                stack.set_visible_child (main_view);
            }
        }
    }
}
