# Backup version, if cysignals is not available.
# In this case, ``sig_block/sig_unblock`` is not useful anyway.

cdef void sig_block() nogil:
    pass

cdef void sig_unblock() nogil:
    pass
