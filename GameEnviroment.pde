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
        if ((frameCount%60)==0){
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
        textSize(23);
        fill(255,255,255);
        text("Score " + score, width-200, height / 10 );
        text("Timer " + timer, width - 200, height / 8);
        
        
  }

  void mousePressedEvent() {
        ship.push();
  }

  void addPoint(){
        score++;
  }


}
