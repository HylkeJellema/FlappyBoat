class GameEnviroment {

    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;
    MoneySpawner monies;
    color skyColor = color(135, 206, 235);
    float waterHeight = 650;
    int gameSpeed =5;
    int score;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip(waterHeight,gameSpeed);
        water = new GameWater(gameSpeed);
        monies = new MoneySpawner(gameSpeed, ship);
    }


  void update() {
        ship.update();
        monies.update();
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
