import json
import shutil
import pathlib
from os.path import abspath

# Create package directory
pathlib.Path(abspath("python/libdlf")).mkdir(parents=True, exist_ok=True)

# Copy library to python package
shutil.copytree(abspath('../lib'), abspath('python/libdlf/lib'),
                dirs_exist_ok=True)

# We need to copy the git folder, so scm can create the correct version number
shutil.copytree(abspath('../.git'), abspath('python/.git'), dirs_exist_ok=True)

# Copy README and LICENSE
shutil.copyfile('../README.md', 'python/README.md')
shutil.copyfile('../LICENSE', 'python/LICENSE')

# Create setup.py
setup = """# -*- coding: utf-8 -*-
import os
from setuptools import setup

# Longer description
readme = ('Library for Digital Linear Filters (DLF) as used, for instance, '
          'in Geophysics for electromagnetic modelling. See '
          'https://github.com/emsig/libdlf')

setup(
    name="libdlf",
    description="Library for Digital Linear Filters (DLF)",
    long_description=readme,
    author="The emsig community",
    author_email="info@emsig.xyz",
    url="https://github.com/emsig/libdlf",
    license="CC-BY-4.0",
    packages=["libdlf"],
    include_package_data=True,
    install_requires=[
        "numpy",
    ],
    use_scm_version={
        "root": ".",
        "relative_to": __file__,
        "write_to": os.path.join("libdlf", "version.py"),
    },
    setup_requires=["setuptools_scm"],
)
"""
with open(abspath("python/setup.py"), "w") as fs:
    fs.write(setup)

# Create setup.cfg
with open(abspath("python/setup.cfg"), "w") as fs:
    fs.write("[flake8]\n")
    fs.write("per-file-ignores = __init__.py: F401")

# Create MANIFEST.in
with open(abspath("python/MANIFEST.in"), "w") as fm:
    fm.write("include libdlf/lib/filters.json\n")
    fm.write("include libdlf/lib/*/*.txt\n")
    fm.write("exclude MANIFEST.in\n")

# Read json
with open(abspath('python/libdlf/lib/filters.json')) as fj:
    lib = json.load(fj)

# Create init file
with open(abspath('python/libdlf/__init__.py'), 'w') as fi:

    fi.write("from datetime import datetime\n")

    # Loop over transforms and add them
    for transform, flist in lib.items():
        fi.write(f"from libdlf import {transform}\n")

    fi.write(
        "try:\n"
        "    from libdlf.version import version as __version__\n"
        "except ImportError:\n"
        "    __version__ = 'unknown-'+datetime.today().strftime('%Y%m%d')\n"
    )


# Loop over transforms
for transform, flist in lib.items():

    # Create transform file and loop over filters
    with open(abspath(f"python/libdlf/{transform}.py"), "w") as ft:

        # Imports
        ft.write("import os\n")
        ft.write("import numpy as np\n\n\n")

        # Path of the library
        ft.write("_LIBPATH = os.path.abspath(os.path.dirname(__file__))\n")

        # Cache for the filters
        ft.write("_CACHE = {}\n\n\n")

        # Number of filters for this transform
        nr_filt = len(flist)

        # Loop over filters
        for f_i, filt in enumerate(flist):

            # File path and name of the filter
            fname = f"{filt['file']}"

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
                f"    if '{filt['name']}' not in _CACHE.keys():\n"
                f"        fname = '{fname}'\n"
                f"        _CACHE['{filt['name']}'] = np.loadtxt(\n"
                "            os.path.join(_LIBPATH, fname), unpack=True)\n"
                f"    return _CACHE['{filt['name']}']\n")

            # Empty lines after function (except for last filter)
            if f_i < nr_filt-1:
                ft.write("\n\n")
