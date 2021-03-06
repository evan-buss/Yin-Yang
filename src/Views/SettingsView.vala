namespace YinYang.Views {

    public class SettingsView : Gtk.Box {

        public Services.Settings settings;
        public Gee.ArrayList<Plugins.Plugin> plugin_list;

        public SettingsView () {
            Object (
                hexpand: false,
                orientation: Gtk.Orientation.VERTICAL,
                margin: 8
            );

            settings = Services.Settings.get_default ();
        }

        construct {
            /************************
              View Title
            ************************/
            var header_label = new Gtk.Label (_("Theme Settings"));
            header_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            header_label.halign = Gtk.Align.CENTER;

            /************************
              Initialize Plugins
            ************************/
            plugin_list = new Gee.ArrayList<Plugins.Plugin> ();
            plugin_list.add (new Plugins.DesktopTheme ());
            plugin_list.add (new Plugins.GtkTheme ());
            plugin_list.add (new Plugins.VSCodeTheme ());
            plugin_list.add (new Plugins.TerminalTheme ());
            plugin_list.add (new Plugins.CodeTheme ());
            plugin_list.add (new Plugins.FirefoxTheme ());
            plugin_list.add (new Plugins.Wallpaper ());

            /************************
              Attach To Grid
            ************************/
            for (int i = 0; i < plugin_list.size; i++) {
                add (plugin_list.get (i));
            }
        }
    }
}
