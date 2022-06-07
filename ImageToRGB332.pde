// Author:        elektrodmx    https://github.com/elektrodmx/
// ----------
// Image To RGB332 Converter
// made for Processing IDE
// ----------
// Input file:    "input.bmp"    (Any)
// Output file:   "output.txt"   (RGB332 8-bit colors separated by commas)
// ----------

// Variables definition:
PImage img;
PrintWriter output;
int x = 0;
int y = 0;
int imwidth = 0;
int imheight = 0;
long pixNum = 0; 
                                        
void setup() {
  size(800, 600);
  img = loadImage("input.bmp");
  output = createWriter("output.txt");    
}                                        
                                        
void draw() {
  image(img, 0, 0);  
  for (int y=0;y<img.height;y++) {        // for every pixel row    
    for (int x=0;x<img.width;x++) {       // for every pixel column
      // Get 24-bit color from pixel:
      color c = get(x,y);
      
      // Split into separate variables:
      int r = int(red(c));
      int g = int(green(c));
      int b = int(blue(c));
      
      // Doing calculations for RGB322 color format:
      r = r/32;     // 8-bit -> 3-bit    
      g = g/32;     // 8-bit -> 3-bit    
      b = b/64;     // 8-bit -> 2-bit   
      
      // Converting to strings with binary for each color.
      String rbin = binary(r,3);                    
      String gbin = binary(g,3);                         
      String bbin = binary(b,2);     
      
      // Merge strings to 8-bit RGB332 8-bit binary code (RRRGGGBB)
      String colorBinary = rbin+gbin+bbin;
      
      // Converting to decimal
      int colorRGB332 = unbinary(colorBinary);
      
      // Write to file
      output.print(colorRGB332); 
      
      // Add comma and space for easy copying into array.
      output.print(", ");
      
      // Counting pixels
      pixNum++;       
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
  
  // Close program
  exit();
}                                                                                
