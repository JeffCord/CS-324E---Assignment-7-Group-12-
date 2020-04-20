class Player {
  PImage ship;
  PImage damagedShip;
  float x, y, xSpeed, ySpeed;
  boolean shooting = false;
  int laserRechargeTime = 20;
  int laserRecharge = 0;
  boolean damaged = false;

  Player() {
    ship = loadImage("Player.png");
    damagedShip = loadImage("Player_damaged.png");
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

    shootingBehavior();
  }

  void movement() {
    if (key == 'w' || key == 'W') {
      y -= ySpeed;
      y = constrain(y, ship.height / 2, height - (ship.height / 2));
    } else if (key == 's' || key == 'S') {
      y += ySpeed;
      y = constrain(y, ship.height / 2, height - (ship.height / 2));
    } else if (key == 'a' || key == 'A') {
      x -= xSpeed;
      x = constrain(x, ship.width / 2, ship.width * 2.5);
    } else if (key == 'd' || key == 'D') {
      x += xSpeed;
      x = constrain(x, ship.width / 2, ship.width * 2.5);
    }
  }


  void shootingBehavior() {
    if (!shooting) {
      if (mousePressed && mouseButton == LEFT) {
        // instantiate a new player laser at the player's current position
        PlayerLaser newLaser = new PlayerLaser(x, y);
        pLasers[laserIdx] = newLaser;
        shooting = true;
        laserSound.play();
      }
    } else {
      laserRecharge ++;
      if (laserRecharge >= laserRechargeTime) {
        laserRecharge = 0;
        shooting = false;
      }
    }
  }

  void display() {
    imageMode(CENTER);
    if (!damaged) {
      image(ship, x, y);
    } else if (damaged) {
      image(damagedShip, x, y);
    }
  }
}
