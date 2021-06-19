class GameWater {

  float yoff;
  float location;
  float waterLineHeight;
  color waterColor = color(30, 180, 30);


  GameWater(float index) {
    location = index+1;
    yoff = index/100;
  }

  void update() {        
    waterLineHeight = noise(yoff) * 200;
    yoff += 0.01;
  }
  void render() {        
    fill(waterColor);
    rect(width - (location*10), height-waterLineHeight, 10, waterLineHeight);
  }
}
