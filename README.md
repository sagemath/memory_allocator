# MemoryAllocator
An extension class to allocate memory easily with cython.

This extension class started as part of the [Sage](https://sagemath.org) software.

It provides a single extension class `MemoryAllocator` with `cdef` methods

- `malloc`,
- `calloc`,
- `alloarray`,
- `realloc`,
- `reallocarray`,
- `aligned_malloc`,
- `aligned_calloc`,
- `aligned_allocarray`.

Memory is freed when the instance of `MemoryAllocator` is deallocated.
On failure to allocate the memory, a proper error is raised.

# Changelog

## 0.1.3

- Python 3.11 compatible.

## 0.1.2

- Provide wheels build by github actions.

## 0.1.1

- Fixed doctests on 32bit systems.
