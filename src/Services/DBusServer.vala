[DBus (name = "com.github.evan_buss.yin_yang")]
public class YinYang.DBusServer : Object {
    private const string DBUS_NAME = "com.github.evan_buss.yin_yang";
    private const string DBUS_PATH = "/com/github/evan_buss/yin_yang";

    private static GLib.Once<DBusServer> instance;

    public static unowned DBusServer get_default () {
        return instance.once (() => { return new YinYang.DBusServer (); });
    }

    public signal void quit ();
    public signal void show ();

    construct {
        Bus.own_name (
            BusType.SESSION,
            DBUS_NAME,
            BusNameOwnerFlags.NONE,
            (connection) => on_bus_aquired (connection),
            () => { },
            () => stderr.printf ("Error creating dbus session")
        );
    }

    public void quit_yinyang () throws IOError, DBusError {
        quit ();
    }

    public void show_yinyang () throws IOError, DBusError {
        show ();
    }

    private void on_bus_aquired (DBusConnection conn) {
        try {
            conn.register_object (DBUS_PATH, get_default ());
        } catch (Error e) {
            message ("Could not register dbus");
            error (e.message);
        }
    }
}

[DBus (name = "com.github.evan-buss.yin-yang.dbus")]
public errordomain DBusServerError {
    SOME_ERROR
}
