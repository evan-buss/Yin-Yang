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

public class YinYang.Widgets.PopoverWidget : Gtk.Grid {
    public unowned YinYang.Indicator indicator { get; set; }

    public Gtk.ModelButton show_yinyang_button;
    public Gtk.ModelButton quit_yinyang_button;

    private Gtk.Grid scale_grid;
    private Gtk.Image image;
    private Gtk.Scale temp_scale;

    public PopoverWidget (YinYang.Indicator indicator) {
      Object (
        indicator: indicator
      );

//     show_yinyang_button.clicked.connect (() => {
//          //  dbusclient.interface.show_yinyang_window ();
//          //  close ();
//      });

//      quit_yinyang_button.clicked.connect (() => {
//          //  dbusclient.interface.quit_yinyang ();
//          //  this.visible = false;
//      });
    }

    construct {
    //   show_yinyang_button = new Gtk.ModelButton ();
    //   show_yinyang_button.text = _("Show Yin-Yang");

    //   quit_yinyang_button = new Gtk.ModelButton ();
    //   quit_yinyang_button.text = _("Quit Yin-Yang");

    //   var icon = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

    //   add (show_yinyang_button);
    //   add (new Wingpanel.Widgets.Separator ());
    //   add (quit_yinyang_button);
    orientation = Gtk.Orientation.VERTICAL;

        image = new Gtk.Image ();
        image.pixel_size = 48;

        temp_scale = new Gtk.Scale.with_range (Gtk.Orientation.HORIZONTAL, 3500, 6000, 10);
        temp_scale.draw_value = false;
        temp_scale.has_origin = false;
        temp_scale.hexpand = true;
        temp_scale.inverted = true;
        temp_scale.width_request = 200;
        temp_scale.get_style_context ().add_class ("warmth");

        scale_grid = new Gtk.Grid ();
        scale_grid.column_spacing = 6;
        scale_grid.margin_start = 6;
        scale_grid.margin_end = 12;
        scale_grid.add (image);
        scale_grid.add (temp_scale);

        var settings_button = new Gtk.ModelButton ();
        settings_button.text = _("Night Light Settings…");

        add (new Wingpanel.Widgets.Separator ());
        add (scale_grid);
        add (new Wingpanel.Widgets.Separator ());
        add (settings_button);
    }
}
