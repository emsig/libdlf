import os
import json
import shutil
import pathlib
import subprocess
import numpy as np
from os.path import abspath

# Get git version
version = subprocess.check_output(
    ['git', 'describe', '--tags'], stderr=subprocess.DEVNULL
).strip().decode('utf-8').split('-')
if len(version) > 1 and version[1]:
    version = version[0][1:] + '.dev' + version[1]
else:
    version = version[0][1:]

# Create package directory
path_libdlf = abspath("python/libdlf")
path_lib = os.path.join(path_libdlf, 'lib')
pathlib.Path(path_libdlf).mkdir(parents=True, exist_ok=True)

# Copy library to python package
shutil.copytree(abspath('../lib'), path_lib, dirs_exist_ok=True)

# Copy README
shutil.copyfile('../README.md', 'python/README.md')

# Copy LICENSEs
shutil.copyfile('../LICENSE', 'python/libdlf/lib/LICENSE')
shutil.copyfile('LICENSE', 'python/LICENSE')

# Create setup.py
project = f"""[build-system]
requires = ["setuptools>=64", "setuptools_scm>=8"]
build-backend = "setuptools.build_meta"

[project]
name = "libdlf"
description = "Library for Digital Linear Filters (DLF)"
readme = "README.md"
requires-python = ">=3.10"
authors = [
  {{name = "The emsig community", email = "info@emsig.xyz"}},
]
dependencies = [
    "numpy",
]
classifiers = [
    "Development Status :: 5 - Production/Stable",
    "License :: OSI Approved :: BSD License",
    "Programming Language :: Python",
]
version ="{version}"

[project.license]
file = "LICENSE"

[project.urls]
Homepage = "https://github.com/emsig/libdlf"
Documentation = "https://github.com/emsig/libdlf"
Repository = "https://github.com/emsig/libdlf"

[project.optional-dependencies]
build = [
    "setuptools_scm>=8",
    "setuptools>=64",
]

[tool.setuptools.packages.find]
include = ["libdlf*"]

[tool.flake8]
per-file-ignores = [
    "__init__.py: F401",
]
"""
with open(abspath("python/pyproject.toml"), "w") as fs:
    fs.write(project)

# Create .git_archival.txt
with open(abspath("python/.git_archival.txt"), "w") as fs:
    fs.write("node: $Format:%H$\n")
    fs.write("node-date: $Format:%cI$\n")
    fs.write("describe-name: $Format:%(describe:tags=true,match=*[0-9]*)$")

# Create .gitattributes
with open(abspath("python/.gitattributes"), "w") as fs:
    fs.write(".git_archival.txt  export-subst")

# Create MANIFEST.in
with open(abspath("python/MANIFEST.in"), "w") as fm:
    fm.write("include libdlf/lib/LICENSE\n")
    fm.write("include libdlf/lib/*/*.npz\n")
    fm.write("include LICENSE\n")
    fm.write("exclude MANIFEST.in\n")
    fm.write("exclude .git_archival.txt\n")
    fm.write("exclude .gitattributes")

# Read json
with open(os.path.join(path_lib, 'filters.json')) as fj:
    lib = json.load(fj)


# Create init file
with open(os.path.join(path_libdlf, '__init__.py'), 'w') as fi:

    # Loop over transforms and add them
    for transform, flist in lib.items():
        fi.write(f"from libdlf import {transform}\n")

    fi.write(f"\n__version__ = '{version}'\n")


