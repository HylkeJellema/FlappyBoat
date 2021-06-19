class Lines{

    float yoff;
    float location;

    Lines(float index) {
        location = index+1;
        yoff = index/100;
    }

    void display() {        
        float n = noise(yoff) * 200;
        yoff += 0.01;
        
        fill(30,180,30);
        rect(width - (location*10),height-n, 10, n);
    }
}
