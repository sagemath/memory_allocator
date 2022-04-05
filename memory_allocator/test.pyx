from .memory_allocator cimport MemoryAllocator


cdef class TestMemoryAllocator():
    cdef MemoryAllocator mem

    def __init__(self):
        self.mem = MemoryAllocator()

    def malloc(self, size):
        """
        TESTS::

        >>> from memory_allocator.test import TestMemoryAllocator
        >>> mem = TestMemoryAllocator()
        >>> _ = mem.malloc(100)
        >>> mem.malloc(mem.size_t_max())
        Traceback (most recent call last):
        ...
        MemoryError: failed to allocate ... bytes
        """
        return <size_t> self.mem.malloc(size)

    def calloc(self, nmemb, size):
        """
        TESTS::

        >>> from memory_allocator.test import TestMemoryAllocator
        >>> mem = TestMemoryAllocator()
        >>> _ = mem.calloc(100, 10)
        >>> mem.calloc(mem.size_t_max(), 1)
        Traceback (most recent call last):
        ...
        MemoryError: failed to allocate ... * 1 bytes
        """
        return <size_t> self.mem.calloc(nmemb, size)

    def allocarray(self, nmemb, size):
        """
        TESTS::

        >>> from memory_allocator.test import TestMemoryAllocator
        >>> mem = TestMemoryAllocator()
        >>> _ = mem.allocarray(100, 10)
        >>> mem.allocarray(mem.size_t_max(), 1)
        Traceback (most recent call last):
        ...
        MemoryError: failed to allocate ... * 1 bytes
        """
        return <size_t> self.mem.allocarray(nmemb, size)

    def realloc(self, size_t ptr, size):
        """
        TESTS::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> def test_realloc_good():
            ...     mem = TestMemoryAllocator()
            ...     ptr = mem.malloc(20)
            ...     mem.realloc(ptr, 21)
            >>> def test_realloc_NULL():
            ...     mem = TestMemoryAllocator()
            ...     mem.realloc(0, 21)
            >>> def test_realloc_bad():
            ...     mem = TestMemoryAllocator()
            ...     mem2 = TestMemoryAllocator()
            ...     ptr = mem.malloc(20)
            ...     mem2.realloc(ptr, 21)
            >>> test_realloc_good()
            >>> test_realloc_NULL()
            >>> test_realloc_bad()
            Traceback (most recent call last):
            ...
            ValueError: given pointer not found in MemoryAllocator
        """
        return <size_t> self.mem.realloc(<void*> ptr, size)

    def reallocarray(self, size_t ptr, nmemb, size):
        """
        TESTS::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> def test_reallocarray_good():
            ...     mem = TestMemoryAllocator()
            ...     ptr = mem.allocarray(20, 8)
            ...     mem.reallocarray(ptr, 21, 8)
            >>> def test_reallocarray_NULL():
            ...     mem = TestMemoryAllocator()
            ...     mem.reallocarray(0, 21, 8)
            >>> def test_reallocarray_bad():
            ...     mem = TestMemoryAllocator()
            ...     mem2 = TestMemoryAllocator()
            ...     ptr = mem.allocarray(20, 8)
            ...     mem2.reallocarray(ptr, 21, 8)
            >>> test_reallocarray_good()
            >>> test_reallocarray_NULL()
            >>> test_reallocarray_bad()
            Traceback (most recent call last):
            ...
            ValueError: given pointer not found in MemoryAllocator
        """
        return <size_t> self.mem.reallocarray(<void*> ptr, nmemb, size)

    def aligned_malloc(self, alignment, size):
        """
        TESTS::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> mem = TestMemoryAllocator()
            >>> for i in range(12):
            ...     ptr = mem.aligned_malloc(2**i, 4048)
            ...     assert ptr == ptr & ~(2**i-1)
        """
        return <size_t> self.mem.aligned_malloc(alignment, size)

    def aligned_calloc(self, alignment, nmemb, size):
        """
        TESTS::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> mem = TestMemoryAllocator()
            >>> for i in range(12):
            ...     ptr = mem.aligned_calloc(2**i, i, 4048)
            ...     assert ptr == ptr & ~(2**i-1)
        """
        return <size_t> self.mem.aligned_calloc(alignment, nmemb, size)

    def aligned_allocarray(self, alignment, nmemb, size):
        """
        TESTS::

            >>> from memory_allocator.test import TestMemoryAllocator
            >>> mem = TestMemoryAllocator()
            >>> for i in range(12):
            ...     ptr = mem.aligned_allocarray(2**i, i, 4048)
            ...     assert ptr == ptr & ~(2**i-1)
        """
        return <size_t> self.mem.aligned_allocarray(alignment, nmemb, size)

    def n(self):
        return self.mem.n

    def size(self):
        return self.mem.size

    def size_t_max(self):
        return <size_t> -1
