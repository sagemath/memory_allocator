from cysignals.signals cimport sig_block as cysignals_sig_block
from cysignals.signals cimport sig_unblock as cysignals_sig_unblock

cdef void sig_block() nogil:
    cysignals_sig_block()

cdef void sig_unblock() nogil:
    cysignals_sig_unblock()
