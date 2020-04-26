class Explode_Timer {
  int animationTimer;
  int animationTimerValue;
  int currentFrame;
  float x, y;

  Explode_Timer(int animationTimer, int animationTimerValue, int currentFrame, float x, float y) {
    this.animationTimer = animationTimer;
    this.animationTimerValue = animationTimerValue;
    this.currentFrame = currentFrame;
    this.x = x;
    this.y = y;
  }

  void display(int currentFrame) {
    image(explosion[currentFrame], x, y);
    if ((millis() - animationTimer) >= animationTimerValue) {
      currentFrame = (currentFrame + 1) % numFrames;
      animationTimer = millis();
    }
  }
}
