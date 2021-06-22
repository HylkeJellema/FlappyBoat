class Fish {
  // variables for the fish 
  PVector position, velocity, acceleration;
  //variables for the flocking(interaction between fish)
  PVector seperation, alignment, cohesion, avoidance;
  // the intensity of the flocking(interaction between fish)
  float seperationWeight, alignmentWeight, cehesionWeight, avoidanceWeight;
  //limits set for the fish
  float diameter, maxVelocity, maxForce;

  //constructor of the fish 
  Fish(PVector position) {
    setPosition(position); // method created to get position 
    velocity     = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    seperation   = new PVector(0, 0);
    alignment    = new PVector(0, 0);
    cohesion     = new PVector(0, 0);
    avoidance    = new PVector(0, 0);
    diameter     = 10.0;
    maxVelocity  = 1.0;
    maxForce     = 0.1;
  }
  // method running the fish's appeal, brains, and behaviour with other fish
  void run(ArrayList<Fish> schoolOfFish, PVector mouse) {
    flock(schoolOfFish, mouse);
    update();
    render();
  }

  // method running the interactiuon between fish
  void flock(ArrayList<Fish> schoolOfFish, PVector mouse) {

    PVector avoidance = avoidance(mouse); 
    PVector seperation = seperate(schoolOfFish);
    PVector alignment = alignment(schoolOfFish);
    PVector cohesion = cohesion(schoolOfFish);

    // Arbitrarily weight these forces
    seperation.mult(1.0);
    alignment.mult(1.0);
    cohesion.mult(1.0);
    avoidance.mult(2.0);
    // Add the force vectors to acceleration
    applyForce(alignment);
    applyForce(alignment);
    applyForce(cohesion);
    applyForce(avoidance);
  }

  PVector avoidance (PVector mouse) {
    float desiredAvoidance = 75.0f;
    PVector steer = new PVector(0, 0);

    // For every boid in the system, check if it's too close

    float distance = PVector.dist(position, mouse);
    // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
    if  (distance < desiredAvoidance) {
      // Calculate vector pointing away from neighbor
      PVector diff = PVector.sub(position, mouse);
      diff.normalize();
      diff.div(distance);        // Weight by distance
      steer.add(diff);
    }



    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxVelocity);
      steer.sub(velocity);
      steer.limit(maxForce);
    }
    return steer;
  }

  //the fish's behaviour 
  void update() {
    velocity.limit(maxVelocity);
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }

  // the fish's appearance 
  void render() {
    pushMatrix();
    translate(position.x, position.y);
    fill(52, 161, 208);
    ellipse(0, 0, diameter, diameter + 5); 
    triangle(0, -diameter/2, -diameter/2, -diameter, diameter/2, -diameter);
    popMatrix();
  }




  //method allowing the fish's velocity to change
  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target, position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxVelocity);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxForce);  // Limit to maximum steering force
    return steer;
  }

  // Separation
  // Method checks for nearby schoolOfFish and steers away
  PVector seperate (ArrayList<Fish> schoolOfFish) {
    float desiredseparation = 25.0f;
    PVector steer = new PVector(0, 0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Fish other : schoolOfFish) {
      float distance = PVector.dist(position, other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((distance > 0) && (distance < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position, other.position);
        diff.normalize();
        diff.div(distance);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.setMag(maxVelocity);
      steer.sub(velocity);
      steer.limit(maxForce);
    }
    return steer;
  }

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
  PVector alignment (ArrayList<Fish> schoolOfFish) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);
    int count = 0;
    for (Fish other : schoolOfFish) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxVelocity);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxForce);
      return steer;
    } else {
      return new PVector(0, 0);
    }
  }

  // Cohesion
  // For the average position (i.e. center) of all nearby schoolOfFish, calculate steering vector towards that position
  PVector cohesion (ArrayList<Fish> schoolOfFish) {
    float neighbordist = 50;
    PVector sum = new PVector(0, 0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Fish other : schoolOfFish) {
      float d = PVector.dist(position, other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0, 0);
    }
  }

  //position methods  
  void setPosition(PVector position) {
    this.position = position;
    //local position within the object^
  }
  PVector getPosition() {
    return position;
  }
}
