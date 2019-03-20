

class Wavefunction {
  HashMap<Tile, Integer> weights;
  Set[] coefficients;
  
  public Wavefunction(HashMap<Tile,Integer> weights) {
    this.weights = weights;
    initCoefficients(weights.keySet());
    
  }
  
  
  void initCoefficients(Set<Tile> tiles) {
    
    
  }
  
  
  
  
}
