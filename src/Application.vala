public class MyApp : Gtk.Application {

  public MyApp () {
      Object (
          application_id: "com.github.evan-buss.twentytwo",
          flags: ApplicationFlags.FLAGS_NONE
      );
  }

  protected override void activate () {
      var main_window = new Gtk.ApplicationWindow (this);
      var label = new Gtk.Label (_("Hello World"));
      main_window.add (label);
      main_window.default_height = 480;
      main_window.default_width = 640;
      main_window.title = "App Template";
      main_window.show_all ();

  }

  public static int main (string[] args) {
      var app = new MyApp ();
      return app.run (args);
  }
}
