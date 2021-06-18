class Flock{
  Obstruction fishingRod;
    ArrayList<Boid> boids;

  Flock() {
    fishingRod = new Obstruction();
    boids = new ArrayList<Boid>(); 
  }

  void run(PVector mouse) {
    for (Boid b : boids) {
      b.run(boids);  
      fishingRod.render(mouse);
    }
  }

  void addBoid(Boid b) {
    boids.add(b);
  }
  
}
