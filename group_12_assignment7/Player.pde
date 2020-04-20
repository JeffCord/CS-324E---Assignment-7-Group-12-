class Player {
  PImage ship;
  float x, y, xSpeed, ySpeed;
  boolean shooting = false;
  int cooldownTime = 10;
  int cooldown = 0;

  Player() {
    ship = loadImage("Player.png");
    x = width * 0.08;
    y = height/2;
    xSpeed = 5;
    ySpeed = 5;
  }

  void update() {
    if (keyPressed) {
      movement();
    }

    if (mousePressed) {
      shootingBehavior();
    }
  }

  void movement() {
    if (key == 'w' || key == 'W') {
      y -= ySpeed;
      y = constrain(y, ship.height / 2, height - (ship.height / 2));
    } else if (key == 's' || key == 'S') {
      y += ySpeed;
      y = constrain(y, ship.height / 2, height - (ship.height / 2));
    }
  }

  void shootingBehavior() {
    if (!shooting) {
      // instantiate a new player laser at the player's current position
      PlayerLaser newLaser = new PlayerLaser(x, y);
      pLasers[laserIdx] = newLaser;
      shooting = true;
      laserSound.play();
    } else {
      cooldown ++;
      if (cooldown >= cooldownTime) {
        cooldown = 0;
        shooting = false;
      }
    }
  }

  void display() {
    imageMode(CENTER);
    image(ship, x, y);
  }
  
}
