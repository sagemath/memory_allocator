from .memory_allocator cimport MemoryAllocator


cdef class TestMemoryAllocator():
    cdef MemoryAllocator mem

    def __init__(self):
        self.mem = MemoryAllocator()

    def malloc(self, size):
        return <size_t> self.mem.malloc(size)

    def calloc(self, nmemb, size):
        return <size_t> self.mem.calloc(nmemb, size)

    def allocarray(self, nmemb, size):
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
