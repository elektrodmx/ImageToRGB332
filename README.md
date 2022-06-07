# ImageToRGB332
Processing IDE image converter to use with Adafruit 8-bit colour graphics library.
Use it to convert images from 24-bit RGB to text file with 8-bit RGB332 colours separated by commas.

Tested on resolutions up to 256 * 240px.

# Converting
Run or compile ImageToRGB332.pde with "input.bmp" file in project directory. It should output "output.txt" file. At file ending there's a width, height and pixels counter listed.

# Using converted file
To display image from char array you need to draw all of pixels separately, so drawing can be slow at some cases. Im using ESP_8_BIT_GFX library to draw results on external display with drawPixel(x,y,c) function.

'test'
