[DBus (name = "com.github.evan_buss.yin_yang")]
public interface YinYang.DBusClientInterface : Object {
    public abstract void quit_yinyang () throws IOError;
    public abstract void show_yinyang_window () throws IOError;
}

public class YinYang.DBusClient : Object{

    private const string DBUS_NAME = "com.github.evan_buss.yin_yang";
    private const string DBUS_PATH = "/com/github/evan_buss/yin_yang";

    public DBusClientInterface? interface = null;

    private static GLib.Once<DBusClient> instance;

    public static unowned DBusClient get_default () {
        return instance.once (() => { return new DBusClient (); });
    }

    public signal void yinyang_vanished ();
    public signal void yinyang_appeared ();

    construct {
        try {
            interface = Bus.get_proxy_sync (
                BusType.SESSION,
                DBUS_NAME,
                DBUS_PATH
            );

            Bus.watch_name (
                BusType.SESSION,
                DBUS_NAME,
                BusNameWatcherFlags.NONE,
                () => yinyang_appeared (),
                () => yinyang_vanished ()
            );
        } catch (IOError e) {
            error ("Yin-Yang Indicator DBus: %s\n", e.message);
        }
    }
}
