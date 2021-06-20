class MassSpringDamper{

        float springConstant;
        float dampingConstant;
        boolean active = false;
        float mass;
        float velocity;
        float dt;
        float position;
        
    MassSpringDamper() {
        springConstant = 100;
        dampingConstant = 5;
        mass = 2; 
        dt= 1/frameRate;
    }
    
    void calculate() { //MSD mathphysics
        float spring_force = springConstant * position; 
        float damper_force = dampingConstant * velocity;
        float acceleration = - (spring_force + damper_force) / mass;
        velocity += (acceleration * dt);
        position += (velocity * dt); 

    }

    float getVelocity() {
        return velocity;
    }

    void setIncomingVelocity(float velocity){ //setting velocity
        this.velocity = velocity;
    } 
    boolean isActive(){
        return active;
    }
    void setActive(boolean i){
        active = i;
    }
    void reset(){
        velocity = 0;
        position = 0;
    }
}
