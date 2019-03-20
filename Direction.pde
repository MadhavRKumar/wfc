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
