Enemy alien_1 = new Enemy(900, 250, 200, -2);
int numFrames = 11;
PImage enemy_1;
PImage[]  explosion = new PImage[numFrames];
Explode_Timer explode_gif = new Explode_Timer(0,0,200,-2,0,50,0);


void setup() {
  size(800,800);
  background(0);
  colorMode(HSB);
  frameRate(30);
  for (int i = 0; i < explosion.length; i++) {
   String imageName = "explosion-" + nf(i+1,2) + ".png";;
   explosion[i] = loadImage(imageName);
  } 
  
  enemy_1 = loadImage("Alien_Enemy_1.png");
}

void draw() {
  background(0);
  push();
  alien_1.display();
  pop();
  
}
