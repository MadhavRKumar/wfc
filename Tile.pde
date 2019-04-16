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
  color[] tilePixels;

  public Tile(int x, int y, int N, int M) {
    this.x = x;
    this.y = y;
    this.tileWidth = N;
    this.tileHeight = M;
    tilePixels = new color[N*M];
    fillPixels();
  }
  
  /*
  Takes the pixels from the image and keeps them in its own pixel array.
  This allows us to avoid having to access the image constantly and saves
  some time.
  */
  void fillPixels() {
    img.loadPixels();
    for (int i = 0, inputX = this.x; i < tileWidth; i++, inputX++) {
      for (int j = 0, inputY = this.y; j < tileHeight; j++, inputY++) {
        int outputIndex = j*tileWidth + i;
        int inputIndex = inputY*img.width + inputX;

        if (outputIndex < tilePixels.length && inputIndex < img.pixels.length) {
          tilePixels[outputIndex] = img.pixels[inputIndex];
        }
      }
    }
  }


  /*
   Displays the tile at the coordinates (x,y) on the output image
  */
  void drawAt(int x, int y) {
    for (int i = x, inputX = 0; i < x+tileWidth; i++, inputX++) {
      for (int j = y, inputY = 0; j < y+tileHeight; j++, inputY++) {
        int outputIndex = j*width + i;
        int inputIndex = inputY*tileWidth + inputX;

        if (outputIndex < pixels.length && inputIndex < tilePixels.length) {
          pixels[outputIndex] = tilePixels[inputIndex];
        }
      }
    }
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

    // pixel comparision
    for (int i = 0; i < tilePixels.length; i++) {
      if (tilePixels[i] != other.tilePixels[i]) {
        return false;
      }
    }


    return true;
  }

  @Override
    public int hashCode() {
    int val = 0;
    img.loadPixels();
    for (int i = 0; i < tilePixels.length; i++) {
      color c = tilePixels[i];
      float r = (c >> 16) & 0xFF;
      val += r*3;
      float g = (c >> 8) & 0xFF;
      val += g*5;

      float b = c & 0xFF;
      val += b*7;
    }

    return val;
  }


  /*
  For debugging purposes, currently just prints color value of first pixel
   */
  @Override
    public String toString() {
    color c = tilePixels[0];
    return "[" + this.x + "," + this.y + "] " + hex(c);
  }
}
