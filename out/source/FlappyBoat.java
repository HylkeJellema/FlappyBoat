import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FlappyBoat extends PApplet {

// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md


MainEnviroment mainEnviroment;


public void setup() {
  
  mainEnviroment = new MainEnviroment(this);
}

public void draw() {
  mainEnviroment.update(new PVector(mouseX, mouseY)); //passes mouse cords
}

public void movieEvent(Movie m) {
  m.read();
}

public void mousePressed() {
  mainEnviroment.mousePressedEvent();
}
class Fish {

  PVector position, velocity, acceleration;
  PVector seperation, alignment, cohesion, avoidance;

  float seperationWeight, alignmentWeight, cehesionWeight, avoidanceWeight;
  float diameter, maxVelocity, maxForce;



  Fish(PVector position) {
    setPosition(position);
    velocity     = new PVector(random(-2, 2), random(-2, 2));
    acceleration = new PVector(0, 0);

    seperation   = new PVector(0, 0);
    alignment    = new PVector(0, 0);
    cohesion     = new PVector(0, 0);
    avoidance    = new PVector(0, 0);
    diameter     = 10.0f;
    maxVelocity  = 3.0f;
    maxForce     = 0.1f;
  }

  public void run(ArrayList<Fish> schoolOfFish, PVector mouse) {
    flock(schoolOfFish, mouse);
    update();
    render();
  }
  public void flock(ArrayList<Fish> schoolOfFish, PVector mouse) {

    PVector avoidance = avoidance(mouse); 
    PVector seperation = seperate(schoolOfFish);
    PVector alignment = alignment(schoolOfFish);
    PVector cohesion = cohesion(schoolOfFish);

    // Arbitrarily weight these forces
    seperation.mult(3.0f);
    alignment.mult(1.0f);
    cohesion.mult(1.0f);
    avoidance.mult(2.0f);
    // Add the force vectors to acceleration
    applyForce(alignment);
    applyForce(alignment);
    applyForce(cohesion);
    applyForce(avoidance);
  }

  public PVector avoidance (PVector mouse) {
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


  public void update() {
    velocity.limit(maxVelocity);
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
  }


  public void render() {
    pushMatrix();
    translate(position.x, position.y);
    fill(52, 161, 208);
    ellipse(0, 0, diameter, diameter + 5); 
    triangle(0, -diameter/2, -diameter/2, -diameter, diameter/2, -diameter);
    popMatrix();
  }





  public void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
  public PVector seek(PVector target) {
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
  public PVector seperate (ArrayList<Fish> schoolOfFish) {
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
  public PVector alignment (ArrayList<Fish> schoolOfFish) {
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
  public PVector cohesion (ArrayList<Fish> schoolOfFish) {
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


  public void setPosition(PVector position) {
    this.position = position;
  }
  public PVector getPosition() {
    return position;
  }
}
class Flock {
  Fish swimmer;

  ArrayList<Fish> schoolOfFish;


  Flock() {
    schoolOfFish = new ArrayList<Fish>();
  }

  public void update(PVector mouse) {
    for (Fish swimmer : schoolOfFish) {
      swimmer.flock(schoolOfFish, mouse);
      swimmer.update();
      swimmer.render();
    }
  }

  public void run(Fish f) {
    schoolOfFish.add(f);
  }
}
class GameEnviroment {

    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;
    MoneySpawner monies;
    int skyColor = color(135, 206, 235);
    float waterHeight = 650;
    int gameSpeed =5;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip(waterHeight,gameSpeed);
        water = new GameWater(gameSpeed);
        monies = new MoneySpawner(gameSpeed);
    }


  public void update() {
        ship.update();
        monies.update();
  }

  public void render() {
        background(skyColor);      
        water.render(waterHeight);
        ship.render();
        monies.render();
        
  }

  public void mousePressedEvent() {
        ship.push();
  }
}
class GameOverEnviroment {
  PImage gameOverImage;

  MainEnviroment mainRef;
  Movie backgroundWater;

  GameOverEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;

    backgroundWater = new Movie(mainRef.getApp(), "water_SparkVideo.mp4");
    backgroundWater.play();
    gameOverImage = loadImage("Gamedone.png");
  }

  public void update(PVector mouse) {
  }

  public void render() {     
    image(backgroundWater, 0, 0);
    gameOverImage.get();    
   image(gameOverImage, 0, 0);
  }
}
class GameWater {
  GameEnviroment game;
  GameWater wetness;
  float incline, start;
  int waterColor = color(17,	136,	234);
  int gameSpeed;

  GameWater(int gameSpeed) {
    incline = 0.01f;
    start = 0;
    this.gameSpeed = gameSpeed;
  }

  public void render(float waterHeight) {
    fill(waterColor);
    beginShape();
    float yOff = start;
    vertex(0, height);
    for (float i = 0; i < width; i+=gameSpeed) {
      float y = noise(yOff) *50 +waterHeight;
      yOff += incline;
      vertex(i, y);
    }
    vertex(width, height);
    endShape();
    start += incline;
  }
}
class MainEnviroment {

  int state; //shows state of game 
  final int MENU_PAGE = 1; //stages
  final int GAME_PAGE = 2; 
  final int SCORE_PAGE = 3; 
  final int GAMEOVER_PAGE = 4;
  MenuEnviroment menu;
  GameEnviroment game;
  GameOverEnviroment gameOver;
  PApplet app;

  MainEnviroment(PApplet app) {
    this.app=app;
    state = MENU_PAGE;
    menu = new MenuEnviroment(this); //passing main screen as object to states can be changed.
    game = new GameEnviroment(this);
    gameOver = new GameOverEnviroment(this);
  }

  public void update(PVector mouse) {

    switch (state) { //all states and there methods

    case MENU_PAGE:
      menu.update(mouse);
      menu.render(mouse);
      break;

    case GAME_PAGE:
      game.update();
      game.render();
      break;

    case GAMEOVER_PAGE:
      gameOver.update(mouse);
      gameOver.render();
      break;
      
      
    }
  }

  public void setState(int i) { //to set a stage
    state = i;
  }

  public PApplet getApp() { //receive main class as object method
    return app;
  }

  public void mousePressedEvent() {
    switch (state) { //pass mosue event

    case MENU_PAGE:
      menu.mousePressedEvent();
      break;

    case GAME_PAGE:
      game.mousePressedEvent();
      break;
    }
  }
}
class MassSpringDamper{

        float springConstant;
        float dampingConstant;
        boolean active = false;
        float mass;
        float velocity;
        float dt;
        float position;
        
    MassSpringDamper() {
        springConstant = 100;
        dampingConstant = 5;
        mass = 2; 
        dt= 1/frameRate;
    }
    
    public void calculate() { //MSD mathphysics
        float spring_force = springConstant * position; 
        float damper_force = dampingConstant * velocity;
        float acceleration = - (spring_force + damper_force) / mass;
        velocity += (acceleration * dt);
        position += (velocity * dt); 

    }

    public float getVelocity() {
        return velocity;
    }

    public void setIncomingVelocity(float velocity){ //setting velocity
        this.velocity = velocity;
    } 
    public boolean isActive(){
        return active;
    }
    public void setActive(boolean i){
        active = i;
    }
}
class MenuEnviroment {

  PVector buttonPos, InitialPos;
  int buttonSize; // size of the start button 
  int buttonColor, hoverColor; // Colors going with the button
  boolean hoverOver; // boolean activating the next phase of the game
  PImage CoverImage;


  Flock group;
  MainEnviroment mainRef;
  Movie backgroundWater;

  MenuEnviroment(MainEnviroment mainRef) {
    this.mainRef = mainRef;
    //Video related
    backgroundWater = new Movie(mainRef.getApp(), "water.mp4");
    backgroundWater.loop();

    //Button related 
    buttonPos = new PVector(width/2, height * 3/4);
    buttonSize = 100;
    buttonColor = color(32, 160, 232);
    hoverColor = color(52, 86, 105);
    hoverOver = false;

    //Flocking related
    CoverImage = loadImage("Coverimage.png");
    group = new Flock();
    for (int i = 0; i < 150; i++) {
      Fish f = new Fish(new PVector(random(width), random(height)));
      group.run(f);
    }
  }


  public void update(PVector mouse) {
    //  obstruction.render(mouse);
    if (dist(mouse.x, mouse.y, buttonPos.x, buttonPos.y) < buttonSize/2) {
      hoverOver = true;
    } else {
      hoverOver = false;
    }
  }

  public void mousePressedEvent() {
    if (hoverOver) {
      mainRef.setState(2);
    }
  }

  public void render(PVector mouse) {

    image(backgroundWater, 0, 0, width, height );// drawing video and resizing it
    group.update(mouse);
    image(CoverImage, 0, 0);


    if (hoverOver) {
      fill(hoverColor);
    } else {
      fill(buttonColor);
    }
    circle(buttonPos.x, buttonPos.y, buttonSize);
    fill(0);
    textSize(12);
    text("Press to start", buttonPos.x-40, buttonPos.y);
  }
}
class Money {
    PVector location, velocity;
  
  
    Money() {
        location = new PVector(width+30, random(100, height-100));
    }
  
    public void update() {
        
    }
  
    public void render() {

    }
}
class MoneySpawner {
    int gameSpeed;

  
  
    MoneySpawner(int gameSpeed) {
        this.gameSpeed = gameSpeed;

    }
  
    public void update() {
        
    }
  
    public void render() {

    }
}
class Particle{

    int life,state;
    PVector location,velocity, gameSpeed;
    
    Particle(PVector origin, int state, int gameSpeed) {
        this.gameSpeed = new PVector(gameSpeed*(-1),0);
        life = 255; //gives particle a lifetime which is later used in the alpha channel of the circle render.
        location = origin;
        velocity = PVector.random2D(); //give random direction with scaler 1 then multiply with random scalar.
        velocity.mult(random(2));
        this.state=state;
 
    }
    
    public void update() { //adds velocity to location
        life--;
        location.add(velocity);
        location.add(gameSpeed);
    }
    
    public void render() { //renders the particle
        if (state==1){
            fill(255, 255, 0, life);
            star(location.x,location.y,5,15,5);   
        }
        if (state==2){
            fill(0, 0, 255, life);
            circle(location.x,location.y,5);   
        }
    }
    
    public boolean isDead(){ //return if dead
        if (life>0){
            return false;
        } else {
            return true;
        }
    }
    public void star(float x, float y, float radius1, float radius2, int npoints) { //stolen from processing website because stars are cooler then circles
        float angle = TWO_PI / npoints;
        float halfAngle = angle/2.0f;
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
class ParticleSystem{

    ArrayList<Particle> particles;
    int counter;
    PVector location;
    int gameSpeed;

    ParticleSystem(int gameSpeed){

        location = new PVector(0,0); 
        particles = new ArrayList<Particle>();
        this.gameSpeed = gameSpeed;

    }
    
    public void update(int state, PVector location) {
        
        this.location = location;

        particles.add(new Particle(location,state,gameSpeed));  //particles are spawned
        

        for (int i = particles.size()-1; i >= 0; i--) { //updates all particles
            Particle p = particles.get(i);
            p.update();
            if (p.isDead()) { //removes dead particles
                particles.remove(i);
            }
        }
    }
    
    public void render() { //render all particles
        for (Particle p : particles) {
            p.render();
        }
    }
}
class PirateShip{
    
    PImage boat;
    MassSpringDamper mSD;
    ParticleSystem stars;
    int state = 2;
    float jumpVelocity=8;
    float minAngle = - 50;
    float maxAngle = 20;
    float gravity = 0.4f;
    float xPos;
    float yPos = 700;
    float size = 100;
    float waterHeight;
    float maxVelocity = -7;
    float velocity;
    float angle;

    PirateShip(float waterHeight, int gameSpeed){
        xPos=width/4;
        boat = loadImage("pirateShip.png");
        this.waterHeight = waterHeight;
        mSD = new MassSpringDamper();
        stars = new ParticleSystem(gameSpeed);
    }

    public void update(){
        stars.update(state, new PVector(xPos, yPos));

        if (yPos>waterHeight && state==1 && !mSD.isActive() && velocity<1){
            state = 2;
            yPos-=1;
            mSD.setIncomingVelocity(velocity);
            mSD.setActive(true);
        }

        switch (state) {
            case 1 :
                if (velocity > -10){
                    velocity -= gravity;
                }
            break;	

            case 2 :
                mSD.calculate();
                velocity = mSD.getVelocity(); 
            break;	
        }
        if(velocity <= 0) {
            angle = velocity / jumpVelocity * minAngle;
        }else{
            angle = velocity / maxVelocity * maxAngle;
        }
        yPos-=velocity;  
    }

    public void render(){
        stars.render();
        
        pushMatrix();
        imageMode(CENTER);
        translate(xPos, yPos);
        rotate(radians(angle));
        image(boat, 0, 0, size,size);
        popMatrix();
    }

    public void push(){
        velocity = jumpVelocity;
        state = 1;
        mSD.setActive(false);
    }
}
  public void settings() {  size(1400, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FlappyBoat" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
