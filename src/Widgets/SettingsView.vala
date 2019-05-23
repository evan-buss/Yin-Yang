namespace YinYang {

    public class SettingsView : Gtk.Grid {
        public SettingsView () {
            Object (
                halign: Gtk.Align.CENTER,
                valign: Gtk.Align.CENTER,
                margin: 8
            );
        }

        construct {
            var header_label = new Granite.HeaderLabel ("Header Label");
            attach (header_label, 0, 0, 1, 1);
        }
    }
}
