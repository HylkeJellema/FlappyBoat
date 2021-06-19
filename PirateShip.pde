class PirateShip{
    
    PImage boat;
    MainEnviroment mainRef;
    MassSpringDamper MSD;
    int state = 1;
    float jumpVelocity=8;
    float minAngle = - 50;
    float maxAngle = 20;
    float gravity = 0.4;
    float xPos = 700;
    float size = 100;
    float waterHeight;
    float maxVelocity = -7;
    float velocity;
    float angle;

    PirateShip(float waterHeight){
        boat = loadImage("pirateShip.png");
        this.waterHeight = waterHeight;
        MSD = new MassSpringDamper();
    }

    void update(){
        if (xPos>waterHeight && (state==1) && !MSD.isActive() && velocity<1){
            state = 2;
            xPos-=1;
            MSD.setIncomingVelocity(velocity);
            MSD.setActive(true);
        }

        switch (state) {
            case 1 :
                if (velocity > -10){
                    velocity -= gravity;
                }
            break;	

            case 2 :
                MSD.calculate();
                velocity = MSD.getVelocity(); 
            break;	
        }
        if(velocity <= 0) {
            angle = velocity / jumpVelocity * minAngle;
        }else{
            angle = velocity / maxVelocity * maxAngle;
        }
        xPos-=velocity;  
    }

    void render(){
        pushMatrix();
        imageMode(CENTER);
        translate(width/4, xPos);
        rotate(radians(angle));
        image(boat, 0, 0, size,size);
        popMatrix();
    }

    void push(){
        velocity = jumpVelocity;
        state = 1;
        MSD.setActive(false);
    }
}
