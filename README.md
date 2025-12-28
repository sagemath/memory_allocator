# MemoryAllocator
An extension class to allocate memory easily with cython.

This extension class started as part of the [Sage](https://sagemath.org) software.

It provides a single extension class `MemoryAllocator` with `cdef` methods

- `malloc`,
- `calloc`,
- `allocarray`,
- `realloc`,
- `reallocarray`,
- `aligned_malloc`,
- `aligned_calloc`,
- `aligned_allocarray`.

Memory is freed when the instance of `MemoryAllocator` is deallocated.
On failure to allocate the memory, a proper error is raised.

## Building from source

This project uses [meson-python](https://mesonbuild.com/meson-python/) for
its build backend. A typical editable install looks like:

```shell
  python -m pip install -e .
```

# Changelog

## 0.1.5
- Migrate build system to Meson.
- Require Python >= 3.12.


## 0.1.4

- Modernize Python metadata, require Python >= 3.8.
  [#9](https://github.com/sagemath/memory_allocator/pull/9) by @mkoeppe
- Add missing `noexcept` clauses for Cython 3
  [#8](https://github.com/sagemath/memory_allocator/pull/8) by @tornaria

## 0.1.3

- Python 3.11 compatible.

## 0.1.2

- Provide wheels build by github actions.

## 0.1.1

- Fixed doctests on 32bit systems.
