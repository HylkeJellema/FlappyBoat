// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md

import processing.video.*;
MainEnviroment mainEnviroment;
Flock flock;

void setup() {
    size(1400,800);
    mainEnviroment = new MainEnviroment(this);
    flock = new Flock();
     for(int i = 0; i < 150; i++){
      Boid b = new Boid(random(width), random(height));
      flock.addBoid(b);
    }

}

void draw() {
    mainEnviroment.update(
        new PVector(mouseX,mouseY), //passes mouse cords
        new PVector(width,height)   //passes screen size
    );
   flock.run();
    
}

void movieEvent(Movie m) {
    m.read();
}
