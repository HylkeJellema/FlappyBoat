class GameOverEnviroment {
  PImage gameOverImage;

  MainEnviroment mainRef;
  Movie backgroundWater;

  GameOverEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;

    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();
    gameOverImage = loadImage("Gameoverimage.png");
  }

  void update(PVector mouse) {
  }

  void render() {
    image(backgroundWater, 0, 0, width, height );// drawing video and resizing it
    //image(gameOverImage, 0, 0);
  }
}
