[![CMake](https://github.com/andrey-kireev-1/hwproj/actions/workflows/03_build.yml/badge.svg?branch=03.Fractal)](https://github.com/andrey-kireev-1/hwproj/actions/workflows/03_build.yml)

# Fractal

## Overview
This project generate some fractals, such like the Sierpinski Carpet and the Mandelbrot Set. It creates image files in the `.pgm` format.

## Build and Run
To install this project you need to pre-install `cmake` and `make` utils. These utils create binary file that can be run by command `./03_A_Fractal`.

```bash
mkdir -p build && cd build
cmake ..
make

./03_A_Fractal 
```
