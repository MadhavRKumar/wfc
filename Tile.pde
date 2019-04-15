/*
  Tile class holds the pattern information.
  (x,y) in this case refers to the pixels in the
  input image.
*/
class Tile {
  int x;
  int y;
  int tileWidth; 
  int tileHeight;

  public Tile(int x, int y, int N, int M) {
    this.x = x;
    this.y = y;
    this.tileWidth = N;
    this.tileHeight = M;
  }
  
  
  void drawAt(int x, int y) {
   loadPixels();
   img.loadPixels();
   for(int i = x, inputX = this.x; i < x+tileWidth; i++, inputX++) {
    for(int j = y, inputY = this.y; j < y+tileHeight; j++, inputY++) {
      int outputIndex = j*width + i;
      int inputIndex = inputY*img.width + inputX;
      
      pixels[outputIndex] = img.pixels[inputIndex];
     }
   }
   
   updatePixels();
  }

  /*
    Tests equality of tile by checking to see if every pixel is the same
   This allows the usage of a HashMap for weights.
   */
  @Override
    public boolean equals(Object obj) {
    if (obj == null) {
      return false;
    }

    if (obj == this) {
      return true;
    }

    if (!(obj instanceof Tile)) {
      return false;
    }

    Tile other = (Tile)obj;
    img.loadPixels();
    
    // pixel comparision
    for (int i = 0; i < tileHeight; i++) {
      for (int j = 0; j < tileWidth; j++) {
        int thisIndex = (y+i)*img.width + (x+j);
        int otherIndex = (other.y+i)*img.width + (other.x + j);

        if (img.pixels[thisIndex] != img.pixels[otherIndex]) {
          return false;
        }
      }
    }


    return true;
  }

  @Override
    public int hashCode() {
    int val = 0;
    img.loadPixels();
    for (int i = 0; i < tileHeight; i++) {
      for (int j = 0; j < tileWidth; j++) {
        int thisIndex = (y+i)*img.width + (x+j);
        color c = img.pixels[thisIndex];
        float r = (c >> 16) & 0xFF;
        val += r*3;
        float g = (c >> 8) & 0xFF;
        val += g*5;
        
        float b = c & 0xFF;
        val += b*7;
      }
    }
    
    return val;
  }
  
  
  /*
  For debugging purposes, currently just prints color value of first pixel
  */
  @Override
    public String toString() {
     img.loadPixels();
     int thisIndex = (y)*img.width + (x);
     color c = img.pixels[thisIndex];
    return "[" + this.x + "," + this.y + "] " + hex(c);
  }
}
