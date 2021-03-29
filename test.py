import cydoctest

# The actual tests.

cydoctest.testmod(memory_allocator.test, verbose=True)
cydoctest.testmod(memory_allocator.memory_allocator, verbose=True)
