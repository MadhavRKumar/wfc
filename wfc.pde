import java.util.HashSet;
import java.util.HashMap;
import java.util.Arrays;
import java.util.Set;
import java.util.Stack;

long seed = System.nanoTime();

//input that the output is based on
PImage img = new PImage();

final int dimension = 4;
void settings() {
  int w = (int)Math.pow(dimension, 5);
  size(w, w);
}



final Direction up = new Direction(0, -1);
final Direction down = new Direction(0, 1);
final Direction left = new Direction(-1, 0);
final Direction right = new Direction(1, 0);


final Direction[] DIRS = {up, down, left, right};



/*
  Goes through the input image and breaks it into NxM patterns.
 For each NxM pattern (or tile) it then looks around and creates
 compatibilities with its neighboring tiles
 */
HashSet<Compatibility> parseInput(PImage img, int n, int m) {
  HashSet<Compatibility> compats = new HashSet<Compatibility>();

  for (int i = 0; i < img.height; i+=m) {
    for (int j = 0; j < img.width; j+=n) {
      Tile newTile = new Tile(j, i, n, m);
      ArrayList<Direction> validDirs = getValidDirections(j, i, img.width, img.height, dimension);
      for (Direction d : validDirs) {
        Tile otherTile = new Tile(j+d.x*dimension, i+d.y*dimension, n, m);
        Compatibility compat = new Compatibility(newTile, otherTile, d);
        compats.add(compat);
      }
    }
  }

  return compats;
}


/*
Generic helper function that gives valid directions based on position, grid dimensions,
 and increment value.
 */
ArrayList<Direction> getValidDirections(int x, int y, int w, int h, int inc) {

  ArrayList<Direction> dirs = new ArrayList<Direction>();

  if (y-(inc) >= 0) {
    dirs.add(up);
  }

  if (y+(inc) < h) {
    dirs.add(down);
  }

  if (x-(inc) >= 0) {
    dirs.add(left);
  }

  if (x+(inc) < w) {
    dirs.add(right);
  }

  return dirs;
}


/*
Like parseInput, this goes through the input but calculates
 the weight of eache pattern(tile) and puts it into a dictionary
 */
HashMap<Tile, Integer> calculateWeights(int n, int m) {
  HashMap<Tile, Integer> weights = new HashMap<Tile, Integer>();
  for (int i = 0; i < img.height; i+=m) {
    for (int j = 0; j < img.width; j+=n) {
      Tile newTile = new Tile(j, i, n, m);
      if (!weights.containsKey(newTile)) {
        weights.put(newTile, 1);
      } else {
        weights.put(newTile, weights.get(newTile)+1);
      }
    }
  }


  return weights;
}


void fileSelected(File f) {
  if (f != null) {
    img = loadImage(f.getPath());

    //Generate tile compatibilities and weights from input image 
    HashSet<Compatibility> compats = parseInput(img, dimension, dimension);
    HashMap<Tile, Integer> weights = calculateWeights(dimension, dimension);

    Model model = new Model(weights, compats);
    model.run();
 
  }
}



void setup() {
  noiseSeed(seed);
  randomSeed(seed);
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
