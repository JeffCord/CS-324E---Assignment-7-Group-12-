class Player {
  PImage ship;
  float x, y, xSpeed, ySpeed;
  boolean shooting = false;
  int cooldownTime = 30;
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
      if (keyCode == UP || key == 'W' || key == 'w') {
        y -= ySpeed;
      }

      if (keyCode == DOWN || key == 'S' || key == 's') {
        y += ySpeed;
      }

      if (keyCode == LEFT || key == 'A' || key == 'a') {
        x -= xSpeed;
      }

      if (keyCode == RIGHT || key == 'D' || key == 'd') {
        x += xSpeed;
      }
      
      shootingBehavior();
    }
  }

  void shootingBehavior () {
    if (!shooting) {
      if (key == ' ') {
        // instantiate a new player laser at the player's current position
        PlayerLaser laser = new PlayerLaser(x, y);
        pLasers[laserIdx] = laser;
        shooting = true;
      }
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
