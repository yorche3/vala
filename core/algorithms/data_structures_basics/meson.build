project('data_structures_basics', ['c', 'vala'],
  version : '0.1')

dependencies = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
]

# These arguments are only used to build the shared library
# not the executables that use the library.
shlib = shared_library('foo', 'data_structures_basics.vala',
               dependencies: dependencies,
               install: true,
               install_dir: [true, true, true])

test_exe = executable('data_structures_basics_test', 'data_structures_basics_test.vala', dependencies : dependencies,
  link_with : shlib)
test('data_structures_basics', test_exe)

# Make this library usable as a Meson subproject.
data_structures_basics_dep = declare_dependency(
  include_directories: include_directories('.'),
  link_with : shlib)
