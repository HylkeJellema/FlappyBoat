class GameEnviroment{
     

    MainEnviroment mainRef;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
    }


    void update(PVector mouse, PVector screenSize){
 
    }

    void render(){
       PImage img;
       imageMode(CENTER);
     img = loadImage("Optimist.png");
     image(img, width/2, height/2,  300,414);
 
    }
}
