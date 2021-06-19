class GameEnviroment{
   
    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;
    color background;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip();
        background = color
    }
  
    


    void update(PVector mouse){
        ship.update();
    }

    void render(){
      
    }
}
