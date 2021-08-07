# -*- coding: utf-8 -*-
from setuptools import setup

readme = ("Library for Digital Linear Filters (DLF) as used, for instance, "
          "in Geophysics for electromagnetic modelling.")

setup(
    name="libdlf",
    version="0.0.0",
    description="Library for Digital Linear Filters (DLF)",
    long_description=readme,
    author="The emsig community",
    author_email="info@emsig.xyz",
    url="https://github.com/emsig/libdlf",
    license="CC-BY-4.0",
    packages=["libdlf"],
)
