Enemy[] enemies = new Enemy[100];
PImage[] aliens = new PImage[2];
int numFrames = 11;
PImage[]  explosion = new PImage[numFrames];
//Explode_Timer explode_gif = new Explode_Timer(0,0,200,-2,0,50,0);
int difficulty = 120;
int difficulty_increase = 10;
int enemy_index = 1;
int enemy_speed = -2;


void setup() {
  size(1000, 800);
  background(0);
  colorMode(HSB);

  // future explosion sprite array
  for (int i = 0; i < explosion.length; i++) {
    String imageName = "explode-" + nf(i+1, 2) + ".png";
    explosion[i] = loadImage(imageName);
  } 

  // alien image array
  for (int i = 0; i < aliens.length; i++) {
    String imageName = "Alien_Enemy_" + nf(i+1, 2) + ".png";
    aliens[i] = loadImage(imageName);
  }

  enemies[0] = new Enemy(900, random(30, 700), 200, enemy_speed, aliens[0]);

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

    // temporary stop at 30 seconds
    if (frameCount == 1800) {
      exit();
    }

    // increases frequency of enemy spawn every 2 seconds
    if (frameCount % 120 == 0 && difficulty > 10) {
      difficulty -= difficulty_increase;
    }

    // spawns an enemy in an enemy array
    if (frameCount % difficulty == 0) {
      int index = int(random(aliens.length));
      enemies[enemy_index] = new Enemy(900, random(30, 700), 200, enemy_speed, aliens[index]);
      enemy_index += 1;
    }

    // checks enemy array for enemies in bounds and displays
    // deletes enemies if they are off screen to save memory
    for (int i = 0; i < enemies.length; i++) {
      if (enemies[i] != null) {
        enemies[i].display();
        if (enemies[i].location.x < -50) {
          enemies[i] = null;
        }
      }
    } 

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
  //>>>>>>> master
}
