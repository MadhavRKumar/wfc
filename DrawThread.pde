public class DrawThread extends Thread {
  
  int minX;
  int minY;
  
  int maxX;
  int maxY;
  
  Wavefunction wf;
  
  public DrawThread(int minX, int minY, int maxX, int maxY, Wavefunction wf) {
    this.minX = minX;
    this.minY = minY;
    
    this.maxX = maxX;
    this.maxY = maxY;
    
    this.wf = wf;
  }
  
  public void run() {
    loadPixels();
    for(int x = minX; x < maxX; x++) {
     for(int y = minY; y < maxY; y++) {
        Tile t = wf.getCollapsed(x,y);
        t.drawAt(x*dimension, y*dimension);

     }
    }
    updatePixels();
   }
  
  
}
