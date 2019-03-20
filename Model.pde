
class Model {
  Wavefunction wf; HashSet<Compatibility> compats;
  
  public Model(HashMap<Tile, Integer> weights, HashSet<Compatibility> compats) {
    this.compats = compats;  
    wf = new Wavefunction(width, height, weights);
  }
  
  
  void run() {
    while(!wf.isFullyCollapsed()) { //<>//
      PVector coords = findMinEntropy();
      int x = (int)coords.x;
      int y = (int)coords.y;
      wf.collapse(x,y);
      propagate(x,y);
    }
    
    displayImage();
  }
  
  void propagate(int x, int y) {
    Stack<Tile> stack = new Stack<Tile>();
    stack.push(wf.getCollapsed(x,y));
    
    while(stack.size() > 0) {
     Tile curTile = stack.pop();
     Set<Tile> curPossibleTiles = wf.get(curTile.x, curTile.y);

     for(Direction dir : getValidDirections(curTile.x, curTile.y, width, height)) {
       int otherX = curTile.x + dir.x*curTile.tileWidth;
       int otherY = curTile.y + dir.y*curTile.tileHeight;
       
       Set<Tile> iter = new HashSet<Tile>(wf.get(otherX, otherY));
       for(Tile other : iter) {
         boolean isOtherTilePossible = false;
         
         for(Tile t : curPossibleTiles) {
            Compatibility compat = new Compatibility(t, other, dir);
            isOtherTilePossible = isOtherTilePossible || compats.contains(compat);
         }
         
         if(!isOtherTilePossible) {
           wf.constrain(otherX, otherY, other);
           stack.push(other);
         }
         
       }
     }
     
    }
  }
  
  
  PVector findMinEntropy() {
    PVector coords = new PVector();
    double minEntropy = Integer.MAX_VALUE;
    for(int x = 0; x < width; x++) { //<>//
     for(int y = 0; y < height; y++) {
       // if size is 1, then this position has already been collpased
       // and thus has no entropy
       // note that collapsing can happen via propagation and not necessarily
       // by observation
        if(wf.get(x,y).size() == 1) {
          continue;
        }
        
        double entropy = wf.getShannonEntropy(x,y);
        
       if(entropy < minEntropy) {
         minEntropy = entropy;
         coords.set(x,y);
       }
     }
    }
    
    
    
    
    return coords;
    
  }
  
  
  void displayImage() {
    
    System.out.println("DONE?");
  }
  
}
