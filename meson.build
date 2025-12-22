project(
    'memory_allocator',
    'c', 'cython',
    meson_version: '>=1.2.0',
)
# Python
py_module = import('python')
py = py_module.find_installation(pure: false)
py_dep = py.dependency()

py.install_sources(
    'memory_allocator/__init__.py',
    'memory_allocator/__init__.pxd',
    'memory_allocator/memory_allocator.pxd',
    'memory_allocator/memory.pxd',
    'memory_allocator/signals.pxd',
    subdir: 'memory_allocator',
)

extensions = {
    'memory_allocator': files('memory_allocator/memory_allocator.pyx'),
    'test': files('memory_allocator/test.pyx'),
}

src = include_directories('memory_allocator')
foreach name, pyx : extensions
    py.extension_module(name,
        pyx,
        include_directories: [src],
        dependencies: [py_dep],
        install: true,
        subdir: 'memory_allocator'
    )
endforeach
