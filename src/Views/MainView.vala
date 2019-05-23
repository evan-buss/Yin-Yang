namespace YinYang.Views {

    public class MainView : Gtk.Grid {

        public Gtk.ApplicationWindow window { get; construct; }

        public MainView (Gtk.ApplicationWindow window) {
            Object (
                halign: Gtk.Align.CENTER,
                margin: 8,
                window: window
            );
        }

        construct {
            var header_label = new Gtk.Label ("Select Mode");
            header_label.get_style_context ().add_class (Granite.STYLE_CLASS_H4_LABEL);

            var mode_toggle = new Granite.Widgets.ModeButton ();
            mode_toggle.append_text ("Light");
            mode_toggle.append_text ("Dark");

            mode_toggle.mode_changed.connect (() => {
                //  Dark mode selected
                if (mode_toggle.selected == 1) {
                    make_dark ();
                } else {
                    //  Light Mode selected
                    make_light ();
                }
            });

            attach (header_label, 0, 0, 1, 1);
            attach (mode_toggle, 0, 1, 1, 1);
        }

        //  TODO: Make body text stand out on light background
        //  FIXME: Figure out how to get the default color themes...
        private void make_dark () {
            window.get_style_context().remove_class ("make-white");
            window.get_titlebar ().get_style_context ().add_class ("light-header");
            Granite.Widgets.Utils.set_color_primary (window, {222, 222, 222, 255});
        }

        private void make_light () {
            window.get_style_context().add_class ("make-white");
            window.get_titlebar ().get_style_context ().remove_class ("light-header");
            Granite.Widgets.Utils.set_color_primary (window, {0, 0, 0, 255});
        }
    }
}
