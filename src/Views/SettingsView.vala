namespace YinYang.Views {

    public class SettingsView : Gtk.Grid {

        public SettingsView () {
            Object (
                halign: Gtk.Align.START,
                margin: 8
            );
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
            var desktop_theme = new Plugins.DesktopTheme ();

            var gtk_theme = new Plugins.GtkTheme ();
            var vscode_theme = new Plugins.VSCodeTheme ();
            var terminal_theme = new Plugins.TerminalTheme ();
            var code_theme = new Plugins.CodeTheme ();
            var firefox_theme = new Plugins.FirefoxTheme ();


            /************************
              Attach To Grid
            ************************/
            attach (header_label, 0, 0, 2, 1);
            attach (desktop_theme, 0, 1, 1, 1);
            attach (gtk_theme, 0, 2, 1, 1);
            attach (vscode_theme, 0, 3, 1, 1);
            attach (terminal_theme, 0, 4, 1, 1);
            attach (code_theme, 0, 5, 1, 1);
            attach (firefox_theme, 0, 6, 1, 1);
        }
    }
}
