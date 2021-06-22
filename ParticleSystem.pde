class ParticleSystem {

  ArrayList<Particle> particles;
  int counter;
  PVector location;
  int gameSpeed;

  ParticleSystem(int gameSpeed) {

    location = new PVector(0, 0); 
    particles = new ArrayList<Particle>();
    this.gameSpeed = gameSpeed;
  }

  void update(int state, PVector location) {

    this.location = location;

    particles.add(new Particle(location, state, gameSpeed));  //particles are spawned

    for (int i = particles.size()-1; i >= 0; i--) { //updates all particles
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) { //removes dead particles
        particles.remove(i);
      }
    }
  }

  void render() { //render all particles
    for (Particle p : particles) {
      p.render();
    }
  }
}
