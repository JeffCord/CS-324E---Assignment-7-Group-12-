Enemy[] enemies = new Enemy[100];
PImage[] aliens = new PImage[2];

int difficulty = 120;
int difficulty_increase = 10;
int enemy_index = 1;
int enemy_speed = -2;

int numFrames = 11;
PImage[]  explosion = new PImage[numFrames];




void setup() {
  
  size(800,800);
  background(0);
  colorMode(HSB);
  
  // future explosion sprite array
  for (int i = 0; i < explosion.length; i++) {
   String imageName = "explode-" + nf(i+1,2) + ".png";;
   explosion[i] = loadImage(imageName);
  } 
  
  // alien image array
  for (int i = 0; i < aliens.length; i++) {
   String imageName = "Alien_Enemy_" + nf(i+1,2) + ".png";;
   aliens[i] = loadImage(imageName);
  }
  
  enemies[0] = new Enemy(900,random(30,700),200,enemy_speed,aliens[0]);
  
}

void draw() {
  background(0);
  
  
  // temporary stop at 30 seconds
  if (frameCount == 1800) {
   exit(); 
  }
  
  // increases frequency of enemy spawn every 2 seconds
  if (frameCount % 120 == 0 && difficulty > 10) {
    difficulty -= difficulty_increase;
  }
  
  // spawns an enemy in an enemy array
  //if (frameCount % difficulty == 0) {
  //  int index = int(random(aliens.length));
  //  enemies[enemy_index] = new Enemy(900,random(30,700),200,enemy_speed,aliens[index]);
  //  enemy_index += 1;
  //}
  
  // checks enemy array for enemies in bounds and displays
  // deletes enemies if they are off screen to save memory
  for (int i = 0; i < enemies.length; i++) {
    if (enemies[i] != null) {
      enemies[i].display();
      enemies[i].isOver();
      enemies[i].isClicked();
      if (enemies[i].location.x < -50) {
        enemies[i] = null; 
      }
      if (enemies[i].clicked == true) {
       Explode_Timer gif = new Explode_Timer(0,50,0,enemies[i].location.x,enemies[i].location.y);
       for (int j = 0; j < numFrames; j++) {
       gif.display(j);
       }
       enemies[i] = null;
      }
    }  
  }
}
  
  
