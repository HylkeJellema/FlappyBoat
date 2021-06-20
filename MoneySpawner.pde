class MoneySpawner {
    int gameSpeed;
    ArrayList<Money> money;
    PirateShip ship;
  
    MoneySpawner(int gameSpeed, PirateShip ship) {
        this.gameSpeed = gameSpeed;
        money = new ArrayList<Money>();
        this.ship = ship;
    }
  
    void update() {
        if (frameCount%60==0){
            money.add(new Money(ship));
        }
        
        for (int i = money.size()-1; i >= 0; i--) { //updates bills
            Money bill = money.get(i);
            bill.update();
            if (bill.isDead()) { //removes out of bound money
                money.remove(i);
            }
        }
    }
    
    void render() { //render all particles
        for (Money bill : money) {
            bill.render();
        }
    }
}


