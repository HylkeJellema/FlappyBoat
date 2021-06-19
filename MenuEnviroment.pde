class MenuEnviroment {

  PVector buttonPos;
  int buttonSize; // size of the start button 
  color buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activating the next phase of the game
  PImage CoverImage;

  Flock flock;
  MainEnviroment mainRef;
  Movie backgroundWater;

  MenuEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;
    //Video related
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();

    //Button related 
    buttonPos = new PVector(width/2, height * 3/4);
    buttonSize = 100;
    buttonColor = color(32, 160, 232);
    hoverColor = color(52, 86, 105);
    hoverOver = false;
    
    //Flocking related
    flock = new Flock(); 
    for (int i = 0; i < 150; i++) {
      Boid b = new Boid(random(width), random(height));
      flock.addBoid(b);
      CoverImage = loadImage("Coverimage.png");
    }
  }

  void update(PVector mouse) {
  //  obstruction.render(mouse);
    if (dist(mouse.x, mouse.y, buttonPos.x, buttonPos.y) < buttonSize/2) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    if (hoverOver && mousePressed) {
      mainRef.setState(2);
    }
      flock.run(mouse);
  }

  void render( ) {
    image(backgroundWater, 0, 0, width, height );// drawing video and resizing it
    image(CoverImage, 0, 0);
    

    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPos.x, buttonPos.y, buttonSize);
    fill(0);
    textSize(12);
    text("Press to start", buttonPos.x-40, buttonPos.y);
  }
}
