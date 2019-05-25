namespace YinYang.Services {
    public class Settings : Granite.Services.Settings {
        private static GLib.Once<Settings> instance;
        public static unowned Settings get_default () {
            return instance.once (() => { return new Settings (); });
        }

        public bool dark_mode { get; set; }
        public bool enable_dark_desktop { get; set; }

        //  public int window_width { get; set; }
        //  public int window_height { get; set; }
        //  public bool is_maximized { get; set; }

        //  public bool indicator_state { get; set; }

        //  public bool background_state { get; set; }

        construct {
            // Controls the default application theme mode
             if (dark_mode) {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", true);
            } else {
                Gtk.Settings.get_default ().set ("gtk-application-prefer-dark-theme", false);
            }
        }

        private Settings ()  {
            base ("com.github.evan-buss.yin-yang.settings");
        }
    }
}