# Loop over transforms
for transform, flist in lib.items():

    # Create transform file and loop over filters
    with open(os.path.join(path_libdlf, f"{transform}.py"), "w") as ft:

        # Imports
        ft.write("import os\n")
        ft.write("import numpy as np\n\n\n")

        # Write __all__
        ft.write("__all__ = [\n    '")
        ft.write("',\n    '".join([filt['name'] for filt in flist]))
        ft.write("',\n]\n\n")

        # Path of the library
        ft.write("_LIBPATH = os.path.abspath(os.path.dirname(__file__))\n\n\n")

        # Number of filters for this transform
        nr_filt = len(flist)

        # Loop over filters
        for f_i, filt in enumerate(flist):

            # File path and name of the filter
            fname = f"{filt['file']}"

            # Convert txt to npz
            txtfile = np.loadtxt(os.path.join(path_libdlf, fname), unpack=True)
            np.savez_compressed(
                os.path.join(path_libdlf, fname[:-4]), dlf=txtfile
            )

            # Start the function
            ft.write(f"def {filt['name']}():")

            # Get and write header
            with open(abspath(f"python/libdlf/{fname}")) as fl:

                # Add title
                ft.write(f'\n    """{fl.readline()[2: ]}')

                # Loop over remaining lines
                for line in fl:

                    # Do not copy the title-underline; just newline
                    if '========' in line:
                        ft.write('\n')

                    # Empty lines: only remove comment
                    elif line == '#\n':
                        ft.write('\n')

                    # The license is the last thing of the header
                    elif 'file is part of libdlf' in line:

                        # Add returned values
                        ft.write("\n    Returns\n")
                        ft.write("    -------\n")
                        values = filt['values'].replace(',', ', ')
                        ft.write(f"    base, {values} : ndarray\n")
                        ft.write("        Filter base and its values.\n\n")

                        # Finish header
                        ft.write('    """\n')

                        # Stop header loop
                        break

                    # Remove comment (#) and add indentation
                    else:
                        ft.write(f"    {line[2:]}")

            # Write function; we use np.loadtxt to read the files
            ft.write(
                f"    if getattr({filt['name']}, 'cache', None) is None:\n"
                f"        fname = '{fname[:-3]}npz'\n"
                f"        {filt['name']}.cache = np.load(\n"
                "            os.path.join(_LIBPATH, fname))['dlf']\n"
                f"    return {filt['name']}.cache\n")

            # Add values to function
            ft.write(
                f"\n\n{filt['name']}.values = {filt['values'].split(',')}\n")

            # Empty lines after function (except for last filter)
            if f_i < nr_filt-1:
                ft.write("\n\n")

            # Remove txt file.
            os.remove(os.path.join(path_libdlf, fname))

# Remove json file.
os.remove(os.path.join(path_lib, 'filters.json'))


# Write tests
test_filters = r"""import libdlf
import numpy as np


# Anderson (1975): J0_01/J0_2; sin_1/cos_1; with a=1
xt = np.array([1.0])


def test_hankel():
    # Analytical RHS
    rhs_j0 = np.exp(-xt**2/4)/2
    rhs_j1 = xt/4*np.exp(-xt**2/4)

    # Loop over filters
    for i, filt in enumerate(libdlf.hankel.__all__):

        # Get filter
        tfilt = getattr(libdlf.hankel, filt)

        # Get return values
        values = tfilt.__doc__.split('-------')[1]
        values = values.split('\n')[1].split(':')[0].strip()

        # Load filter
        if len(values.split(',')) == 3:
            base, j0, j1 = tfilt()
        elif 'j0' in values:
            base, j0 = tfilt()
        elif 'j1' in values:
            base, j1 = tfilt()
        else:
            assert 1 == 0

        # Required wavenumbers
        lambd = base/xt[:, None]

        # Compute values
        lhs_j0 = lambd*np.exp(-lambd**2)
        lhs_j1 = lambd**2*np.exp(-lambd**2)

        # Check
        if 'j0' in values:
            assert abs((rhs_j0 - np.dot(lhs_j0, j0)/xt) / rhs_j0) < 1e-4
        if 'j1' in values:
            assert abs((rhs_j1 - np.dot(lhs_j1, j1)/xt) / rhs_j1) < 1e-4


def test_fourier():
    # Analytical RHS
    rhs_sin = np.sqrt(np.pi)*xt*np.exp(-xt**2/4)/4
    rhs_cos = np.sqrt(np.pi)*np.exp(-xt**2/4)/2

    # Loop over filters
    for i, filt in enumerate(libdlf.fourier.__all__):

        # Get filter
        tfilt = getattr(libdlf.fourier, filt)

        # Get return values
        values = tfilt.__doc__.split('-------')[1]
        values = values.split('\n')[1].split(':')[0].strip()

        # Load filter
        if len(values.split(',')) == 3:
            base, sin, cos = tfilt()
        elif 'sin' in values:
            base, sin = tfilt()
        elif 'cos' in values:
            base, cos = tfilt()
        else:
            assert 1 == 0

        # Required frequencies
        freq = base/xt[:, None]

        # Compute values
        lhs_sin = freq*np.exp(-freq**2)
        lhs_cos = np.exp(-freq**2)

        # Check
        if 'sin' in values:
            assert abs((rhs_sin - np.dot(lhs_sin, sin)/xt) / rhs_sin) < 1e-4
        if 'cos' in values:
            assert abs((rhs_cos - np.dot(lhs_cos, cos)/xt) / rhs_cos) < 1e-4
"""
pathlib.Path(abspath("python/tests")).mkdir(exist_ok=True)
with open(abspath("python/tests/test_filters.py"), "w") as fs:
    fs.write(test_filters)
