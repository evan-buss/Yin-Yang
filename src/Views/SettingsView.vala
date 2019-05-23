namespace YinYang.Views {

    public class SettingsView : Gtk.Grid {
        public SettingsView () {
            Object (
                halign: Gtk.Align.CENTER,
                margin: 8
            );
        }

        construct {
            var header_label = new Granite.HeaderLabel ("Settings View");
            attach (header_label, 0, 0, 1, 1);
        }
    }
}
