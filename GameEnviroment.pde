class GameEnviroment{
   
    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
    
    }
  
    


    void update(PVector mouse){
        ship.update();
    }

    void render(){
      
    }
}
