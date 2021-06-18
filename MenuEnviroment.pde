class MenuEnviroment {

  PVector buttonPos, bannerPos, bannerSize;
  int buttonSize; // size of the start button 
  color buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activiting the next phase of the game


  Flock flock;
  MainEnviroment mainRef;
  Movie backgroundWater;

  MenuEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;
     //Video related
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();

    //Button related 
    buttonPos = new PVector(width/2, height/2);
    bannerPos = new PVector(width/2, height/5);
    bannerSize = new PVector(600,200);
    
    buttonSize = 100;
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
    if (dist(mouse.x, mouse.y, buttonPos.x, buttonPos.y) < buttonSize/2) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    if (hoverOver && mousePressed) {
      mainRef.setState(2);
    }
  }

  void render() {
    image(backgroundWater, 0, 0, width, height );// drawing video and resizing it
    flock.run();

    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPos.x, buttonPos.y, buttonSize);
    fill(0);
    textSize(12);
    text("Press to start", buttonPos.x-40, buttonPos.y);
    fill(buttonColor);
    rectMode(CENTER);
    rect(bannerPos.x, bannerPos.y, bannerSize.x,bannerSize.y);
    fill(0);
    textSize(20);
    text("Flappy Boat made my Hylke Jellema and Marc Harinck", bannerPos.x, bannerPos.y);
  }
}
