class MoneySpawner {
    int gameSpeed;
    ArrayList<Money> money;
  
    MoneySpawner(int gameSpeed) {
        this.gameSpeed = gameSpeed;
        money = new ArrayList<Money>();
        

    }
  
    void update() {
        
        this.location = location;

        if (frameCount%60==0){
            particles.add();
        }
        
        for (int i = money.size()-1; i >= 0; i--) { //updates all particles
            Particle bill = money.get(i);
            bill.update();
            if (bill.isDead()) { //removes out of bound money
                money.remove(i);
            }
        }
    }
    
    void render() { //render all particles
        for (Particle p : particles) {
            p.render();
        }
    }
}


