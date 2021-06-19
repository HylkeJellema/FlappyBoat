class MassSpringDamper{

        float springConstant;
        float dampingConstant;
        float incomingVelocity;
        float followingTorque;
        boolean newEntry;
        boolean active = false;
        float mass;
        float velocity;
        float totalForce;
        float dt = 0.016;
        float position;
        
    MassSpringDamper() {
        springConstant = 15;
        dampingConstant = 0.5;
        incomingVelocity = 0;
        followingTorque = 0;
        newEntry = false;
        mass = 1; 
        position = 0;
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

    void setIncomingVelocity(float velocity){ //setting velocity and torque
        this.velocity = velocity;
    } 
    boolean isActive(){
        return active;
    }
    void setActive(boolean i){
        active = i;
    }
}
