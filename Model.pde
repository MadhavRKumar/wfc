/* //<>//
Model class does most of the work. It runs the loop and observes 
and propagates the wavefunction

*/
class Model {
  Wavefunction wf; 
  HashSet<Compatibility> compats;

  public Model(HashMap<Tile, Integer> weights, HashSet<Compatibility> compats) {
    this.compats = compats;  
    wf = new Wavefunction(width, height, weights);
  }


  void run() {
    while (!wf.isFullyCollapsed()) { //<>//
      // Observation
      PVector coords = findMinEntropy(); //<>//
      int x = (int)coords.x;
      int y = (int)coords.y;
      wf.collapse(x, y);
      
      // Propagation
      propagate(x, y); //<>//
    }
    // Output Observations
    displayImage();
  }
  
  /*
  Propagation starts at collapsed wavefunction and causes changes to ripple outwards
  */
  void propagate(int x, int y) {
    Stack<PVector> stack = new Stack<PVector>(); //<>//
    stack.push(new PVector(x,y));

    while (stack.size() > 0) {
      PVector curTile = stack.pop();
      int curX = (int)curTile.x;
      int curY = (int)curTile.y;
      Set<Tile> curPossibleTiles = wf.get(curX, curY);


      // start by looking at possible neigbhors
      for (Direction dir : getValidDirections(curX, curY, wf.outputWidth, wf.outputHeight, 1)) {
        int otherX = curX + (dir.x);
        int otherY = curY + (dir.y);

        Set<Tile> iter = new HashSet<Tile>(wf.get(otherX, otherY));
        
        // consider every possible tile at neighboring location
        for (Tile other : iter) {
          boolean isOtherTilePossible = false;
          
          // checks compatibility between all the current possible tiles
          // and the other possible tile
          for (Tile t : curPossibleTiles) {
            Compatibility compat = new Compatibility(t, other, dir);
            isOtherTilePossible = isOtherTilePossible || compats.contains(compat);
          }
          
          // if the tile in the neighboring position cannot exist
          // it is removed. since it has been updated we must propagate
          // its changes as well, so it is added to the stack
          if (!isOtherTilePossible) {
            wf.constrain(otherX, otherY, other);
            stack.push(new PVector(otherX, otherY));
          }
         
        }
      }
      //println(wf);
    }
  } //<>//


  PVector findMinEntropy() {
    PVector coords = new PVector();
    double minEntropy = Integer.MAX_VALUE;
    for (int x = 0; x < wf.outputWidth; x++) {
      for (int y = 0; y < wf.outputHeight; y++) {
        // if size is 1, then this position has already been collpased
        // and thus has no entropy
        // note that collapsing can happen via propagation and not necessarily
        // by observation
        if (wf.get(x, y).size() == 1) {
          continue;
        }

        double entropy = wf.getShannonEntropy(x, y);

        if (entropy < minEntropy) {
          minEntropy = entropy;
          coords.set(x, y);
        }
      }
    }




    return coords;
  }


  void displayImage() {
    
    //println(wf);
    
    for(int x = 0; x < wf.outputWidth; x++) {
     for(int y = 0; y < wf.outputHeight; y++) {
        Tile t = wf.getCollapsed(x,y);
        t.drawAt(x*dimension, y*dimension);

     }
    }

    System.out.println("DONE?");
  }
}
