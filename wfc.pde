long seed = System.nanoTime();

PImage img = new PImage();


void setup() {
  noiseSeed(seed);
  randomSeed(seed);
  size(1000, 1000);
  
  selectInput("Select file to process: ", "fileSelected");
}


void fileSelected(File f) {
    img = loadImage(f.getPath());
}

void draw() {

}


void keyPressed() {
   if(keyCode == ENTER){
    saveImage(); 
   }
}




/////////////////////////  Saving Image, defaults to closing  /////////////////////////

void saveImage(boolean shouldClose) {
  String name = seed + ".png";
  save(name);
  if (shouldClose) {
    exit();
  }
}

void saveImage() {
  saveImage(true);
}
