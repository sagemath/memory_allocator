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


with open("README.md", "r", encoding="utf-8") as fh:
    long_description = fh.read()

extensions = [
    Extension(
        "memory_allocator.memory_allocator",
        sources=["memory_allocator/memory_allocator.pyx"]),
    Extension(
        "memory_allocator.test",
        sources=["memory_allocator/test.pyx"]),
    ]

setup(
    name='memory_allocator',
    version='0.1.3',
    description='An extension class to allocate memory easily with cython',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/sagemath/memory_allocator',
    author='Jeroen Demeyer, Nathann Cohen, Jonathan Kliem',
    author_email='sage-devel@googlegroups.com',
    license='GPLv3',
    packages=find_packages(),
    ext_modules=extensions,
    zip_safe=False,
    python_requires='>=3.6',
    package_dir={'memory_allocator': 'memory_allocator'},
    install_requires=["Cython"],
    package_data={"memory_allocator": ["*.pxd"]},
    cmdclass={'build_ext': build_ext},
    classifiers=[
        'Development Status :: 2 - Pre-Alpha',
        'Intended Audience :: Science/Research',
        'License :: OSI Approved :: GNU General Public License v3 (GPLv3)',
        'Programming Language :: Python :: 3',
        'Programming Language :: Cython',
        'Topic :: Scientific/Engineering :: Mathematics']
    )
