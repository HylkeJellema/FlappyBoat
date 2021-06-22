class MoneySpawner {
  int gameSpeed;
  ArrayList<Money> money;
  PirateShip ship;
  GameEnviroment game;

  MoneySpawner(int gameSpeed, PirateShip ship, GameEnviroment game) {
    this.gameSpeed = gameSpeed;
    money = new ArrayList<Money>();
    this.ship = ship;
    this.game = game;
  }

  void update() {
    if (frameCount%60==0) { //spawns money every second
      money.add(new Money(ship));
    }

    for (int i = money.size()-1; i >= 0; i--) { //updates bills
      Money bill = money.get(i);
      bill.update();
      if (bill.isDead()) { //removes out of bound money
        money.remove(i);
      }
      if (bill.isHit()) { //removes hit money and adds point
        money.remove(i);
        game.addPoint();
      }
    }
  }

  void render() { //render all particles
    for (Money bill : money) {
      bill.render();
    }
  }
}
