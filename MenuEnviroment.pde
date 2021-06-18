class MenuEnviroment {

  PVector buttonPos;
  int size; // position and size of the start button 
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
buttonPos = new PVector(width/2, height/2);
    size = 100;
    buttonColor = color(32, 160, 232);
    hoverColor = color(52, 86, 105);
    hoverOver = false;
    //Flocking related
    flock = new Flock(); 
    for (int i = 0; i < 150; i++) {
      Boid b = new Boid(random(width), random(height));
      flock.addBoid(b);
    }
  }

  void update(PVector mouse, PVector screenSize) {
    if (dist(mouse.x, mouse.y, buttonPosx, buttonPosy) < size/2) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    if (hoverOver && mousePressed) {
      mainRef.setState(2);
    }
  }

  void render() {
    image(backgroundWater, 0, 0, 1400, 800 );// drawing video and resizing it
    flock.run();

    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPos.x, buttonPos.y, size);
    fill(0);
    text("Press to start", buttonPos.x-35, buttonPos.y);
    
  }
}
