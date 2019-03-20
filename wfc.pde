import java.util.HashSet;
import java.util.HashMap;
import java.util.Arrays;
import java.util.Set;

long seed = System.nanoTime();

//input that the output is based on
PImage img = new PImage();



final Direction up = new Direction(0, -1);
final Direction down = new Direction(0, 1);
final Direction left = new Direction(-1, 0);
final Direction right = new Direction(1, 0);


final Direction[] DIRS = {up, down, left, right};




HashSet<Compatibility> parseInput(PImage img, int n, int m) {
  HashSet<Compatibility> compats = new HashSet<Compatibility>();

  for (int i = 0; i < img.height; i+=m) {
    for (int j = 0; j < img.width; j+=n) {
      Tile newTile = new Tile(j, i, n, m);
      ArrayList<Direction> validDirs = getValidDirections(j, i);
      for (Direction d : validDirs) {
        Tile otherTile = new Tile(j+d.x, i+d.y, n, m);
        Compatibility compat = new Compatibility(newTile, otherTile, d);
        compats.add(compat);
      }
    }
  }

  return compats;
}

ArrayList<Direction> getValidDirections(int x, int y) {

  ArrayList<Direction> dirs = new ArrayList<Direction>();

  if (y-1 >= 0) {
    dirs.add(up);
  }

  if (y+1 < img.height) {
    dirs.add(down);
  }

  if (x-1 >= 0) {
    dirs.add(left);
  }

  if (x+1 < img.width) {
    dirs.add(right);
  }

  return dirs;
}

HashMap<Tile, Integer> calculateWeights(int n, int m) {
  HashMap<Tile, Integer> weights = new HashMap<Tile, Integer>();
  for (int i = 0; i < img.height; i+=m) {
    for (int j = 0; j < img.width; j+=n) {
      Tile newTile = new Tile(j, i, n, m);
      if (!weights.containsKey(newTile)) {
        weights.put(newTile, 0);
      }
      else {
       weights.put(newTile, weights.get(newTile)+1);
      }
    }
  }


  return weights;
}


void fileSelected(File f) {
  img = loadImage(f.getPath());
  int dimensionX = 1, dimensionY = 1;

  //Generate tile compatibilities and weights from input image 
  HashSet<Compatibility> compats = parseInput(img, dimensionX, dimensionY);
  HashMap<Tile, Integer> weights = calculateWeights(dimensionX, dimensionY);
   

}


void setup() {
  noiseSeed(seed);
  randomSeed(seed);
  size(1000, 1000);
  selectInput("Select file to process: ", "fileSelected");
}


void draw() {
}




void keyPressed() {
  if (keyCode == ENTER) {
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
