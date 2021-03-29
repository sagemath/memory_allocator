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

try:
    from cysignals.tests import test_sig_check
    _ = test_sig_check()
    has_cysignals = True
except ModuleNotFoundError:
    has_cysignals = False

extensions = [
    Extension("memory_allocator.memory_allocator", sources=["memory_allocator/memory_allocator.pyx"]),
    Extension("memory_allocator.test", sources=["memory_allocator/test.pyx"]),
    (Extension("memory_allocator.signals", sources=["memory_allocator/signals.pyx"])
        if has_cysignals else
        Extension("memory_allocator.signals", sources=["memory_allocator/signals_backup.pyx"])),
    ]

setup(
    name='memory_allocator',
    version='0.1.0',
    description='An extension class to allocate memory easily with cython',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/kliem/memory_allocator',
    author='Jonathan Kliem',
    author_email='jonathan.kliem@gmail.com',
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
        'Topic :: Scientific/Engineering :: Mathematics']
    )
