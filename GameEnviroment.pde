class GameEnviroment{
    
    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip();
    }


    void update(PVector mouse, PVector screenSize){
        ship.update();
    }

    void render(){
       
        imageMode(CENTER);
        ship.render();
 
    }
}
