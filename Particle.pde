class Particle {

  int life, state;
  PVector location, velocity, gameSpeed;

  Particle(PVector origin, int state, int gameSpeed) {
    this.gameSpeed = new PVector(gameSpeed*(-1), 0);
    life = 255; //gives particle a lifetime which is later used in the alpha channel of the circle render.
    location = origin;
    velocity = PVector.random2D(); //give random direction with scaler 1 then multiply with random scalar.
    velocity.mult(random(2));
    this.state=state;
  } 
  void update() { //adds velocity to location
    life-=3;
    location.add(velocity);
    location.add(gameSpeed);
  }

  void render() { //renders the particle
    if (state==1) { //as a star when flying
      fill(255, 255, 0, life);
      star(location.x, location.y, 5, 15, 5);
    }
    if (state==2) { //circle when in water
      fill(0, 0, 255, life);
      circle(location.x, location.y, 5);
    }
  }

  boolean isDead() { //return true if dead and gets removed
    if (life>0) {
      return false;
    } else {
      return true;
    }
  }

  void star(float x, float y, float radius1, float radius2, int npoints) { //stolen from processing website because stars are cooler then circles and im deff not making it myself ;)
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
