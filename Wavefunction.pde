

class Wavefunction {
  HashMap<Tile, Integer> weights;
  Set<Tile>[][] coefficients;
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


  /*
  A wavefunction is fully collapsed if and only if every position has been observed
   and there is only one possible tile per position
   */
  boolean isFullyCollapsed() {
    for (Set[] row : coefficients) {
      for (Set s : row) {
        if (s.size() > 1) {
          return false;
        }
      }
    }

    return true;
  }


  /*
   Collapses the wavefunction at (x,y).
   A collpased wavefunction has only one possible tile chosen from the position's
   set of possible tiles. The tile is chosen randomly based on a weighted probability
   from the weights map.
   */

  void collpase(int x, int y) {
    Set<Tile> tiles = coefficients[y][x];
    float sum = 0;    
    for(Tile t : tiles) {
       sum += weights.get(t);
    }
    
    sum *= random(1);
    Tile chosen = null;
    for(Tile t : tiles) {
      sum -= weights.get(t);
      if(sum < 0) {
         chosen = t;
         break;
      }
    }
    Set<Tile> set = new HashSet<Tile>();
    set.add(chosen);
    coefficients[y][x] = set;
    
  }

  /*
  Finds the Shannon Entropy at location (x,y)
   In simpler terms, it finds how "unknown" the current tile is.
   The more possible tiles, the higher the entropy.
   */
  double shannonEntropy(int x, int y) {
    double weightSum = 0;
    double logWeightSum = 0;

    for (Tile t : coefficients[y][x]) {
      double weight = weights.get(t);
      weightSum += weight;
      logWeightSum += weight * Math.log(weight);
    }

    return Math.log(weightSum) - (logWeightSum/weightSum);
  }
}
