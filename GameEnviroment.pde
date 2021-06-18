class GameEnviroment{
     PImage img;

    MainEnviroment mainRef;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
          img = loadImage("Optimist.png");
    }


    void update(PVector mouse, PVector screenSize){
 
    }

    void render(){
       
       imageMode(CENTER);
   
     image(img, width/2, height/2,  300,414);
 
    }
}
