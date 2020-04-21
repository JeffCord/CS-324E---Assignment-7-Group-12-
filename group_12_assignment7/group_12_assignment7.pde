Enemy[] enemies = new Enemy[20];
PImage[] aliens = new PImage[2];
int numFrames = 11;
PImage[]  explosion = new PImage[numFrames];
//Explode_Timer explode_gif = new Explode_Timer(0,0,200,-2,0,50,0);
float time;
int difficulty;


void setup() {
  size(800,800);
  background(0);
  colorMode(HSB);
  frameRate(30);
  for (int i = 0; i < explosion.length; i++) {
   String imageName = "explode-" + nf(i+1,2) + ".png";;
   explosion[i] = loadImage(imageName);
  } 
  for (int i = 0; i < aliens.length; i++) {
   String imageName = "Alien_Enemy_" + nf(i+1,2) + ".png";;
   aliens[i] = loadImage(imageName);
  }
  enemies[0] = new Enemy(900,random(30,700),50,-5,aliens[0]);
}

void draw() {
  background(0);
  time = millis()/1000;
  if (time % 2 == 0) {
    int index = int(random(aliens.length));
    enemies[millis()/2000] = new Enemy(900,random(30,700),200,-5,aliens[index]);
  }
  
  for (int i = 0; i < enemies.length; i++) {
    if (enemies[i] != null) {
      enemies[i].display();
      if (enemies[i].location.x < -50) {
        enemies[i] = null; 
      }
    }
  }

    
    
}
  
  
