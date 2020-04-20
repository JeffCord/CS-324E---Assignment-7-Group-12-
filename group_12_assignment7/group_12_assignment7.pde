void setup() {
  size(1000, 800);
  background(0);
  p1 = new Player();
  laserSound = new SoundFile(this, "laser1.wav");
  laserSound.amp(0.1);
}

// audio
import processing.sound.*;
SoundFile laserSound;
boolean gameFinished = false;
Player p1;
PlayerLaser [] pLasers = new PlayerLaser [8];
int laserIdx = 0;

void draw() {
  if (!gameFinished) {
    background(0);

    displayPlayerLasers();

    p1.update();
    p1.display();
  } 
}

// draws any laser the player has recently shot
void displayPlayerLasers() {
  for (int i = 0; i < pLasers.length; i++) {
    PlayerLaser cur = pLasers[i];
    if (cur == null) {
      laserIdx = i;
      break;
    } else {
      cur.update();
      if (cur.x >= width + (cur.w / 2)) {
        cur = null;
        laserIdx = i;
      } else {
        cur.display();
      }
    }
  }
}
