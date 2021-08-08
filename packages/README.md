# Language-specific packages

This directory contains scripts to create language-specific packages of
`libdlf`. They are generally created automatically through the CI, but can also
be built manually. Instructions for each language are given below.


# Python

The python package is created by running

```bash
python create_package.py
```

Required to build are `numpy` and `setuptools_scm`.

The directory `python` has some scripts, the rest will be built with the above
command. The entire library is also copied to `python/libdlf/lib/`.

If you want to install the package created in this manner, run
```bash
pip install -e python
```

To clear it, run
```bash
pip -rf python/
```
