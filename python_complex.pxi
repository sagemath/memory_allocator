cdef extern from "Python.h":
    ctypedef void PyObject
    ctypedef struct Py_complex

    ############################################################################
    # 7.2.5.2 Complex Numbers as Python Objects
    ############################################################################

    # PyComplexObject
    # This subtype of PyObject represents a Python complex number object.

    # PyTypeObject PyComplex_Type
    # This instance of PyTypeObject represents the Python complex
    # number type. It is the same object as complex and
    # types.ComplexType.

    int PyComplex_Check(object p)
    # Return true if its argument is a PyComplexObject or a subtype of
    # PyComplexObject.

    int PyComplex_CheckExact(object p)
    # Return true if its argument is a PyComplexObject, but not a subtype of PyComplexObject.

    object PyComplex_FromCComplex(Py_complex v)
    # Return value: New reference.
    # Create a new Python complex number object from a C Py_complex value.

    object PyComplex_FromDoubles(double real, double imag)
    # Return value: New reference.
    # Return a new PyComplexObject object from real and imag.

    double PyComplex_RealAsDouble(object op)
    # Return the real part of op as a C double.

    double PyComplex_ImagAsDouble(object op)
    # Return the imaginary part of op as a C double.

    Py_complex PyComplex_AsCComplex(object op)
    # Return the Py_complex value of the complex number op.
