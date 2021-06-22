class Money {
  PVector location, velocity;
  PImage billSprite;
  PirateShip ship;

  Money(PirateShip ship) {
    location = new PVector(width+30, random(100, height-100)); //random start location
    velocity = new PVector(-5, 0); //constant speed
    billSprite = loadImage("money.png");
    this.ship = ship;
  }

  void update() {
    location.add(velocity); //adds velocity
  }

  void render() {
    imageMode(CENTER);
    image(billSprite, location.x, location.y);
  }

  boolean isDead() {
    if (location.x<-30) { //if out of screen returns true and is removed 
      return true;
    } else {
      return false;
    }
  }
  boolean isHit() {
    if (dist(ship.xPos, ship.yPos, location.x, location.y)<60) { //when hit return true is removed and adds score
      return true;
    } else {
      return false;
    }
  }
}
