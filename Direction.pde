/*
  A wrapper class for Directions. Used in the construction of Compatibility and for finding valid Directions 
  i.e. the Directions in which a tile is still within the bounds of the image. 
*/

class Direction {
  int x;
  int y;
  public Direction(int x, int y) {
    this.x = x;
    this.y = y;
  }

  @Override
    public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }

    if (obj == null || !(obj instanceof Direction)) {
      return false;
    }

    Direction other = (Direction)obj;

    return this.x == other.x && this.y == other.y;
  }

  @Override
    public int hashCode() {
    return x * 5 + y * 7;
  }

  @Override
    public String toString() {
    return "(" + this.x + "," + this.y + ")";
  }
}
