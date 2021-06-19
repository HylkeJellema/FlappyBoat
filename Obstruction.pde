class Obstruction {
  Flock herd;
  Obstruction mousepos;
  PVector mouse;
  
  

  void update  (PVector mouse) {

    herd.update(mouse);
    //tempY = posy;
    //tempX = posx;
  }

  void render  (PVector mouse) {
    noStroke();
    fill(0, 0);
    ellipse(mouse.x, mouse.y, 150, 150);
  }
}// ipv muis 
