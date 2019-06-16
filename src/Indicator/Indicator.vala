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

public class YinYang.Indicator : Wingpanel.Indicator {

    private Gtk.Image display_widget;
    private Widgets.PopoverWidget popover_widget;
    private DBusClient dbusclient;
    private YinYang.Services.Settings settings;

    public Indicator () {
        Object (
            code_name: "yin-yang-indicator",
            display_name: _("Yin-Yang"),
            description: _("Toggle between light and dark application themes"),
            visible: true
        );
    }

    construct {
        dbusclient = DBusClient.get_default ();
        settings = Services.Settings.get_default ();

        /************************
          Create Indicator Widgets
        ************************/
        display_widget = new Gtk.Image ();
        display_widget.gicon = new ThemedIcon ("com.github.evan-buss.yin-yang-symbolic");
        display_widget.pixel_size = 16;

        popover_widget = new Widgets.PopoverWidget ();

        /************************
          Listen for DBus Events
        ************************/
        // When dbus namespace server opens, show the indicator if set
        dbusclient.yinyang_appeared.connect (() => {
            debug ("yinyang appeared");
            this.visible = settings.enable_auto_switch;
        });

        // When dbus namespace server closes hide the indicator
        dbusclient.yinyang_vanished.connect (() => {
            debug ("yinyang vanished");
            this.visible = false;
        });

        dbusclient.interface.indicator_state.connect ((is_showing) => {
            this.visible = is_showing;
        });

        /************************
          Popover Button Actions
        ************************/
        popover_widget.show_yinyang_button.clicked.connect (() => {
            dbusclient.interface.show_yinyang ();
        });

        popover_widget.quit_yinyang_button.clicked.connect (() => {
            dbusclient.interface.quit_yinyang ();
            this.visible = false;
        });
    }

    /* This method is called to get the widget that is displayed in the top bar */
    public override Gtk.Widget get_display_widget () {
        return display_widget;
    }

    /* This method is called to get the widget that is displayed in the popover */
    public override Gtk.Widget? get_widget () {
        return popover_widget;
    }

    /* This method is called when the indicator popover opened */
    public override void opened () {
        /* Use this method to get some extra information while displaying the indicator */
    }

    /* This method is called when the indicator popover closed */
    public override void closed () {
    }
}

/*
 * This method is called once after your plugin has been loaded.
 * Create and return your indicator here if it should be displayed on the current server.
 */
public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {
    /* A small message for debugging reasons */
    debug ("Activating Yin-Yang Indicator");

    /* Check which server has loaded the plugin */
    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        /* We want to display our monitor indicator only in the "normal" session */
        return null;
    }

    /* Create the indicator */
    var indicator = new YinYang.Indicator ();

    /* Return the newly created indicator */
    return indicator;
}
