class MenuEnviroment {

  PVector buttonPos; //position of start button
  int buttonSize; // size of the start button 
  color buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activating the next phase of the game
  PImage CoverImage;

  Flock group;
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
    CoverImage = loadImage("Coverimage.png");
    group = new Flock();
    for (int i = 0; i < 150; i++) {
      Fish f = new Fish(new PVector(random(width), random(height)));
      group.run(f);
    }
  }


  void update(PVector mouse) {
    if (dist(mouse.x, mouse.y, buttonPos.x, buttonPos.y) < buttonSize/2) { //if hovering the boolean is changed for later use in render
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    group.update(mouse);
  }

  void mousePressedEvent() {
    if (hoverOver) { //goes to game when button is pressed
      mainRef.setState(2);
    }
  }

  void render() {

    image(backgroundWater, 0, 0);// drawing video
    group.render();
    image(CoverImage, 0, 0);

    if (hoverOver) { //draws button
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPos.x, buttonPos.y, buttonSize);
    fill(255);
    textSize(25);
    String s = "Start";
    text(s, buttonPos.x-(textWidth(s)/2), buttonPos.y+10);
  }
}
