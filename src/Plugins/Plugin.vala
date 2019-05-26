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

/*
     Base class that defines the standard methods and fields of all plugins
*/
namespace YinYang.Plugins {

    //  Each plugin is a grid of widgets that control the individual settings
    public class Plugin : Gtk.Grid {

        //  Each plugin has access to the global settings service to load existing
        //   user preferences.
        public Services.Settings settings;

        public Plugin () {
        }

        construct {
            settings = Services.Settings.get_default ();
        }

        //  Each plugin must override this method to toggle the plugin dark mode
        //  These methods are responsible for determining if the user has enabled
        //  your plugin or not
        public virtual void set_dark () {
            message ("default set_dark method");
        }

        //  Each plugin must override this method to toggle the plugin light mode
        //  These methods are responsible for determining if the user has enabled
        //  your plugin or not
        public virtual void set_light () {
            message ("default set_light method");
        }
    }
}
