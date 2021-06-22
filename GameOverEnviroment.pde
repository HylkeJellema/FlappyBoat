class GameOverEnviroment { //enviroment for gameover stage
  PImage gameOverImage;

  MainEnviroment mainRef;
  Movie backgroundWater;
  GameEnviroment gameEnviromentRef;

  GameOverEnviroment(MainEnviroment mainRef, GameEnviroment gameEnviromentRef) {
    this.gameEnviromentRef = gameEnviromentRef;
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    gameOverImage = loadImage("Gamedone.png");
  }

  void update() {
    backgroundWater.loop();
  }

  void render() {     
    image(backgroundWater, 0, 0);   
    imageMode(CORNER);
    image(gameOverImage, 0, 0);
    textSize(30);
    String s ="score: " + gameEnviromentRef.score; //takes score from previous stage
    text(s, width/2 - (textWidth(s)/2), height*3/4);
  }
}
