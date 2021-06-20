class GameEnviroment {

    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;
    BuoySpawner boeiMaarDanMeervoud;
    color skyColor = color(135, 206, 235);
    float waterHeight = 650;
    int gameSpeed =5;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip(waterHeight,gameSpeed);
        water = new GameWater(gameSpeed);
        boeiMaarDanMeervoud = new BuoySpawner(gameSpeed, waterHeight);
    }


  void update() {
        ship.update();
  }

  void render() {
        background(skyColor);      
        water.render(waterHeight);
        ship.render();
        
  }

  void mousePressedEvent() {
        ship.push();
  }
}
