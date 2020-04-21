class PlayerLaser {
  float x, y, w, h;
  float xSpeed;

  PlayerLaser(float x, float y) {
    this.x = x;
    this.y = y;
    xSpeed = 20;
    w = 50;
    h = 5;
  }

  void update() {
    x += xSpeed;
  }

  void display() {
    rectMode(CENTER);
    fill(#2CFF4D);
    noStroke();
    rect(x, y, w, h);
  }
}
