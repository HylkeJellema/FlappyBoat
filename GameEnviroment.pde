class GameEnviroment{
    
    MainEnviroment mainRef;
    PirateShip ship;
    GameWater water;

    GameEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        ship = new PirateShip();
    }


    void update(PVector mouse){
        ship.update();
    }

    void render(){
        background(100, 100, 200);
        imageMode(CENTER);
        ship.render();
 
    }
}
