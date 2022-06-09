# ImageToRGB332
Processing IDE image converter to use with Adafruit 8-bit colour graphics library.
Use it to convert images to text file with 8-bit RGB332 colours separated by commas, so You can easily use them in your 8-bit projects.

Maximum resolution is 300x300px, larger images wont open.

## Features:
#### Now:
- Converting any selected image file to RGB332 8-bit color char array.
- Using one of three color modes (256/4/2 colors).
- Redrawing converted image.
#### Future features:
- Option to build complete Arduino IDE code.
- 512x512px resolution support.
- Boolean array mode for monochrome mode.
#### Also thinking about:
- Monochrome and grayscale mode slider to control color translation with live preview.

## Converting
Run or compile ImageToRGB332.pde. Select desired color mode and file. It should create .txt file named same as image file. At file ending there's a width, height and pixels counter listed. You can also download compiled Windows 64-bit executable from Releases tab (OpenJDK 17 need to be installed to run this application).

## Using converted file
#### Without transparency:
To display image from char array you need to draw each pixel separately, so drawing can be slow at some cases. As I'm using ESP_8_BIT_GFX library to draw results on external display, "videoOut" class is used in my code example below (on ESP32 with 256x240 bitmap it runs at ~15 fps):

```
const unsigned char image[] = {   // Numbers manually copied from output file
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  [...]
  0, 0, 0, 0, 0, 0, 0, 0, 
};
int imageheight = 256;            // Height manually copied from output file ending
int imagewidth = 240;             // Width manually copied from output file ending

int pixnum = 0;                   // Pixel counter reset

for (int y=0;y<imageheight;y++) {
  for (int x=0;x<imagewidth;x++) {
    videoOut.drawPixel(x,y,image[pixnum]);  // Drawing pixel with RGB332 color
    pixnum++;
  }
}
```
#### With transparency 
To draw with transparent color, just add one statement is added. Transparent color need to be in RGB332 format (hex/dec):

```
const unsigned char image[] = {   // Numbers manually copied from output file
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  0, 0, 0, 0, 0, 0, 0, 0, 
  [...]
  0, 0, 0, 0, 0, 0, 0, 0, 
};
int imageheight = 256;            // Height manually copied from output file ending
int imagewidth = 240;             // Width manually copied from output file ending
byte tcolor = 0;                  // transparent color (RGB332) (0 = black)

int pixnum = 0;                   // Pixel counter reset

for (int y=0;y<imageheight;y++) {
  for (int x=0;x<imagewidth;x++) {
    if (image[pixnum] != tcolor) {            // Only if color is not transparent
      videoOut.drawPixel(x,y,image[pixnum]);  // Drawing pixel with RGB332 color
    }
    pixnum++;
  }
}
```
