class PirateShip{
    
    PImage boat;
    MainEnviroment mainRef;

    PirateShip(){
        boat = loadImage("pirateShip.png");
    }


    void update(){
 
    }

    void render(){
       
        imageMode(CENTER);
        image(boat, width/2, height/2,  300,414);
 
    }
}
