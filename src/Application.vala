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

public class MyApp : Gtk.Application {

    public MyApp () {
        Object (
            application_id: "com.github.evan-buss.yin-yang",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var settings = new GLib.Settings ("com.github.evan-buss.yin-yang");
        var main_window = new Gtk.ApplicationWindow (this);
        main_window.default_height = 300;
        main_window.default_width = 300;
        main_window.title = "Hello World";

        var useless_switch = new Gtk.Switch ();
        settings.bind ("useless-setting", useless_switch, "active", GLib.SettingsBindFlags.DEFAULT);


        var grid = new Gtk.Grid ();
        grid.orientation = Gtk.Orientation.VERTICAL;
        grid.row_spacing = 6;

        var title_label = new Gtk.Label (_("Notifications"));
        var show_button = new Gtk.Button.with_label (_("Show"));
        show_button.clicked.connect (() => {
            var notification = new Notification (_("Hello World"));
            var icon = new GLib.ThemedIcon ("dialog-warning");
            notification.set_icon (icon);
            notification.set_body (_("This is my first notification!"));
            this.send_notification ("com.github.yourusername.yourrepositoryname", notification);
        });

        var replace_button = new Gtk.Button.with_label (_("Replace"));
        grid.add (replace_button);

        var entry = Unity.LauncherEntry.get_for_desktop_id ("Yin-Yang.desktop");
        //  print (entry);


        replace_button.clicked.connect (() => {

            entry.count_visible = true;
            entry.count = 99;

            entry.progress_visible = true;
            entry.progress = 0.2f;

            //  var notification = new Notification (_("Hello Again"));
            //  notification.set_body (_("This is my second Notification!"));

            //  var icon = new GLib.ThemedIcon ("dialog-warning");
            //  notification.set_icon (icon);

            //  this.send_notification ("com.github.yourusername.yourrepositoryname2", notification);
        });

        grid.add (title_label);
        grid.add (show_button);
        grid.add (useless_switch);

        main_window.add (grid);
        main_window.show_all ();

        main_window.show_all ();
    }

    public static int main (string[] args) {
        var app = new MyApp ();
        return app.run (args);
    }
}