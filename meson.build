# project name and programming language
project('com.github.evan-buss.yin-yang', 'vala', 'c')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

# Compile GResources
gnome = import('gnome')
gresource = gnome.compile_resources(
    'as-resources', 'data/com.github.evan-buss.yin-yang.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

# Main application executable
executable(
    meson.project_name(),
    'src/Application.vala',
    'src/YinYangWindow.vala',

    'src/Services/Settings.vala',
    'src/Services/DBusServer.vala',
    'src/Services/BackgroundManager.vala',

    'src/Views/SettingsView.vala',
    'src/Views/MainView.vala',

    'src/Plugins/Plugin.vala',
    'src/Plugins/DesktopTheme.vala',
    'src/Plugins/GtkTheme.vala',
    'src/Plugins/VSCodeTheme.vala',
    'src/Plugins/TerminalTheme.vala',
    'src/Plugins/CodeTheme.vala',
    'src/Plugins/FirefoxTheme.vala',
    'src/Plugins/Wallpaper.vala',
    gresource,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite'),
        dependency('json-glib-1.0'),
    ],
    install: true
)

wingpanel_dep = dependency('wingpanel-2.0')

# Wingpanel Indicator Executable
shared_module(
    'yinyang',
    'src/Indicator/Indicator.vala',
    'src/Indicator/Widgets/PopoverWidget.vala',
    'src/Indicator/Services/DBusClient.vala',
    'src/Services/Settings.vala',
    gresource,
    dependencies: [
        dependency('glib-2.0'),
        dependency('gobject-2.0'),
        dependency('granite'),
        dependency('gtk+-3.0'),
        wingpanel_dep
    ],
    install: true,
    install_dir : wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
)

#Translate and install our .desktop file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.desktop.in'),
    output: meson.project_name() + '.desktop',
    po_dir: join_paths(meson.source_root(), 'po'),
    type: 'desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications')
)

#Translate and install our .appdata file
i18n.merge_file(
    input: join_paths('data', meson.project_name() + '.appdata.xml.in'),
    output: meson.project_name() + '.appdata.xml',
    po_dir: join_paths(meson.source_root(), 'po'),
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo')
)

subdir('po')
subdir('data')

# Install GSchema
meson.add_install_script('meson/post_install.py')
