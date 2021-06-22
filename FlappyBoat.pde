// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md

import processing.video.*;
MainEnviroment mainEnviroment;


void setup() {
  size(1400, 800); //sets screen size
  mainEnviroment = new MainEnviroment(this); //makes the main enviroment
}

void draw() {
  mainEnviroment.update(new PVector(mouseX, mouseY)); //passes mouse cords to main
}

void movieEvent(Movie m) { //for the video player
  m.read();
}

void mousePressed() { //mouse press pass along to main
  mainEnviroment.mousePressedEvent();
}
