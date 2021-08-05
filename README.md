# Digital Linear Filter Library

Library for Digital Linear Filters (DLF), as used, for instance, in Geophysics
for electromagnetic modelling.

## Todo

- [ ] Add filters.
- [ ] Write *Digital Linear Filters* section, with references to most important
      articles.
- [ ] Write *What is `lib-dlf`*.
- [ ] Contact some authors and ask if their filters can be added under the
      CC-BY-4.0.
- [ ] Do not forget: Laplace filters, GPR filter, Q-kernel filter.
- [ ] Add code examples.
- [ ] Think about language-specific, binary distribution.

## Table of contents

- [Digital Linear Filters](#digital-linear-filters)
- [What is `lib-dlf`](#what-is-lib-dlf)
  - [File naming](#file-naming)
  - [File format](#file-format)
  - [Structure](#structure)
- [Usage](#usage)
  - [Python](#python)
  - [Julia](#julia)
  - [Matlab](#matlab)
  - [Fortran](#fortran)
- [Contributing](#contributing)
  - [New filters](#new-filters)
- [License](#license)


## Digital Linear Filters

TODO: brief theory and history, main references.

TODO: Some examples and figures, particularly to show what happens when you
reach the limit of a filter.


## What is `lib-dlf`

TODO


### File naming

The convention for file-naming is given in the following, where the different
parts are separated by underscores (all lowercase, file ending is `.txt`):

1. Transform type. E.g. `hankel`.
2. 3-6 characters of first author or first initials of authors. E.g., `wer`.
3. Number of points. E.g. `201`.
4. Year. E.g. `2018`.  
   (This can be followed by a lowercase letter if there are several filters of
   the same type, author, number of points, and year.)
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


## Usage

The examples here show how to use the filters for the standard filter method.
However, often you want to use the lagged convolution variant of DLF, in order
to reduce the required input values. Have a look at the example
[educational/dlf_standard_lagged_splined.html](https://empymod.emsig.xyz/en/stable/gallery/educational/dlf_standard_lagged_splined.html)
in the [empymod](https://empymod.emsig.xyz) documentation.


### Python

```python
base, j0, j1 = np.loadtxt('link-to-file.txt')
# Do transform example.
```

Todo: Add example using pooch for implementation in libraries.


### Julia


### Matlab


### Fortran


## Contributing

We welcome contributions of any kind. New filters, better documentation,
cleverer or easier distribution, typos, you name it. Simply open an issue or
create a PR!


### New filters

We welcome any filter that has proven its merits! Simply create a pull request
adding your filter. Please make sure to

1. State in the PR explicitly that you give permission to distribute your
   filter under the CC-BY license.
2. You followed the file naming and file format outlined above.
