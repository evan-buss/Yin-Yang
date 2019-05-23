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

    public class YinYangApp : Gtk.Application {

        private static YinYangApp app;
        private YinYangWindow window = null;
        private Settings settings;
        private Gtk.Settings gtk_settings;

        public YinYangApp () {
            Object (
                application_id: "com.github.evan-buss.yin-yang",
                flags: ApplicationFlags.FLAGS_NONE
            );
            gtk_settings = Gtk.Settings.get_default ();
            settings = new GLib.Settings ("com.github.evan-buss.yin-yang");
        }

        protected override void activate () {
            window = new YinYangWindow();
            window.default_height = 300;
            window.default_width = 300;


            var headerbar = new Gtk.HeaderBar ();
            headerbar.get_style_context ().add_class ("default-decoration");
            headerbar.show_close_button = true;
            window.set_titlebar (headerbar);

            // Non-functional for now.. Need to decide what course I am going to take
            var mode_switch = new Granite.ModeSwitch.from_icon_name ("display-brightness-symbolic", "weather-clear-night-symbolic");
            mode_switch.primary_icon_tooltip_text = ("Light background");
            mode_switch.secondary_icon_tooltip_text = ("Dark background");
            mode_switch.valign = Gtk.Align.CENTER;

            var settings_showing = false;
            var settings_button = new Gtk.Button.from_icon_name ("open-menu");
            settings_button.margin = 4;

            // Header Bar Settings Button should toggle the settings revealer
            settings_button.clicked.connect (() => {
                if (settings_showing) {
                    window.settings_revealer.set_reveal_child(false);
                } else {
                    window.settings_revealer.set_reveal_child(true);
                }
                settings_showing = !settings_showing;
            });


            headerbar.pack_start (settings_button);
            headerbar.pack_end (mode_switch);

            window.title = "Yin and Yang";
            window.set_application (this);
            window.show_all ();
        }

        public static int main (string[] args) {
            app = new YinYangApp ();
            return app.run (args);
        }
    }
}
