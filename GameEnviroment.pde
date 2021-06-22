class GameEnviroment {

  MainEnviroment mainRef;
  PirateShip ship; //this ship object
  GameWater water; //perlin noice water
  MoneySpawner monies; //bills in the air
  float waterHeight = 650; //yPos of where the water line is
  int gameSpeed =5; //speed at which the game runs influence water and particles, not bills
  int score; //current score
  int timer = 30; //counts down in seconds
  PImage background;

  GameEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;
    ship = new PirateShip(waterHeight, gameSpeed);
    water = new GameWater(gameSpeed);
    monies = new MoneySpawner(gameSpeed, ship, this);
    background = loadImage("background.png");
  }

  void update() {
    ship.update();
    monies.update();
    if ((frameCount%60)==0) { //after every 60 frames a second passes and timer is decreased.
      timer--;
    }
    if (timer <=0) { //when timer reaches 0 next state starts
      mainRef.setState(3);
    }
  }


  void render() { 
    imageMode(CORNER);
    image(background, 0, 0);    
    water.render(waterHeight);
    ship.render();
    monies.render();

    textSize(23); //render score and timer
    fill(255);
    text("Score " + score, width - 200, height / 10 );
    text("Timer " + timer, width - 200, height / 8);
  }

  void mousePressedEvent() { //makes the ship fly
    ship.push();
  }

  void addPoint() { //adding point method
    score++;
  }
}
