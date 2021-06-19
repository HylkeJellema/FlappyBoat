class MassSpringDamper{

        float torque;
        float angularVelocity;
        float totalRotation;
        float springConstant;
        float dampingConstant;
        float incomingVelocity;
        float followingTorque;
        boolean newEntry;
        
    MassSpringDamper() {
        torque = 0;
        angularVelocity = 0;
        totalRotation = 0;
        springConstant = 100;
        dampingConstant = 0.1;
        incomingVelocity = 0;
        followingTorque = 0;
        newEntry = false;
    }
    
    void calculate() { //MSD mathphysics
        float usedVelocity = angularVelocity - incomingVelocity;
        float friction = usedVelocity * dampingConstant;
        torque = (1 / springConstant * totalRotation + friction);
        totalRotation += usedVelocity;
        angularVelocity += followingTorque - torque;

    }

    float finalVelocity(){ //used to get the angular velocity
        return angularVelocity;
    }

    void setIncomingVelocity(float torque){ //setting velocity and torque
        followingTorque += torque;
    } 
    
}
