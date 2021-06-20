class Money {
    PVector location, velocity;
    PImage billSprite;
    PirateShip ship;
  
    Money(PirateShip ship) {
        location = new PVector(width+30, random(100, height-100));
        velocity = new PVector(-5,0);
        billSprite = loadImage("money.png");
        this.ship = ship;
    }
  
    void update() {
        location.add(velocity);
    }
  
    void render() {
        imageMode(CENTER);
        image(billSprite,location.x,location.y);
    }

    boolean isDead(){
        if (location.x<-30){
            return true;
        } else {
            return false;
        }
    }
    boolean isHit(){
        if (dist(ship.xPos, ship.yPos, location.x, location.y)<40){
            return true;
        } else {
            return false;
        }
    }
}
