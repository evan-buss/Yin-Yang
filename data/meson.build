install_data(
    install_dir: join_paths(get_option('datadir'), 'img')
)

# This line was giving me errors... not sure if needed
# join_paths('img', meson.project_name() + '.svg'),

install_data (
    'gschema.xml',
    install_dir: join_paths (get_option ('datadir'), 'glib-2.0', 'schemas'),
    rename: meson.project_name () + '.gschema.xml'
)
