class MenuEnviroment{

    MainEnviroment mainRef;
    Movie backgroundWater;

    MenuEnviroment(MainEnviroment mainRef){
        this.mainRef = mainRef;
        backgroundWater = new Movie(this, "water.mp4");
        backgroundWater.loop();
    }

    void update(PVector mouse, PVector screenSize){
        
    }

    void render(){
        image(backgroundWater,0,0);
    }

    void movieEvent(Movie m) {
        m.read();
    }
}