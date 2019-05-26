namespace YinYang.Views {

    public class SettingsView : Gtk.Grid {

        public Services.Settings settings;
        public Gee.ArrayList<Plugins.Plugin> pluginList;

        public SettingsView () {
            Object (
                halign: Gtk.Align.START,
                margin: 8
            );

            settings = Services.Settings.get_default ();
        }

        construct {
            /************************
              View Title
            ************************/
            var header_label = new Gtk.Label ("Theme Settings");
            header_label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
            header_label.halign = Gtk.Align.CENTER;

            /************************
              Initialize Plugins
            ************************/
            pluginList = new Gee.ArrayList<Plugins.Plugin>();
            pluginList.add(new Plugins.DesktopTheme ());
            pluginList.add(new Plugins.GtkTheme ());
            pluginList.add(new Plugins.VSCodeTheme ());
            pluginList.add(new Plugins.TerminalTheme ());
            pluginList.add(new Plugins.CodeTheme ());
            pluginList.add(new Plugins.FirefoxTheme ());

            /************************
              Attach To Grid
            ************************/
            for (int i = 0; i < pluginList.size; i++) {
                attach (pluginList.get(i), 0, i, 2, 1);
            }
        }
    }
}
