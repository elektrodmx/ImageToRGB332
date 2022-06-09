// ----------
// Author:        elektrodmx    https://github.com/elektrodmx/
// ----------
// Image To RGB332 Converter v0.3
// made for Processing IDE
// ----------
// Input file:    *.jpg *.png *.gif *.bmp and more, max 500x500px
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
  size(1100, 700);     // from v0.3 500x500px images supported
  strokeCap(PROJECT);  // for better pixel drawing 
}

void fileSelected(File selection) {
  if (selection == null) {
  } else {
    output = createWriter(selection.getAbsolutePath() + ".txt");
    img = loadImage(selection.getAbsolutePath());
  }
}

void mousePressed() {  // for color mode and quitting
  if (mouseY > 600) {
    if (mouseY < 650) {
      if (mouseX > 75) {
        if (mouseX < 275) {
          colorMode = 0;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 325) {
        if (mouseX < 525) {
          colorMode = 1;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 575) {
        if (mouseX < 775) {
          colorMode = 2;
          img = null;
          converted = false;
          selectInput("Select a bitmap to process:", "fileSelected");
        }
      }
      if (mouseX > 850) {
        if (mouseX < 1050) {
          exit();
        }
      }
    }
  }
}




void draw() {
  textSize(20);
  fill(250, 250, 250);
  stroke(0,0,0);
  rect(75, 600, 200, 50);
  rect(325, 600, 200, 50);
  rect(575, 600, 200, 50);
  fill(250, 200, 200);
  rect(850, 600, 200, 50);

  fill(0, 0, 0);
  text("Input image:", 55, 44);
  text("Output image:", 605, 44);

  textSize(16);
  text("RGB332", 80, 622);
  text("256 colors", 80, 642);
  text("RGB332", 330, 622);
  text("4 colors (gray)", 330,642);
  text("RGB332", 580, 622);
  text("2 colors", 580, 642);
  text("Close", 855, 632);
  
  if (img != null) {              // only if image is loaded
    if (img.height <= 500) {      // image max height check
      if (img.width <= 500) {     // image max width check
        image(img, 25, 50);
      }
    }

    if (!converted) {
      if (img.height <= 500) {
        if (img.width <= 500) {
          output.print("const char image[]={");   // to make copying array even easier
          for (int y = 0; y < img.height; y++) {  // for every pixel row
            for (int x = 0; x < img.width; x++) { // for every pixel column
              // Get 24-bit color from pixel:
              color c = get(x + 25, y + 50);
              // Split into separate variables:
              int r = int(red(c));
              int g = int(green(c));
              int b = int(blue(c));
              if (colorMode == 0) {               // 256 colors
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
                // Add comma and space for every but last element.
                if (pixNum+1 < img.height*img.width) {
                  output.print(", ");
                  }
                // Draw pixel
                stroke(r * 36.42, g * 36.42, b * 85);
                point(x + 575, y + 50);
                // Count pixel
                pixNum++;
              }

              if (colorMode == 1) {   // grayscale
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
                // Draw pixel
                stroke(colorRGB332, colorRGB332, colorRGB332);
                point(x + 575, y + 50);
                // Count pixel
                pixNum++;
              }

              if (colorMode == 2) {   //monochrome
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
                // Draw pixel
                stroke(colorRGB332, colorRGB332, colorRGB332);
                point(x + 575, y + 50);
                // Count pixel
                pixNum++;
              }
            }
          }
          
          // Finishing text file and printing function snippet:
          output.println("}; ");
          output.println(" ");
          output.println("// function to display image:");
          output.println("// drawImage(x,y)");
          output.println("void drawImage(int xPos,int yPos) {");
          output.println("  int pixCount = 0;");
          output.print("  for (int x=0;x<");
          output.print(img.width);
          output.println(";x++) {");
          output.print("     for (int y=0;y<");
          output.print(img.height);
          output.println(";y++) {");
          output.println("         class.drawPixel(x+xPos,y+yPos,image[pixCount]);"); //change "class" for your display
          output.println("         pixCount++;");         
          output.println("      }");
          output.println("   }");
          output.println("}");
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
