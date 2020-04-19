class Enemy {
 
  float x, y, radius, speed;
  boolean explode;
  PVector location;
  PVector velocity;
  
  Enemy(float x, float y, float radius) {
   this.x = x;
   this.y = y;
   this.radius = radius;
   location = new PVector(x,y);
   velocity = new PVector(speed,0);
   explode = false;
   
  }
  
  
}
