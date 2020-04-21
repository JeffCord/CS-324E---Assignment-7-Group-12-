class Enemy {
 
  float x, y, radius, speed;
  PVector location;
  PVector velocity;
  PImage alien;
  boolean explode;
  
  Enemy(float x, float y, float radius, float speed, PImage alien) {
   this.x = x;
   this.y = y;
   this.radius = radius;
   this.alien = alien;
   location = new PVector(x,y);
   velocity = new PVector(speed,0);
   explode = false;
   
  }
  
  void display() {
    noStroke();
    fill(0,0,0,1);
    circle(location.x,location.y,radius);
    imageMode(CENTER);
    image(alien,location.x,location.y,radius,radius - radius*.4);
    location.add(velocity); 
    }
  
  void explode() {
    
    
  }
  
}