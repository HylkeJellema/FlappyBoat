class GameWater {
  GameEnviroment game;
  GameWater wetness;
  float incline, start;

  GameWater() {
    incline = 0.005;
    start = 0;
  }

  void update() {
  }

  void render() {
    beginShape();
    float yo = start;
    for (float x = 0; x < width; x++) {
      float y = noise(yo) *370 +250 ;
      yo += incline;
      vertex(x, y);
    }
    endShape();
    yo += incline;
  }
}
