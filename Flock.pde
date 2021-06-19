class Flock {
  Fish swimmer;

  ArrayList<Fish> schoolOfFish;


  Flock() {
    schoolOfFish = new ArrayList<Fish>();
  }

  void update(PVector mouse) {
    for (Fish swimmer : schoolOfFish) {
      swimmer.flock(schoolOfFish, mouse);
      swimmer.update();
      swimmer.render();
    }
  }

  void run(Fish f) {
    schoolOfFish.add(f);
  }
}
