int maxEnemies = 10;
int difficulty = 120;
int difficultyIncrease = 10;
int enemyIndex = 1;
int enemyHitBoxTightness = 3;
float enemySpeed = -2;
float enemySpeedIncrease = -.5;
int difficultyFrequency = 120;
int alienSize = 200;

int vulnerabiltyDuration = 90;
int vulnerabilityCounter = 0;

Enemy[] enemies = new Enemy[maxEnemies];
PImage[] aliens = new PImage[2];


int numFrames = 11;
PImage[]  explosion = new PImage[numFrames];

int timer_start;
int points = 0;
int life = 3;


// audio
import processing.sound.*;
SoundFile laserSound;

//game states
boolean gameFinished = false;
boolean playerLost = false;
boolean paused = false;
boolean pausePressable = true;

Player p1;
PlayerLaser [] pLasers = new PlayerLaser [8];
int laserIdx = 0;

int frameNum = 0;
int timeLimit = 3600;


void setup() {
  size(1000, 800);
  background(0);
  colorMode(HSB);
  timer_start = 0;


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
  if (playerLost) {
    background(#FF08B9);
    textAlign(CENTER);
    fill(0);
    text("Oh no! The aliens have destroyed your ship!\n\nGame Over", width/2, height/2);
  } else if (!gameFinished) {
    background(0);

    // temporary stop at 1 minute
    if (frameNum == timeLimit) {
      gameFinished = true;
    }

    // increases frequency of enemy spawn every 2 seconds
    if (frameNum % difficultyFrequency == 0) {
      enemySpeed += enemySpeedIncrease;
      if (difficulty > difficultyIncrease) {
        difficulty -= difficultyIncrease;
      }
    }

    // spawns an enemy in an enemy array
    if (frameNum % difficulty == 0 && enemyIndex < (maxEnemies-1)) {
      int index = int(random(aliens.length));
      enemies[enemyIndex] = new Enemy(width + 100, random(30, height - 100), alienSize, enemySpeed, aliens[index]);
      enemyIndex += 1;
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
              Explode_Timer gif = new Explode_Timer(0, 50, 0, enemies[i].location.x, enemies[i].location.y);
              gif.display(j);
              points += 1; //win a point 
              enemies[i].location.x = width + 100;
              enemies[i].location.y = random(30, height - 100);
              pLasers[j] = null;
            }
          }
        }
        if (enemies[i].location.x < -50) {
          enemies[i].location.x = width + 100;
          enemies[i].location.y = random(30, height - 100);
        }
        if (!p1.shieldOn) {
          if (dist(enemies[i].location.x, enemies[i].location.y, p1.x, p1.y) <= enemies[i].radius/enemyHitBoxTightness && !p1.damaged) {
            life -= 1;
            p1.damaged = true;
            if (life == 0) {
              playerLost = true;
            }
          }
        }
      }
    }

    if (p1.damaged == true) {      
      vulnerabilityCounter += 1;
      if (vulnerabilityCounter == vulnerabiltyDuration) {
        p1.damaged = false;
        vulnerabilityCounter = 0;
      }
    } 

    if (!paused) {
      frameNum ++;
    }

    displayPlayerLasers();

    p1.update();
    p1.display();

    timer_draw();
    point_draw();
    life_draw();
  } else if (gameFinished) {
    background(#FFBE08);
    textAlign(CENTER);
    fill(0);
    text("You win!\nYour score was " + points + "!", width/2, height/2);
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


//diaplay playing time
void timer_draw() {
  fill(100, 255, 255);
  textSize(40);
  text(frameNum / 60, 20, 40 );
}

//display points
void point_draw() {
  fill(255, 255, 255);
  textSize(40);
  text("Point:" + points, 400, 40);
}

//display # of lives
void life_draw() {
  fill(100, 255, 255);
  textSize(40);
  text("Life:" + life, 850, 40);
}

void keyPressed() {
  final int k = keyCode;

  //press space to pause the game
  if (k == ' ' && pausePressable) {
    paused = !paused;
    pausePressable = false;
  }

  if (paused) {
    noLoop();
  } else {
    loop();
  }
}

void keyReleased() {
  pausePressable = true;
}
