class Obstruction{
float posx, posy, size;

  
  Obstruction(float tempX, float tempY){   
  tempX = posx;
  tempY = posy;
  size = 150;
  }
  
  void render(){
    noStroke();
    fill(0,0);
    ellipse(posx, posy, size, size);
  }
}
