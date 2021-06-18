class Obstruction{
  float posX;
  float posY;
  
  Obstruction(float tempX, float tempY){   
    posX = tempX;
    posY = tempY;
  }
  
  void render(){
    noStroke();
    fill(0,0);
    ellipse(posX, posY, 100, 100);
  }
}
