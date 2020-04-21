class Explode_Timer extends Enemy {
  int animationTimer;
  int animationTimerValue;
  int currentFrame;

  
  Explode_Timer(float x, float y, float radius, float speed, PImage alien, int animationTimer,int animationTimerValue, int currentFrame){
    super(x,y,radius,speed,alien);
    this.animationTimer = animationTimer;
    this.animationTimerValue = animationTimerValue;
    this.currentFrame = currentFrame;
  }
  
void display() {
  
  image(explosion[currentFrame], location.x, location.y);
  if ((millis() - animationTimer) >= animationTimerValue) {
    currentFrame = (currentFrame + 1) % numFrames;
    animationTimer = millis();
  }  
}
}
