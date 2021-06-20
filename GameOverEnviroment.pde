class GameOverEnviroment {
  PImage gameOverImage;

  MainEnviroment mainRef;
  Movie backgroundWater;

  GameOverEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;

    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.play();
    gameOverImage = loadImage("Gamedone.png");
  }

  void update(PVector mouse) {
  }

  void render() {     
    image(backgroundWater, 0, 0);
    gameOverImage.get();    
   image(gameOverImage, 0, 0);
  }
}
