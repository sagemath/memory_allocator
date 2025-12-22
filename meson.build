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
    'src/memory_allocator/__init__.py',
    'src/memory_allocator/__init__.pxd',
    'src/memory_allocator/memory_allocator.pxd',
    'src/memory_allocator/memory.pxd',
    'src/memory_allocator/signals.pxd',
    subdir: 'memory_allocator',
)

extensions = {
    'memory_allocator': files('src/memory_allocator/memory_allocator.pyx'),
    'test': files('src/memory_allocator/test.pyx'),
}

src = include_directories('src/memory_allocator')
foreach name, pyx : extensions
    py.extension_module(name,
        pyx,
        include_directories: [src],
        dependencies: [py_dep],
        install: true,
        subdir: 'memory_allocator'
    )
endforeach
