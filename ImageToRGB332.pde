// Author:        elektrodmx    https://github.com/elektrodmx/
// ----------
// Image To RGB332 Converter v0.2
// made for Processing IDE
// ----------
// Input file:    *.jpg *.png *.gif *.bmp and more, max 300x300px
// Output file:   *.txt (same name as input file) (RGB332 8-bit colors separated by commas)
// ----------
// Variables definition:
PImage img;
PrintWriter output;
int x = 0;
int y = 0;
int imwidth = 0;
int imheight = 0;
long pixNum = 0;
int colorMode = 0;
boolean converted = false;

void setup() {
  size(750, 480);
  noSmooth();      // for better pixel drawing
}

void fileSelected(File selection) {
  if (selection == null) {
  } else {
    output = createWriter(selection.getAbsolutePath() + ".txt");
    img = loadImage(selection.getAbsolutePath());
  }
}

void mousePressed() {  // for color mode and quitting
  if (mouseY > 400) {
    if (mouseY < 450) {
      if (mouseX > 25) {
        if (mouseX < 175) {
          colorMode = 0;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 208) {
        if (mouseX < 358) {
          colorMode = 1;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 391) {
        if (mouseX < 541) {
          colorMode = 2;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 574) {
        if (mouseX < 724) {
          exit();
        }
      }
    }
  }
}




void draw() {
  textSize(18);
  fill(250, 250, 250);
  rect(24, 400, 152, 52);
  rect(207, 400, 152, 52);
  rect(390, 400, 152, 52);
  rect(573, 400, 152, 52);

  fill(0, 0, 0);
  text("Input image:", 55, 44);
  text("Output image:", 405, 44);

  textSize(16);
  text("RGB332", 34, 422);
  text("256 colors", 36, 442);
  text("RGB332", 217, 422);
  text("4 colors (gray)", 219, 442);
  text("RGB332", 400, 422);
  text("2 colors", 402, 442);
  text("Close", 583, 432);
  
  if (img != null) {              // only if image is loaded
    if (img.height <= 300) {      // image max height check
      if (img.width <= 300) {     // image max width check
        image(img, 50, 50);
      }
    }

    if (!converted) {
      if (img.height <= 300) {
        if (img.width <= 300) {
          for (int y = 0; y < img.height; y++) {  // for every pixel row
            for (int x = 0; x < img.width; x++) { // for every pixel column
              // Get 24-bit color from pixel:
              color c = get(x + 50, y + 50);
              // Split into separate variables:
              int r = int(red(c));
              int g = int(green(c));
              int b = int(blue(c));
              if (colorMode == 0) {
                // Doing calculations for RGB322 color format:
                r = r / 32;   // 8-bit -> 3-bit
                g = g / 32;   // 8-bit -> 3-bit
                b = b / 64;   // 8-bit -> 2-bit
                // Converting to strings with binary for each color.
                String rbin = binary(r, 3);
                String gbin = binary(g, 3);
                String bbin = binary(b, 2);
                // Merge strings to 8-bit RGB332 8-bit binary code (RRRGGGBB)
                String colorBinary = rbin + gbin + bbin;
                // Converting to decimal
                int colorRGB332 = unbinary(colorBinary);
                // Write to file
                output.print(colorRGB332);
                // Add comma and space for easy copying into array.
                output.print(", ");
                // Counting pixels
                stroke(r * 36.42, g * 36.42, b * 85);
                point(x + 400, y + 50);
                pixNum++;
              }

              if (colorMode == 1) {
                // Get 0 or 1 from each color:
                r = r / 128;
                g = g / 128;
                b = b / 128;
                int colorRGB332 = 0;
                // choose one of grayscale colors from r+g+b
                if (r + g + b == 0) {
                  colorRGB332 = 0;
                }
                if (r + g + b == 1) {
                  colorRGB332 = 73;
                }
                if (r + g + b == 2) {
                  colorRGB332 = 182;
                }
                if (r + g + b == 3) {
                  colorRGB332 = 255;
                }
                // Write to file
                output.print(colorRGB332);
                // Add comma and space for easy copying into array.
                output.print(", ");
                // Counting pixels
                stroke(colorRGB332, colorRGB332, colorRGB332);
                point(x + 400, y + 50);
                pixNum++;
              }

              if (colorMode == 2) {
                // Calculations from colorMode 1 :
                r = r / 128;
                g = g / 128;
                b = b / 128;
                int colorRGB332 = 0;
                // like in grayscale, but converted only to black or white
                if (r + g + b <= 1) {
                  colorRGB332 = 0;
                } else {
                  colorRGB332 = 255;
                }
                // Write to file
                output.print(colorRGB332);
                // Add comma and space for easy copying into array.
                output.print(", ");
                // Counting pixels
                stroke(colorRGB332, colorRGB332, colorRGB332);
                point(x + 400, y + 50);
                pixNum++;
              }
            }
          }

          // Writing bitmap info to the end of text file:
          output.println(" ");
          output.println("Width:");
          output.println(img.width);
          output.println("Height:");
          output.println(img.height);
          output.println("Pixel count:");
          output.println(pixNum);
          // Write to file
          output.flush();
          // Close file
          output.close();
          converted = true;
        }
      }
    }
  }
}

