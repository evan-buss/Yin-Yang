icon_sizes = ['16','24','32', '48', '64', '128']

# Install icons
foreach i : icon_sizes
    install_data(
        join_paths('images', 'icons', i, meson.project_name() + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', i + 'x' + i, 'apps')
    )
endforeach

install_data(
    join_paths('images', meson.project_name() + '.svg'),
    install_dir: join_paths(get_option('datadir'), 'app', 'images')
)

# install_data(
#     join_paths('images', meson.project_name() + '.png'),
#     install_dir: join_paths(get_option('datadir'), 'pixmaps')
# )

# install_data(
#     install_dir: join_paths(get_option('datadir'), 'images')
# )

# This line was giving me errors... not sure if needed
# join_paths('img', meson.project_name() + '.svg'),

install_data(
    meson.project_name() + '.gschema.xml',
    install_dir: join_paths(get_option('datadir'), 'glib-2.0', 'schemas')
)
