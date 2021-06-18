class MenuEnviroment {

  int buttonPosx, buttonPosy, size; // position and size of the start button 
  color buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activiting the next phase of the game


  Flock flock;
  MainEnviroment mainRef;
  Movie backgroundWater;

  MenuEnviroment(MainEnviroment mainRef) {
    //Video related
    this.mainRef = mainRef;
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();
    
    //Button related 
    buttonPosx = width/2;
    buttonPosy = height/2;
    size = 100;
    buttonColor = color(32, 160, 232);
    hoverColor = color(52, 86, 105);
    hoverOver = false;
    //Flocking related
    
    
  }

  void update(PVector mouse, PVector screenSize) {
    if (dist(mouse.x, mouse.y, buttonPosx, buttonPosy) < size) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    if (hoverOver && mousePressed) {
      mainEnviroment.state = 2;
    }
  }

  void render() {
    image(backgroundWater, 0, 0, 1400, 800 );// drawing video and resizing it

    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPosx, buttonPosy, size);
    fill(0);
    text("Press to start", buttonPosx-35, buttonPosy);
  }
}
