import json
import shutil
import pathlib

# Create package directory
pathlib.Path("libdlf").mkdir(parents=True, exist_ok=True)

# Copy library to python package
shutil.copytree('../../lib', 'libdlf/lib', dirs_exist_ok=True)

# Read json
with open('libdlf/lib/filters.json') as fj:
    lib = json.load(fj)

# Create init file
with open('libdlf/__init__.py', 'w') as fi:

    # Loop over transforms and add them
    for transform, flist in lib.items():
        fi.write(f"from libdlf import {transform}\n")


# Loop over transforms
for transform, flist in lib.items():

    # Create transform file and loop over filters
    with open(f"libdlf/{transform}.py", "w") as ft:

        # Imports
        ft.write("import os\n")
        ft.write("import numpy as np\n\n\n")

        # Path of the library
        ft.write("LIBPATH = os.path.abspath(os.path.dirname(__file__))\n\n\n")

        # Number of filters for this transform
        nr_filt = len(flist)

        # Loop over filters
        for f_i, filt in enumerate(flist):

            # File path and name of the filter
            fname = f"{filt['file']}"

            # Start the function
            ft.write(f"def {filt['name']}():")

            # Get and write header
            with open(f"libdlf/{fname}") as fl:

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
                        ft.write("    Returns\n")
                        ft.write("    -------\n")
                        values = filt['values'].replace(',', ', ')
                        ft.write(f"    base, {values}\n\n")

                        # Finish header
                        ft.write('    """\n')

                        # Stop header loop
                        break

                    # Remove comment (#) and add indentation
                    else:
                        ft.write(f"    {line[2:]}")

            # Write function; we use np.loadtxt to read the files
            ft.write(f"    fname = '{fname}'\n")
            ft.write('    return np.loadtxt('
                     'f"{LIBPATH}/{fname}", unpack=True)\n')

            # Empty lines after function (except for last filter)
            if f_i < nr_filt-1:
                ft.write("\n\n")
