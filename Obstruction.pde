class Obstruction {
  float posx, posy;

  Obstruction(PVector mouse) {
    
    tempY = posy;
    tempX = posx;
  }

  void render(PVector mouse) {
    noStroke();
    fill(0, 0);
    ellipse(mouse.x,mouse.y, 150, 150);
  }
}// ipv muis 
