int maxEnemies = 10;
int difficulty = 120;
int difficultyIncrease = 10;
int enemyIndex = 1;
int enemyHitBoxTightness = 3;
float enemySpeed = -2;
float enemySpeedIncrease = -.5;
int difficultyFrequency = 120;
int alienSize = 200;

Enemy[] enemies = new Enemy[maxEnemies];
PImage[] aliens = new PImage[2];


int numFrames = 11;
PImage[]  explosion = new PImage[numFrames];

// audio
import processing.sound.*;
SoundFile laserSound;
boolean gameFinished = false;
Player p1;
PlayerLaser [] pLasers = new PlayerLaser [8];
int laserIdx = 0;


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

  enemies[0] = new Enemy(width + 100, height/2, alienSize, enemySpeed, aliens[0]);

  p1 = new Player();
  laserSound = new SoundFile(this, "laser1.wav");
  laserSound.amp(0.1);
}

void draw() {
  background(0);
  
  
  // temporary stop at 1 minute
  if (frameCount == 3600) {
   exit(); 
  }
  
  // increases frequency of enemy spawn every 2 seconds
  if (frameCount % difficultyFrequency == 0) {
    enemySpeed += enemySpeedIncrease;
    if (difficulty > difficultyIncrease) {
    difficulty -= difficultyIncrease;
    }
  }
  
  // spawns an enemy in an enemy array
  if (frameCount % difficulty == 0 && enemyIndex < (maxEnemies-1)) {
    int index = int(random(aliens.length));
    enemies[enemyIndex] = new Enemy(width + 100,random(30,height - 100),alienSize,enemySpeed,aliens[index]); {
    enemyIndex += 1;
    }
  }
  
  // checks enemy array for enemies in bounds and displays
  // reuses enemies if they are off screen to save memory
  for (int i = 0; i < enemies.length; i++) {
    if (enemies[i] != null) {
      enemies[i].display();
      enemies[i].speedUpdate(enemySpeed);
      for (int j = 0; j < pLasers.length; j++) {
        if (pLasers[j] != null) {
          if (dist(enemies[i].location.x, enemies[i].location.y, pLasers[j].x, pLasers[j].y) <= enemies[i].radius/enemyHitBoxTightness) {
           Explode_Timer gif = new Explode_Timer(0,50,0,enemies[i].location.x,enemies[i].location.y);
           gif.display(j);
           enemies[i].location.x = width + 100;
           enemies[i].location.y = random(30,height - 100);
           pLasers[j] = null;
         }
        }
      }
      if (enemies[i].location.x < -50) {
        enemies[i].location.x = width + 100;
        enemies[i].location.y = random(30,height - 100);
      }
      if (dist(enemies[i].location.x, enemies[i].location.y, p1.x, p1.y) <= enemies[i].radius/enemyHitBoxTightness) {
        exit();
      }
    }
  }

    displayPlayerLasers();

    p1.update();
    p1.display();
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
