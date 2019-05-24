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

        public YinYangApp () {
            Object (
                application_id: "com.github.evan-buss.yin-yang",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        construct {
            var quit_action = new SimpleAction ("quit", null);
            quit_action.activate.connect (() => {
                if (window != null) {
                    window.destroy ();
                }
            });

            add_action (quit_action);
            set_accels_for_action ("app.quit", {"<Control>q", "Escape"});
        }

        protected override void activate () {
            /************************
                Construct Window
            ************************/
            window = new YinYangWindow ();
            window.set_application (this);
            window.show_all ();
        }

        public static int main (string[] args) {
            app = new YinYangApp ();
            return app.run (args);
        }
    }
}
