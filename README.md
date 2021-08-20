# Digital Linear Filter Library

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5172893.svg)](https://doi.org/10.5281/zenodo.5172893)

Library for Digital Linear Filters (DLF) as used, for instance, in Geophysics
for electromagnetic modelling.


## Table of contents

- [Digital Linear Filters](#digital-linear-filters)
- [Usage](#usage)
  - [Python](#python)
  - [Julia](#julia)
  - [Matlab](#matlab)
  - [Fortran](#fortran)
- [Contributing](#contributing)
  - [New filters](#new-filters)
- [What is `libdlf`](#what-is-libdlf)
  - [File naming](#file-naming)
  - [File format](#file-format)
  - [Structure](#structure)
  - [json](#json)
- [License](#license)

## Digital Linear Filters

TODO: brief theory and history, main references.

TODO: Some examples and figures, particularly to show what happens when you
reach the limit of a filter (longer is not necessary better).


## Usage

The examples here show how to use the filters for the standard filter method.
However, often you want to use the lagged convolution variant of DLF, in order
to reduce the required input values. Have a look at the example
[educational/dlf_standard_lagged_splined.html](https://empymod.emsig.xyz/en/stable/gallery/educational/dlf_standard_lagged_splined.html)
in the [empymod](https://empymod.emsig.xyz) documentation.


### Python

[![PyPI](https://img.shields.io/pypi/v/libdlf)](https://pypi.python.org/pypi/libdlf/)
[![conda-forge](https://img.shields.io/conda/vn/conda-forge/libdlf)](https://anaconda.org/conda-forge/libdlf/)
[![py-versions](https://img.shields.io/badge/python-3.6+-blue.svg)](https://www.python.org/downloads/)
[![platforms](https://img.shields.io/badge/platform-linux,win,osx-blue)](https://anaconda.org/conda-forge/libdlf/)

You can install `libdlf` for python via `pip` or `conda`:
```bash
pip install libdlf
```
or
```bash
conda install -c conda-forge libdlf
```

The package is structured into transform types. Each filter returns its base
and corresponding values as numpy arrays.

```python
import libdlf
base, j0, j1 = libdlf.hankel.wer_201_2018()

# TODO: Do actual transform with the filter.
```

### Julia

[![package-julia](https://github.com/emsig/libdlf/actions/workflows/package-julia.yml/badge.svg)](https://github.com/emsig/libdlf/actions/workflows/package-julia.yml)

You can install `LibDLF` for Julia using:
```julia
import Pkg
Pkg.add("LibDLF")
```
or
```julia
pkg> add LibDLF
```
The package is structured into transform types with each filter function nested beneath its type. Each filter returns its base
and corresponding values as arrays:

```julia
using LibDLF
base, fcos, fsin = LibDLF.Fourier.key_201_2012()

# TODO: Do actual transform with the filter.
```

### Matlab

ToDo


### Fortran

ToDo


## Contributing

We welcome contributions of any kind. New filters, better documentation,
cleverer or easier distribution, typos, you name it. Simply open an issue or
create a PR!


### New filters

We welcome any filter that has proven its merits! Simply create a pull request
adding your filter. Please make sure to

1. State in the PR explicitly that you give permission to distribute your
   filter under the CC-BY license.
2. You followed the file naming and file format outlined below, and add it to
   the `lib/filters.json` file.


## What is `libdlf`

A library for digital linear filters. Codes until now had to hard-code their
digital linear filters. This has several disadvantages:

- It adds a lot of "numbers" to the code base which has nothing really to do
  with the code.
- Codes have therefore often only one or a few filters, and it is hard to try
  other filters, as they are hard-coded.
- It can be hard to find filters of published results or similar.

Having a common library that can be used by any code base in any language
should hopefully widen the adoption of linear filters, make their use more
reproducible, and might hopefully even spark the design of new, hopefully more
robust filters or filters for new applications.


### File naming

The convention for file-naming is given in the following, where the different
parts are separated by underscores (all lowercase, file ending is `.txt`):

1. Transform type. E.g. `hankel`.
2. 3-8 characters of first author or first initials of authors. E.g., `wer`.
3. Number of points. E.g. `201`.
4. Year. E.g. `2018`.  
   (This can be followed by an appendix, a lowercase letter if there are
   several filters of the same type, author, number of points, and year.)
5. Values provided in the file, in the correct order. E.g. `j0j1`.  
   Accepted values:
   - Hankel: j0, j1, j2
   - Fourier: sin, cos

The given examples yield the filter file name `hankel_wer_201_2018_j0j1.txt`.


### File format

Have a look at, e.g., `lib/Hankel/hankel_wer_201_2018_j0j1.txt` to see the
structure of a filter file.

- The file format consists of a header of variable length. All header lines
  start with `#`, with a max line-length of 80.
- Leave two empty lines between description, reference, license, and the
  filter.
- **Title**: The first line should be a short title, stating the length, filter
  type, and values provided. E.g., `201 point Hankel filter, J0 and J1`. The
  title line is followed by an line of equal length of `=` for underlining.
- **Description**: The title is followed by a description:
  - What was the filter designed for?
  - Where did it work fine?
  - Are there known areas where it did not work fine?
- **Reference**: After the description comes, ideally, a reference that can be
  cited. The lines of the citation start with the characters `# > `.
- **License**:
  ```
  # Copyright YEAR Your Name
  #
  # This work is licensed under a CC BY 4.0 license.
  # <http://creativecommons.org/licenses/by/4.0/>.
  #
  # This file is part of libdlf.
  ```
- **Filter Header**: The filter header is the last line to start with a `#`.
  It always starts with `# base`, followed by the values which are provided
  below; e.g., `# base  j0  j1`.
- **Filter values**: The values are provided as space-separated numbers. The
  first column is always the base, followed by the values as provided in the
  file name and in the file header.


### Structure

The library folder has subfolders of the main transformations, e.g., Fourier
and Hankel. There is no distinction (on the folder level) in which direction
the transform is carried out (forward or inverse).

```
lib
├── Fourier
│   ├── fourier_key_81_2009_sincos.txt
│   ├── fourier_key_201_2012_sincos.txt
│   └── ...
├── Hankel
│   ├── hankel_key_201_2012_j0j1.txt
│   ├── hankel_wer_201_2018_j0j1.txt
│   └── ...
├── Laplace
│   └── ...
└── ...
```


### json

It might seem like a lot of duplication: File name, header info, and in
addition a json that maps meta-data to files.

The advantage of this is that on one hand one can copy a single filter by
simply coping a file, which then contains all required info. The json file, on
the other hand, is good for machines, providing a rich way to choose filters
and load them. The json is, for instance, the ideal place for a script to
create a deployable package for a specific language.

For the format of the json simply have a look at it. The top-level entries
depict the transform types (e.g., `"hankel"`), and the different filters are
then added as an array. Each filter has exactly the following entries:
`"name"`, `"author"`, `"year"`, `"appendix"`, `"points"`, `"values"`, and
`"file"`. Points is an integer, and all others are strings; values is a
comma-separated list. The file is the relative path to the corresponding
filter, starting at `lib/`. Appendix will be an empty string, `""`, in most
cases (see above under *File naming*).


# License

This work is licensed under a CC BY 4.0 license.
<http://creativecommons.org/licenses/by/4.0/>.

Note that the language-specific packages (e.g. Python and Julia) are licensed
under BSD-3 while the filter values remain CC-BY-4.0.