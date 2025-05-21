class fishGuy {
  float x;
  float y;

  fishGuy(float grabX, float grabY) {
    x = grabX;
    y = grabY;
  }

  void display() {
  fill(100, 180, 255);
  triangle(x+20,y,x+40,y+20,x+40,y-20);
  ellipse(x,y, 60,30);
  fill(0);
  circle(x-20, y, 5);
  }
}
