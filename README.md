# ImageToRGB332
Processing IDE image converter to use with Adafruit 8-bit colour graphics library.
Use it to convert images from 24-bit RGB bitmap to text file with 8-bit RGB332 colours separated by commas, so You can easily use them in your 8-bit projects.

Maximum resolution is 300 * 300px.

## Features
- Converting any selected image file to RGB332 8-bit color char array.
- Using one of three color modes (256/4/2 colors)
- Redrawing converted image


## Converting
Run or compile ImageToRGB332.pde. Select desired color mode and file. It should create .txt file named same as image file. At file ending there's a width, height and pixels counter listed. You can also download compiled Windows 64-bit executable from Releases tab (OpenJDK 17 need to be installed to run this application).

## Using converted file
To display image from char array you need to draw each pixel separately, so drawing can be slow at some cases. As I'm using ESP_8_BIT_GFX library to draw results on external display, "videoOut" class is used in my code example below (working really fast on ESP32 with 256x240 bitmaps!):

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
