# Yin-Yang for Elementary OS

> Yin-Yang brings automatic day and night theme-switching to Elementary OS

<p align="center">
    <img align="center" src="https://raw.githubusercontent.com/evan-buss/Yin-Yang/master/screenshots/screenshot_1.png" alt="dark_mode">
</p>

<p align="center">
    <table>
      <tr>
        <td>
          <img src="https://raw.githubusercontent.com/evan-buss/Yin-Yang/master/screenshots/screenshot_2.png" alt="light_mode">
        </td>
        <td>
          <img src="https://raw.githubusercontent.com/evan-buss/Yin-Yang/master/screenshots/screenshot_3.png" alt="theme settings">
        </td>
      </tr>
    </table>
</p>

## Implemented and Upcoming Features
- [x] Switch between day and night theme presets
- [x] GTK Theme Switching
- [x] Gtk "Prefer-dark" switching
- [x] Visual Studio Code Theme Switching
- [x] Pantheon Terminal Theme Switching
- [X] Pantheon Code Editor Theme Switching
- [X] Firefox Theme Switching
- [X] Wallpaper Background Switching
- [X] Automatic theme switching when nightlight is enabled
- [X] Wingpanel Integration
- [X] Custom Icon (Desktop and Wingpanel)
- [ ] Notifications

## Building, Testing, and Installation

You'll need the following dependencies:
* meson
* valac
* libgtk-3-dev (>= 3.10)
* libunity-dev
* libgranite-dev
* libjson-glib-dev
* libwingpanel-2.0-dev
* libunity-dev

Run `meson build` to configure the build environment. Change to the build directory and run `ninja` to build

    meson build --prefix=/usr
    cd build
    ninja

To test without installing, use `ninja`, then execute with `./com.github.evan-buss.yin-yang`

    ninja
    ./com.github.evan-buss.yin-yang

To install, use `ninja install`, then execute with `com.github.evan-buss.yin-yang`

    sudo ninja install
    com.github.evan-buss.yin-yang


## Future Integrations

If you have any requests or suggestions for application theme switching integrations just submit an issue.

## Credit

Thanks to [Yin-Yang](https://github.com/daehruoydeef/Yin-Yang) for the inspiration and original design.
