class GameEnviroment {

    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;
    MoneySpawner monies;
    color skyColor = color(135, 206, 235);
    float waterHeight = 650;
    int gameSpeed =5;
    int score;
    int timer = 30;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip(waterHeight,gameSpeed);
        water = new GameWater(gameSpeed);
        monies = new MoneySpawner(gameSpeed, ship, this);
    }


  void update() {
        ship.update();
        monies.update();
        if (frameCount%frameRate==0){
              timer--;
        }
        if (timer <=0){
              mainRef.setState(3);
        }
  }

  void render() {
        background(skyColor);      
        water.render(waterHeight);
        ship.render();
        monies.render();
        
  }

  void mousePressedEvent() {
        ship.push();
  }

  void addPoint(){
        score++;
  }
}
