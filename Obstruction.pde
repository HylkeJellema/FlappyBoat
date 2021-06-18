class Obstruction {
  float posx, posy;

  Obstruction(float tempX, float tempY) {
    
    tempY = posy;
    tempX = posx;
  }

  void render() {
    noStroke();
    fill(0, 0);
    ellipse(posx, posy, 150, 150);
  }
}// ipv muis 
