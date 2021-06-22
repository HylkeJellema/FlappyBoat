class PirateShip {

  PImage boat;
  MassSpringDamper mSD;
  ParticleSystem stars;
  int state = 2;
  float jumpVelocity=8;
  float minAngle = - 50;
  float maxAngle = 20;
  float gravity = 0.4;
  float xPos;
  float yPos = 650;
  float size = 100;
  float waterHeight;
  float maxVelocity = -7;
  float velocity;
  float angle;

  PirateShip(float waterHeight, int gameSpeed) {
    xPos=width/4;
    boat = loadImage("pirateShip.png");
    this.waterHeight = waterHeight;
    mSD = new MassSpringDamper();
    stars = new ParticleSystem(gameSpeed);
  }

  void update() {
    stars.update(state, new PVector(xPos, yPos)); //updates stars and water particles

    if (yPos>waterHeight && state==1 && !mSD.isActive() && velocity<1) { //when boat hits water state is set to active MSD
      state = 2;
      yPos-=1;
      mSD.setIncomingVelocity(velocity);
      mSD.setActive(true);
    }

    switch (state) {
    case 1 : //when in air gravity effects boat
      if (velocity > -10) {
        velocity -= gravity;
      }
      break;	

    case 2 : //when on water MSD is active
      mSD.calculate();
      velocity = mSD.getVelocity(); 
      break;
    }
    if (velocity <= 0) { //calculates angle
      angle = velocity / jumpVelocity * minAngle;
    } else {
      angle = velocity / maxVelocity * maxAngle;
    }
    yPos-=velocity;  //velocity is added (no PVectors cause x and y are always seperate)
  }

  void render() {
    stars.render();

    pushMatrix();
    imageMode(CENTER);
    translate(xPos, yPos);
    rotate(radians(angle));
    image(boat, 0, 0, size, size);
    popMatrix();
  }

  void push() { //makes the ship jump
    velocity = jumpVelocity; 
    state = 1; //state set to flying
    mSD.setActive(false); //MSD not active and reset
    mSD.reset();
  }
}
