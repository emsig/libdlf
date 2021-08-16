# Language-specific packages

This directory contains scripts to create language-specific packages of
`libdlf`. They are generally created automatically through the CI, but can also
be built manually. Instructions for each language are given below.


# Python

The python package is created by running

```bash
python create_python.py
```

The only dependency to use the package is `numpy`.

If you want to install the package created in this manner, run

```bash
pip install python/. --use-feature=in-tree-build
```

To clear it, run

```bash
rm -rf python/
```

(All commands are meant to be run within the `packages` directory.)
