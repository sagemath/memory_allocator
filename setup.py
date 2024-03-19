from setuptools import setup, find_packages
from setuptools.extension import Extension
from distutils.command.build_ext import build_ext as du_build_ext


class build_ext(du_build_ext):
    def run(self):
        from Cython.Build.Dependencies import cythonize
        self.distribution.ext_modules[:] = cythonize(
            self.distribution.ext_modules,
            language_level=3)
        du_build_ext.run(self)


extensions = [
    Extension(
        "memory_allocator.memory_allocator",
        sources=["memory_allocator/memory_allocator.pyx"]),
    Extension(
        "memory_allocator.test",
        sources=["memory_allocator/test.pyx"]),
    ]


setup(
    packages=find_packages(),
    ext_modules=extensions,
)
