// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md

import processing.video.*;
MainEnviroment mainEnviroment;


void setup() {
    size(1400,800);
    mainEnviroment = new MainEnviroment(this);
}

void draw() {
    mainEnviroment.update(new PVector(mouseX,mouseY)); //passes mouse cords
      
}

void movieEvent(Movie m) {
    m.read();
}
