class GameOverEnviroment {
  PImage gameOverImage;

  MainEnviroment mainRef;
  Movie backgroundWater;
  GameEnviroment gameEnviromentRef;

  GameOverEnviroment(MainEnviroment mainRef, GameEnviroment gameEnviromentRef) {
    this.mainRef = mainRef;
    this.gameEnviromentRef = gameEnviromentRef;
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.play();
    gameOverImage = loadImage("Gamedone.png");
  }

  void update() {
  }

  void render() {     
    image(backgroundWater, 0, 0);
    gameOverImage.get();    
    image(gameOverImage, 0, 0);
  }
}
