

class Wavefunction {
  HashMap<Tile, Integer> weights;
  Set[][] coefficients;
  int outputWidth;
  int outputHeight;

  public Wavefunction(int outputWidth, int outputHeight, HashMap<Tile, Integer> weights) {
    this.weights = weights;
    this.outputWidth = outputWidth;
    this.outputHeight = outputHeight;
    initCoefficients(weights.keySet());
    coefficients = new Set[outputHeight][outputWidth];
  }



  /*
  Initializes the possible tiles. At initialization (under current implementation) every
  single tile should be possible at every position.
   */
  void initCoefficients(Set<Tile> tiles) {
    for (int y =0; y < outputHeight; y++) {
      for (int x = 0; x < outputWidth; x++) {
        Set<Tile> toAdd = new HashSet<Tile>(tiles);
        coefficients[y][x] = toAdd;
      }
    }
  }


  /*
  Gets all possible tiles at the location (x,y)
  */
  Set<Tile> get(int x, int y) {
    return coefficients[y][x];
  }
}
