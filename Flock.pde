class Flock {

  //arraylist of fish
  ArrayList<Fish> schoolOfFish;

  //constructor of the flock
  Flock() {
    schoolOfFish = new ArrayList<Fish>();
  }
  // method calling the flock
  void update(PVector mouse) {
    for (Fish swimmer : schoolOfFish) {
      swimmer.flock(schoolOfFish, mouse);
      swimmer.update();
      swimmer.render();
    }
  }
  void render() {
    for (Fish swimmer : schoolOfFish) {
      swimmer.render();
    }
  }

  void run(Fish f) {
    schoolOfFish.add(f);
  }
}
