class GameWater {
  GameEnviroment game;
  float incline, start;
  color waterColor = color(17, 	136, 	234);
  int gameSpeed;

  GameWater(int gameSpeed) {
    incline = 0.01;
    start = 0;
    this.gameSpeed = gameSpeed;
  }

  void render(float waterHeight) {
    fill(waterColor); //draws shape using perlinnoise
    beginShape();
    float yOff = start;
    vertex(0, height);
    for (float i = 0; i < width; i+=gameSpeed) {
      float y = noise(yOff) *50 +waterHeight;
      yOff += incline;
      vertex(i, y);
    }
    vertex(width, height);
    endShape();
    start += incline;
  }
}
