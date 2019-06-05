# Project Name and Programming Language
project('com.github.evan-buss.22', 'vala', 'c')

# Include the translations module
i18n = import('i18n')

# Set our translation domain
add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

# Include gnome for gresources and gschema
gnome = import('gnome')
# Compile GResources
gresource = gnome.compile_resources(
    'as-resources', 'data/com.github.evan-buss.22.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

subdir('data')
subdir('src')

dependencies = [
    dependency('gtk+-3.0'),
    dependency('granite'),
]

# Main application executable
executable(
    meson.project_name(),
    sources,
    gresource,
    dependencies: dependencies,
    install: true
)

# wingpanel_dep = dependency('wingpanel-2.0')

# Wingpanel Indicator Executable
# shared_module(
#     'app',
#     'src/Indicator/Indicator.vala',
#     'src/Indicator/Widgets/PopoverWidget.vala',
#     gresource,
#     dependencies: [
#         dependency('glib-2.0'),
#         dependency('gobject-2.0'),
#         dependency('granite'),
#         dependency('gtk+-3.0'),
#         wingpanel_dep
#     ],
#     install: true,
#     install_dir : wingpanel_dep.get_pkgconfig_variable('indicatorsdir')
# )

subdir('po')

meson.add_install_script('meson/post_install.py')

# Translation commands
# ninja com.github.evan-buss.22-update-po
# ninja com.github.evan-buss.22-pot
