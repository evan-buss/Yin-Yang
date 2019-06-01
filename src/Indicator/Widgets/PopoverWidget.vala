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

*/

public class YinYang.Widgets.PopoverWidget : Gtk.Box {

    public Gtk.ModelButton show_yinyang_button;
    public Gtk.ModelButton quit_yinyang_button;

    public PopoverWidget () {
        Object (
            orientation: Gtk.Orientation.VERTICAL
        );
    }

    construct {
        orientation = Gtk.Orientation.VERTICAL;

        show_yinyang_button = new Gtk.ModelButton ();
        show_yinyang_button.text = _("Show Yin-Yang");
        show_yinyang_button.hexpand = true;
        show_yinyang_button.centered = true;

        //  show_yinyang_button.clicked.connect (() => {
        //      //  dbusclient.interface.show_yinyang_window ();
        //      //  close ();
        //  });

        quit_yinyang_button = new Gtk.ModelButton ();
        quit_yinyang_button.text = _("Quit Yin-Yang");
        quit_yinyang_button.hexpand = true;
        quit_yinyang_button.centered = true;

        //  quit_yinyang_button.clicked.connect (() => {
        //      //  dbusclient.interface.quit_yinyang ();
        //      //  this.visible = false;
        //  });

        add (show_yinyang_button);
        add (new Wingpanel.Widgets.Separator ());
        add (quit_yinyang_button);


        //  var compositing_switch = new Wingpanel.Widgets.Switch (_("Composited Icon"));


        //  attach (hide_button, 0, 0);
        //  attach (new Wingpanel.Widgets.Separator (), 0, 1);
        //  attach (compositing_switch, 0, 2);

        //  /* Indicator should be visible at startup */
        //  this.visible = true;

        //  hide_button.clicked.connect (() => {
        //      this.visible = false;

        //      Timeout.add (2000, () => {
        //          this.visible = true;
        //          return false;
        //      });
        //  });
    }
}
