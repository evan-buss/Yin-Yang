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
            //  var desktop_theme = new Plugins.DesktopTheme ();
            //  var gtk_theme = new Plugins.GtkTheme ();
            //  var vscode_theme = new Plugins.VSCodeTheme ();
            //  var terminal_theme = new Plugins.TerminalTheme ();
            //  var code_theme = new Plugins.CodeTheme ();
            //  var firefox_theme = new Plugins.FirefoxTheme ();


            /************************
              Attach To Grid
            ************************/
            //  foreach (Gtk.Grid plugin in pluginList) {
            //      attach (header_label, 0, 0, 2, 1);
            //  }

            for (int i = 0; i < pluginList.size; i++) {
                attach (pluginList.get(i), 0, i, 2, 1);
            }

            //  attach (header_label, 0, 0, 2, 1);
            //  attach (desktop_theme, 0, 1, 1, 1);
            //  attach (gtk_theme, 0, 2, 1, 1);
            //  attach (vscode_theme, 0, 3, 1, 1);
            //  attach (terminal_theme, 0, 4, 1, 1);
            //  attach (code_theme, 0, 5, 1, 1);
            //  attach (firefox_theme, 0, 6, 1, 1);
        }
    }
}
