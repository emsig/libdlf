# Digital Linear Filter Library

Library for Digital Linear Filters (DLF) used in Geophysics.


## Table of contents

- [Decisions to be taken](#decisions-to-be-taken)
- [ToDo](#todo)
- [What is `lib-dlf`](#what-is-lib-dlf)
- [Usage](#usage)
  - [Python](#python)
  - [Matlab](#matlab)
  - [Fortran](#fortran)
- [Contributing](#contributing)
  - [New filters](#new-filters)
- [License](#license)

## Decisions to be taken

Preliminary brainstorming happens/happened on
- https://github.com/emsig/empymod/issues/106
- https://hackmd.io/@prisae/dlf-lib

1. Library structure

   - Distinguish between forward and inverse transformations (e.g., `Fourier`
     and `iFourier`)?
   - Folders or flat structure?

   ```
   lib
   ├── hankel_aaa_###_yyyy_???.txt
   ├── hankel_author-opt-abbr_#pts_year_short-opt-descr.txt
   ├── fourier_key_201_2012.txt
   ├── hankel_wer_201_2018.txt
   ├── hankel_test_101_2030_j0j1j2.txt
   ├── hankel_test_101_2030_j1only.txt
   ├── laplace_test_101_2040_a.txt
   ├── laplace_test_101_2040_b.txt
   └── ...
   ```

   or
   ```
   lib
   ├── iHankel
   │   ├── aaa_###_yyyy_???.txt
   │   ├── author-opt-abbr_#pts_year_short-opt-descr.txt
   │   ├── wer_201_2018.txt
   │   ├── test_101_2030_j0j1j2.txt
   │   ├── test_101_2030_j1only.txt
   │   └── ...
   ├── iFourier
   │   ├── key_201_2012.txt
   │   └── ...
   ├── Fourier
   │   └── ...
   ├── iLaplace
   │   ├── test_101_2040_a.txt
   │   ├── test_101_2040_b.txt
   │   └── ...
   └── ...
   ```

2. File Naming

   Define file naming.


3. File Format

   Define header and layout.

4. Code examples

   Should we implement actual code files (a `code`-directory), or only show
   examples here in the README?

5. License

   Should all the filters have the same license, or is it better when each
   filter has its own license? Is latter even possible with license
   compatibility issues?


## Todo

- [ ] Work through the decisions and implement them
  - Define clear rules which each filter has to follow, so it is easy to write
    functions that can load any filter.
- [ ] Add filters
- [ ] Contact authors and ask if filters can be added
- [ ] Do not forget: Laplace filters, GPR filter, Q-kernel filter.

## What is `lib-dlf`


## Usage

### Python

```python
base, j0, j1 = np.loadtxt('link-to-file.txt')
# Do transform example.
```

Todo: Add example using pooch for implementation in libraries.

### Matlab

### Fortran


## Contributing

Contributions of any kinds are welcomed...

### New filters

Filters must follow a clear structure, outlined in the following...


## License

To be decided
