class Flock{
  Flock herd;
  Obstruction fishingRod;
    ArrayList<Boid> boids;

  Flock() {
    fishingRod = new  Obstruction();
    boids = new ArrayList<Boid>(); 
  }

  void update(PVector mouse) {
    for (Boid b : boids) {
      b.addBoid(boids);  
      fishingRod.render(mouse);
    }
  }

  void render(Boid b) {
    boids.add(b);
  }
  
}
