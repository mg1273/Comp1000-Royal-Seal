class canGarbage {
  float x;
  float y;

  canGarbage(float grabX, float grabY) {
    x = grabX;
    y = grabY;
  }

  void display() {
    fill(190);
    rect(x-25, y, 50, 60);
    ellipse(x, y, 50, 15);
    ellipse(x, y+60, 50, 15);
    noStroke();
    rect(x-24, y+60, 49, -30);
    stroke(0);
  }
}
