/*
  This is a class that establishes what tiles can be next to each other
   and in what direction they can be next to each other
 */

class Compatibility {
  Tile curTile;
  Tile otherTile;
  Direction direction;

  public Compatibility(Tile curTile, Tile otherTile, Direction direction) {
    this.curTile = curTile;
    this.otherTile = otherTile;
    this.direction = direction;
  }

  /*
  Testing for equality of Compatibility allows us to use a HashSet
   */
  @Override
    public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }

    if (obj == null || !(obj instanceof Compatibility)) {
      return false;
    }

    Compatibility other = (Compatibility)obj;

    return other.curTile.equals(curTile) && other.otherTile.equals(otherTile) && direction.equals(other.direction);
  }
  
  @Override
    public int hashCode() {
     return curTile.hashCode() + otherTile.hashCode() + direction.hashCode(); 
    }

  @Override
    public String toString() {
    return "<" + curTile.toString() + ", " + otherTile.toString() + " - " + direction.toString() + ">";
  }
}
