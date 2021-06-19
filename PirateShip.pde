class PirateShip {

  PImage boat;
  MainEnviroment mainRef;
  float xPos, direction, size;
  int state;
  int flying = 1;

  PirateShip() {
    boat = loadImage("pirateShip.png");
    direction = 0;
    size=100;
    xPos=700;
  }


  void update() {
  }

  void render() {
    pushMatrix();
    imageMode(CENTER);
    rotate(direction);
    image(boat, width/4, xPos, size, size*1.38);
    popMatrix();
  }

  void push() {
  }
}
