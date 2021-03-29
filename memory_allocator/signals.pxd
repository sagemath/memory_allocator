# ``memory.pxd`` is symlinked to the version in ``cysignals``.
# This way we avoid code duplication while not depending on ``cysignals`` to be installed.

# Usage of ``sig_block`` / ``sig_unblock`` is not necesarry for ``MemoryAllocator``:
# One should not wrap its methods with ``sig_on`` ... ``sig_off`` anyway.

cdef inline void sig_block() nogil:
    pass

cdef inline void sig_unblock() nogil:
    pass
