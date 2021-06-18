class MenuEnviroment {

  int buttonPosx, buttonPosy, size; // position and size of the start button 
  color buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activiting the next phase of the game


  Flock flock;
  MainEnviroment mainRef;
  Movie backgroundWater;

  MenuEnviroment(MainEnviroment mainRef) {
    //Video related
    this.mainRef = mainRef;
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();
    
    //Button related 
    buttonPosx = width/2;
    buttonPosy = height/2;
    size = 100;
    buttonColor = color(32, 160, 232);
    hoverColor = color(52, 86, 105);
    hoverOver = false;
    //Flocking related
    
    
  }

  void update(PVector mouse, PVector screenSize) {
    if (dist(mouse.x, mouse.y, buttonPosx, buttonPosy) < size) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
    if (hoverOver && mousePressed) {
      mainEnviroment.state = 2;
    }
  }

  void render() {
    image(backgroundWater, 0, 0, 1400, 800 );// drawing video and resizing it

    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPosx, buttonPosy, size);
    fill(0);
    text("Press to start", buttonPosx-35, buttonPosy);
  }
}

class Obstruction{
  class Boid {
  Obstruction wall;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float size;
  float maxforce;    
  float maxvelocity;    
  PVector objPos;

  Boid(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    position = new PVector(x, y);
    objPos = new PVector(150, 100);
    size = 6.0; //
    maxvelocity = 2;
    maxforce = 0.05;
    wall= new Obstruction(objPos.x, objPos.y);
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }


  void flock(ArrayList<Boid> boids) {
    PVector separate = separate(boids);   // Separation
    PVector align = align(boids);      // Alignment
    PVector cohhesion = cohesion(boids);   // Cohesion
    PVector avoid = avoid(boids);      //evasion
    // mass of forces eq
    avoid.mult(2); //weight
    separate.mult(1.5);
    align.mult(1.0);
    cohhesion.mult(1.0);

    // force vector 
    applyForce(avoid);
    applyForce(separate);
    applyForce(align);
    applyForce(cohhesion);
  }


  void update() {
    velocity.add(acceleration);
    velocity.limit(maxvelocity);
    position.add(velocity);
    acceleration.mult(0);
  }

  PVector locate(PVector goal) {
    PVector optimal = PVector.sub(goal, position);  // A vector pointing from the position to the goal
    optimal.normalize();
    optimal.mult(maxvelocity);
    // turning = optimal minus Velocity
    PVector turn = PVector.sub(optimal, velocity);
    turn.limit(maxforce);  
    return turn;
  }

  void render() {
    fill(255, 0, 0);
    ellipse(position.x, position.y, size, size);
    wall.render();
  }


  //object evasion
  PVector avoid (ArrayList<Boid> boids) {
    PVector turn = new PVector(0, 0);
    int counter = 0;

    for (Boid other : boids) {
      float d = PVector.dist(objPos, position);
      if (d<80) {
        PVector diff = PVector.sub(position, objPos);
        diff.normalize();
        diff.div(d);
        turn.add(diff);
        counter++;
      }
    }

    if (counter>0) {
      turn.div((float)counter);
    }

    if (turn.mag()>0) {
      turn.normalize();
      turn.mult(maxvelocity);
      turn.sub(velocity);
      turn.limit(maxforce);
    }
    return turn;
  }

  // Separation for boids
    PVector separate (ArrayList<Boid> boids) {
    float optimalseparation = 25.0f;
    PVector turn = new PVector(0, 0, 0);
    int counter = 0;

    
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
       if ((d > 0) && (d < optimalseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        turn.add(diff);
        counter++;            // Keep track of how many
      }
    }


    // Average -- divide by how many
    if (counter > 0) {
      turn.div((float)counter);
    }

    
    if (turn.mag() > 0) {
      // Implement Reynolds: turning = optimal - Velocity
      turn.normalize();
      turn.mult(maxvelocity);
      turn.sub(velocity);
      turn.limit(maxforce);
    }
    return turn;
  }



  // Alignment
   PVector align (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector product = new PVector(0, 0);
    int counter = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        product.add(other.velocity);
        counter++;
      }
    }
    if (counter > 0) {
      product.div((float)counter);
      product.normalize();
      product.mult(maxvelocity);
      PVector turn = PVector.sub(product, velocity);
      turn.limit(maxforce);
      return turn;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  
  PVector cohesion (ArrayList<Boid> boids) {
    float neighbordist = 50;
    PVector product = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int counter = 0;
    for (Boid other : boids) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        product.add(other.position); // Add position
        counter++;
        
      }
    }
    if (counter > 0) {
      product.div(counter);
      return locate(product);  
    } else {
      return new PVector(0, 0);
    }
  }
  void borders() {
    if (position.x < 2*size) velocity.x += velocity.x * -1;
    if (position.y < 2*size) velocity.y += velocity.y * -1;
    if (position.x > width - 2*size) velocity.x -= velocity.x ;
    if (position.y > height - 2*size) velocity.y -= velocity.y;
  }
}
  
}
