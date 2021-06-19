class PirateShip{
    
    PImage boat;
    MainEnviroment mainRef;
    MassSpringDamper MSD;
    int state = 1;
    float jumpVelocity=8;
    float minAngle = - 80;
    float maxAngle = 20;
    float gravity = 0.4;
    float velocity = 0;
    float angle = 0;
    float xPos = 700;
    float size = 100;
    float waterHeight;

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
                velocity -= gravity;
            break;	

            case 2 :
                MSD.calculate();
                velocity = MSD.getVelocity(); 
                println(MSD.getVelocity());
            break;	
        }

        xPos-=velocity;  
    }

    void render(){
        pushMatrix();
        imageMode(CENTER);
        rotate(angle);
        image(boat, width/4, xPos, size,size);
        popMatrix();
    }

    void push(){
        velocity = jumpVelocity;
        state = 1;
        MSD.setActive(false);
    }
}
