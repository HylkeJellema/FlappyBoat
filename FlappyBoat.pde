// FlappyBoat by Hylke Jellema and Marc Harinck
// Sources and other information disclosed in README.md

MainEnviroment mainEnviroment;

void setup() {
    size(1400,800);
    mainEnviroment = new MainEnviroment();
}

void draw() {
    mainEnviroment.update(
        new PVector(mouseX,mouseY), //passes mouse cords
        new PVector(width,height)   //passes screen size
    );
    mainEnviroment.render();
}
