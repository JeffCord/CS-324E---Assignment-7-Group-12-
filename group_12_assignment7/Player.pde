class Player {
  PImage ship;
  PImage damagedShip1;
  PImage damagedShip2;
  float x, y, xSpeed, ySpeed;
  boolean blinkOn = false;

  boolean shooting = false;
  int laserRechargeTime = 20;
  int laserRecharge = 0;

  boolean damaged = false;
  boolean shieldOn = false;
  boolean shieldEmpty = false;
  int shieldHoldTime = 0; // how long the shield has been held
  int shieldHoldLimit = 120; // how long a shield can be on

  int shieldRecharge = 0; // how long the shield has been recharging
  int shieldCooldown = 120; // how many frames it takes to recharge 
  float maxAlpha = 150;
  float shieldAlpha = maxAlpha;

  Player() {
    ship = loadImage("Player.png");
    damagedShip1 = loadImage("Player_damaged_1.png");
    damagedShip2 = loadImage("Player_damaged_2.png");
    x = width * 0.08;
    y = height/2;
    xSpeed = 5;
    ySpeed = 5;
  }

  void update() {
    imageMode(CENTER);
    if (keyPressed) {
      movement();
    }

    if (!shieldOn) {
      shieldRecharge = constrain(shieldRecharge + 1, 0, 120);
      shieldHoldTime = constrain(shieldHoldTime - 1, 0, 120);
    } else {
      shieldRecharge = constrain(shieldRecharge - 1, 0, 120);
    }

    if (shieldEmpty) {
      if (shieldRecharge >= shieldCooldown) {
        shieldAlpha = 150;
        shieldEmpty = false;
        shieldRecharge = 0;
        shieldHoldTime = 0;
      }
    }

    if (!mousePressed) {
      shieldOn = false;
    } else {
      shieldBehavior();

      if (mouseButton == LEFT) {
        shootingBehavior();
        shieldOn = false;
      }
    }
    //println(shieldAlpha);
    //println(shieldHoldTime, shieldRecharge);
  }

  void movement() {
    if (key == 'w' || key == 'W') {
      y = constrain(y - ySpeed, ship.height / 2, height - (ship.height / 2));
    } else if (key == 's' || key == 'S') {
      y = constrain(y + ySpeed, ship.height / 2, height - (ship.height / 2));
    }
  }

  void shootingBehavior() {
    if (!shooting) {
      if (mousePressed) {
        if (mouseButton == LEFT) {
          // instantiate a new player laser at the player's current position
          pLasers[laserIdx] = new PlayerLaser(x, y);
          shooting = true;
          laserSound.play();
        }
      }
    } else {
      laserRecharge ++;
      if (laserRecharge >= laserRechargeTime) {
        laserRecharge = 0;
        shooting = false;
      }
    }
  }

  void shieldBehavior() {
    if (mouseButton == RIGHT) {
      if (!shieldEmpty) {
        shieldHoldTime ++;
        if (shieldHoldTime >= shieldHoldLimit) {
          shieldOn = false;
          shieldEmpty = true;
          shieldHoldTime = 0;
        } else {
          shieldOn = true;
          fill(#FF4093, shieldAlpha);
          noStroke();
          circle(x - 8, y, 145);
          shieldAlpha = maxAlpha * ((1.0 * shieldHoldLimit - shieldHoldTime) / shieldHoldLimit);
        }
      }
    }
  }

  void display() {
    imageMode(CENTER);
    if (!damaged) {
      image(ship, x, y);
    } else {
      if (frameNum % 15 == 0) {
        blinkOn = !blinkOn;
      }
      
      if (blinkOn) {
        image(damagedShip1, x, y);
      } else {
        image(damagedShip2, x, y);
      }
    }
  }
}
