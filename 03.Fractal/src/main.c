#include <stdio.h>

#include "image.h"
#include "fractal.h"

int main() {
    image_p img = create_image(600, 600);

    fill_white(img);
    fractal(img, SIERPINSKI_CARPET);
    save_pgm(img, "sierpinski_carpet.pgm");

    fill_white(img);
    fractal(img, MANDELBROT_SET);
    save_pgm(img, "mandelbrot.pgm");

    return 0;
}
