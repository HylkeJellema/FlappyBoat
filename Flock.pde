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
      b.render();  
      fishingRod.render(mouse);
    }
  }

  void render(Boid b) {
    boids.add(b);
  }
  
}
