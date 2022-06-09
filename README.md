# ImageToRGB332
Processing IDE image converter to use with Adafruit 8-bit colour graphics library (or any that uses RGB332).
Use it to convert images to 8-bit RGB332 text file with ready-to-use char array and function snippet, so You can easily use them in your 8-bit projects.

Maximum resolution is 500x500px, larger images wont open.

## Features:
#### Now:
- Converting any selected image file to RGB332 8-bit color char array.
- Using one of three color modes (256/4/2 colors).
- Redrawing converted image.
- Printing function snippet to output file.
#### Future features:
- Boolean array mode for monochrome mode.
#### Also thinking about:
- Monochrome and grayscale mode slider to control color translation with live preview.

## Converting
Run or compile ImageToRGB332.pde. Select desired color mode and file. After file is selected, it is converted instantly and should create .txt file named same as image file. At file ending there's a function snippet. You can also download compiled Windows 64-bit executable from Releases tab (OpenJDK 17 need to be installed to run this application).

## Using converted file
#### Using function:
From v0.3 there's a function generated at end of output file, so whole output file can be copied to your Arduino sketch, just need to enter name for display class. You can call this function with drawImage(x,y). 
```
void drawImage(int xPos,int yPos) {
  int pixCount = 0;
  for (int x=0;x<300;x++) {       // value based on image width
     for (int y=0;y<300;y++) {    // value based on image heigth
         class.drawPixel(x+xPos,y+yPos,image[pixCount]);
         pixCount++;
      }
   }
}
```
#### Without transparency:
To display image from char array you need to draw each pixel separately, so drawing can be slow at some cases. You can use function printed at the end of your output file, or write it by yourself. As I'm using ESP_8_BIT_GFX library to draw results on external display, "videoOut" class is used in my code example below (on ESP32 with 256x240 bitmap it runs at ~15 fps):

```
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
