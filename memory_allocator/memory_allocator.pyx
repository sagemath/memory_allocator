from .memory cimport *


cdef class MemoryAllocator:
    r"""
    An object for memory allocation, whose resources are freed upon
    ``__dealloc__``.

    EXAMPLES::

        >>> from memory_allocator.test import TestMemoryAllocator
        >>> mem = TestMemoryAllocator()
        >>> for n in range(100):
        ...     ptr = mem.malloc(n)
        ...     _ = mem.realloc(ptr, 2*n)
        ...     _ = mem.calloc(n, n)
        ...     ptr = mem.allocarray(n, n)
        ...     _ = mem.reallocarray(ptr, n + 1, n)
        ...     _ = mem.aligned_malloc(32, (n//32 + 1)*32)
        ...     _ = mem.aligned_calloc(16, n, 16)
        ...     _ = mem.aligned_allocarray(8, n, 8)
    """
    def __cinit__(self):
        """
        EXAMPLES::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> _ = TestMemoryAllocator()
            >>> _ = malloc(10000)
            >>> mem.n()
            1
            >>> mem.size()
            16
        """
        self.n = 0
        self.size = 16
        self.pointers = self.static_pointers

    cdef int resize(self, size_t new_size) except -1:
        r"""
        Resize the list of pointers to contain ``new_size`` elements.

        It is required that ``new_size`` is at least ``self.n``, but
        this condition is not checked.
        """
        cdef size_t i
        if self.pointers == self.static_pointers:
            # Case 1: allocate pointers for the first time
            self.pointers = <void**>check_allocarray(new_size, sizeof(void*))
            for i in range(self.n):
                self.pointers[i] = self.static_pointers[i]
        else:
            # Case 2: resize pointers
            self.pointers = <void**>check_reallocarray(self.pointers,
                                                       new_size, sizeof(void*))
        self.size = new_size

    cdef void** find_pointer(self, void* ptr) except NULL:
        r"""
        Return the address in the list of stored pointers where ``ptr``
        is stored. If ``ptr`` is not found in the existing pointers and
        ``ptr`` is not ``NULL``, then an exception is raised. If ``ptr``
        is ``NULL``, then we simply add ``NULL`` as an additional
        pointer and return the address of that.
        """
        cdef size_t i = 0
        for i in range(self.n):
            if self.pointers[i] == ptr:
                return &self.pointers[i]
        if ptr != NULL:
            raise ValueError("given pointer not found in MemoryAllocator")
        self.enlarge_if_needed()
        addr = &self.pointers[self.n]
        self.n += 1
        return addr

    cdef void* malloc(self, size_t size) except? NULL:
        r"""
        Returns a new pointer and stores it to be automatically freed later.
        """
        self.enlarge_if_needed()
        cdef void* val = check_malloc(size)
        self.pointers[self.n] = val
        self.n += 1
        return val

    cdef void* calloc(self, size_t nmemb, size_t size) except? NULL:
        r"""
        Returns a new pointer and stores it to be automatically freed later.
        """
        self.enlarge_if_needed()
        cdef void* val = check_calloc(nmemb, size)
        self.pointers[self.n] = val
        self.n += 1
        return val

    cdef void* allocarray(self, size_t nmemb, size_t size) except? NULL:
        r"""
        Returns a new pointer and stores it to be automatically freed later.
        """
        self.enlarge_if_needed()
        cdef void* val = check_allocarray(nmemb, size)
        self.pointers[self.n] = val
        self.n += 1
        return val

    cdef void* realloc(self, void* ptr, size_t size) except? NULL:
        r"""
        Re-allocates `ptr` and automatically frees it later.
        """
        cdef void** addr = self.find_pointer(ptr)
        cdef void* val = check_realloc(ptr, size)
        addr[0] = val
        return val

    cdef void* reallocarray(self, void* ptr, size_t nmemb,
                            size_t size) except? NULL:
        r"""
        Re-allocates `ptr` and automatically frees it later.
        """
        cdef void** addr = self.find_pointer(ptr)
        cdef void* val = check_reallocarray(ptr, nmemb, size)
        addr[0] = val
        return val

    def __dealloc__(self):
        r"""
        Free the allocated resources

        EXAMPLES::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> _ = TestMemoryAllocator()
        """
        cdef size_t i
        for i in range(self.n):
            sig_free(self.pointers[i])
        if self.pointers != self.static_pointers:
            sig_free(self.pointers)
