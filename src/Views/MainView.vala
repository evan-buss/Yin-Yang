namespace YinYang.Views {

    public class MainView : Gtk.Grid {

        public Gtk.ApplicationWindow window { get; construct; }
        //  public Settings settings { get; construct; }
        private Services.Settings settings;

        public MainView (Gtk.ApplicationWindow window) {
            Object (
                halign: Gtk.Align.CENTER,
                //  valign: Gtk.Align.CENTER,
                margin: 8,
                window: window
            );
        }

        construct {
            settings = Services.Settings.get_default();

            /************************
              Application Logo
            ************************/
            Gdk.Pixbuf app_icon_pix_buf = null;
            Gtk.Image app_icon = null;
            try {
                app_icon_pix_buf =
                    new Gdk.Pixbuf.from_resource_at_scale ("/com/github/evan-buss/yin-yang/img/logo.svg", 150, -1, true);
                app_icon = new Gtk.Image.from_pixbuf (app_icon_pix_buf);
                app_icon.margin = 20;
            } catch (Error e) {
                debug ("unable to load logo image");
            }
            /************************
              Mode Toggle Area
            ************************/
            var header_label = new Gtk.Label ("Select Mode");
            header_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            var mode_toggle = new Granite.Widgets.ModeButton ();
            mode_toggle.append_text ("Light");
            mode_toggle.append_text ("Dark");
            mode_toggle.set_active ( settings.dark_mode ? 1 : 0);

            mode_toggle.mode_changed.connect (() => {
                if (mode_toggle.selected == 1) {
                    settings.dark_mode = true;
                    Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", true);
                } else {
                    settings.dark_mode = false;
                    Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", false);
                }
            });


            attach (app_icon, 0, 0, 1, 1);
            attach (header_label, 0, 1, 1, 1);
            attach (mode_toggle, 0, 2, 1, 1);
        }
    }
}
