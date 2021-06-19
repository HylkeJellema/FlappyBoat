class GameEnviroment {

  MainEnviroment mainRef;
  PirateShip ship;
  GameWater water;
  color skyColor = color(135, 206, 235);
  float waterHeight;

  GameEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;
    ship = new PirateShip();
  }

  void update(PVector mouse) {
    ship.update();
  }

  void render() {
    background(skyColor);
    ship.render();
  }

  void mousePressedEvent() {
    ship.push();
  }
}
