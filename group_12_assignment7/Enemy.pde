class Enemy {
 
  float x, y, radius, speed;
  PVector location;
  PVector velocity;
  boolean explode;
  
  Enemy(float x, float y, float radius, float speed) {
   this.x = x;
   this.y = y;
   this.radius = radius;
   location = new PVector(x,y);
   velocity = new PVector(speed,0);
   explode = false;
   
  }
  
  void display() {
    noStroke();
    fill(0,0,0,1);
    circle(location.x,location.y,radius);
    imageMode(CENTER);
    image(enemy_1,location.x,location.y,radius,radius - radius*.4);
    location.add(velocity); 
    }
  
  void explode() {
    
    
  }
  
}
