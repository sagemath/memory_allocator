# MemoryAllocator
An extension class to allocate memory easily with cython.

This extension class started as part of the `Sage <http://sagemath.org>`_ software.

It provides a single extension class `MemoryAllocator` with `cdef` methods

- `malloc`,
- `calloc`,
- `alloarray`,
- `realloc`,
- `reallocarray`,
- `aligned_malloc`,
- `aligned_calloc`,
- `aligned_allocarray`.
