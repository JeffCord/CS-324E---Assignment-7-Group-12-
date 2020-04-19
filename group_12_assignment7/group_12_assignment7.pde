void setup() {
  size(800, 800);
  background(0);
  p1 = new Player();
}

boolean finished = false;
Player p1;
PlayerLaser [] pLasers = new PlayerLaser [3];
int laserIdx = 0;

void draw() {
  if (!finished) {
    background(0);

    displayPlayerLasers();

    p1.update();
    p1.display();
  }
}

void displayPlayerLasers() {
  for (int i = 0; i < pLasers.length; i++) {
    if (pLasers[i] != null) {
      pLasers[i].update();

      if (pLasers[i].x >= width + (pLasers[i].w / 2) ) {
        pLasers[i] = null;
      } else {
        pLasers[i].display();
      }
    }
  }
}
