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

[DBus (name = "com.github.evan_buss.yin_yang")]
public interface YinYang.DBusClientInterface : Object {
    public abstract void quit_yinyang () throws IOError;
    public abstract void show_yinyang () throws IOError;
    public signal void indicator_state (bool is_showing);
}

public class YinYang.DBusClient : Object {

    private const string DBUS_NAME = "com.github.evan_buss.yin_yang";
    private const string DBUS_PATH = "/com/github/evan_buss/yin_yang";

    public DBusClientInterface? interface = null;

    private static GLib.Once<DBusClient> instance;

    public static unowned DBusClient get_default () {
        return instance.once (() => { return new DBusClient (); });
    }

    public signal void yinyang_vanished ();
    public signal void yinyang_appeared ();

    construct {
        try {
            interface = Bus.get_proxy_sync (
                BusType.SESSION,
                DBUS_NAME,
                DBUS_PATH
            );

            Bus.watch_name (
                BusType.SESSION,
                DBUS_NAME,
                BusNameWatcherFlags.NONE,
                () => yinyang_appeared (),
                () => yinyang_vanished ()
            );
        } catch (IOError e) {
            error ("Yin-Yang Indicator DBus: %s\n", e.message);
        }
    }
}
