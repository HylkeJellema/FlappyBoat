class GameWater{

    float yoff;
    float location;
    float waterLineHeight;

    GameWater(float index) {
        location = index+1;
        yoff = index/100;
    }

    void update() {        
        float waterLineHeight = noise(yoff) * 200;
        yoff += 0.01;
    }
    void render() {        

        fill(30,180,30);
        rect(width - (location*10),height-waterLineHeight, 10, waterLineHeight);
    }
}
