# ImageToRGB332
Processing IDE image converter to use with Adafruit 8-bit colour graphics library.
Use it to convert images from 24-bit RGB to text file with 8-bit RGB332 colours separated by commas.

Tested on resolutions up to 256 * 240px.

# Converting
Run or compile ImageToRGB332.pde with "input.bmp" file in project directory. It should output "output.txt" file. At file ending there's a width, height and pixels counter listed.

# Using converted file
To display image from char array you need to draw all of pixels separately, so drawing can be slow at some cases. As I'm using ESP_8_BIT_GFX library to draw results on external display, "videoOut" class is used in my example.

```
const unsigned char image[] = {   // Numbers manually copied from "output.txt" file
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  [...]
  0, 0, 0, 0, 0, 0, 0, 0, 
};
int imageheight = 256;            // Height manually copied from "output.txt" file ending
int imagewidth = 240;             // Width manually copied from "output.txt" file ending

int pixnum = 0;                   // Pixel counter reset

for (int y=0;y<imageheight;y++) {
  for (int x=0;x<imagewidth;x++) {
    videoOut.drawPixel(x,y,image[pixnum]);  // Drawing pixel with RGB332 color
    pixnum++;
  }
}
```


