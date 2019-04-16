/* //<>//
Wavefunction holds all the observed and unobserved states.
 Can be thought of as a three-dimensional array.
 */

class Wavefunction {
  HashMap<Tile, Integer> weights;
  Set<Tile>[][] coefficients;

  int outputWidth;
  int outputHeight;

  public Wavefunction(int outputWidth, int outputHeight, HashMap<Tile, Integer> weights) {
    this.weights = weights;
    this.outputWidth = outputWidth/dimension;
    this.outputHeight = outputHeight/dimension;
    initCoefficients(weights.keySet());
  }



  /*
  Initializes the possible tiles. At initialization (under current implementation) every
   single tile should be possible at every position.
   */
  void initCoefficients(Set<Tile> tiles) {
    coefficients = new Set[outputHeight][outputWidth];
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
  Gets the singular tile at location (x,y) once it 
   has been collapsed. Return null if not collapsed.
   */
  Tile getCollapsed(int x, int y) {
    if (get(x, y).size() != 1) {
      throw new NotCollapsedException("This location is not collapsed. Current number of possible tiles: " + get(x, y).size());
    };

    return get(x, y).iterator().next();
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

  void collapse(int x, int y) {
    Set<Tile> tiles = coefficients[y][x];
    float sum = 0;    
    for (Tile t : tiles) {
      sum += weights.get(t);
    }

    sum *= random(1);
    Tile chosen = null;
    for (Tile t : tiles) {
      sum -= weights.get(t);
      if (sum < 0) {
        chosen = t;
        break;
      }
    }
    Set<Tile> set = new HashSet<Tile>();
    set.add(chosen);
    coefficients[y][x] = set;
  }

/*
  The wavefunction removes that tiles from the list of possible
  tiles
*/ 
  void constrain(int x, int y, Tile forbidden) {
    coefficients[y][x].remove(forbidden);
  }




  /*
  Finds the Shannon Entropy at location (x,y)
   In simpler terms, it finds how "unknown" the current tile is.
   The more possible tiles, the higher the entropy.
   */
  double getShannonEntropy(int x, int y) {
    double weightSum = 0;
    double logWeightSum = 0;

    for (Tile t : coefficients[y][x]) {
      double weight = weights.get(t);
      weightSum += weight;
      logWeightSum += weight * Math.log(weight);
    }

    return Math.log(weightSum) - (logWeightSum/weightSum);
  }



  @Override
    public String toString() {
    String ret = "";
    for (Set<Tile> [] row : coefficients) {
      for (Set<Tile> s : row) {
        ret += s.size() + " ";
      }
      ret += "\n";
    }

    return ret;
  }
}


/*
  Error class that happens when the wavefunction attempts to access a tile that isn't properly collapsed.
  This could be that there is 0 or more than 1 tiles possible at that location.
*/
public class NotCollapsedException extends RuntimeException {
  public NotCollapsedException(String message) {
    super(message);
  }
}
