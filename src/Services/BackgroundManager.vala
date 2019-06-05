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


[DBus (name="org.gnome.SettingsDaemon.Color")]
public interface YinYang.ColorInterface : Object {
    public abstract bool night_light_active { get; }
}

namespace YinYang.Services {

    public class BackgroundManager : Object {

        public static BackgroundManager? instance = null;
        private YinYang.ColorInterface interface;
        public signal void active_changed (bool is_dark);

        private BackgroundManager () {}

        construct {
            try {
                interface = Bus.get_proxy_sync (
                    BusType.SESSION,
                    "org.gnome.SettingsDaemon.Color",
                    "/org/gnome/SettingsDaemon/Color",
                    DBusProxyFlags.NONE
                );

                // Emit active_changed(bool) signal when nightlight is enabled
                (interface as DBusProxy).g_properties_changed.connect ((changed, invalid) => {
                    var active = changed.lookup_value ("NightLightActive", new VariantType ("b"));

                    if (active != null) {
                        active_changed (active.get_boolean ());
                    }
                });
            } catch (Error e) {
                warning ("Could not connect to color settings: %s", e.message);
            }
        }

        public static BackgroundManager get_instance () {
            if (instance == null) {
                instance = new BackgroundManager ();
            }
            return instance;
        }

        public bool active {
            get {
                return interface.night_light_active;
            }
        }
    }
}
