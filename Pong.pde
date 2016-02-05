//Helen Zhang, Block 8, Breakout/Pong
//https://860bffb2ef08cf3a73e06087a4830ebbab4c5649.googledrive.com/host/0B24E0vgcnJ6PZThvTXh2VGlSR2s/index.html
//Sacrifice lives to win

//Global Variables
Ball you;
Paddle player;
Brick [] bricks = new Brick[20];

int lives=1;
int number=0;
boolean is; 
boolean isHit;
boolean gameOver=false;

void setup() {
  frameRate(60);
  size(300, 400);
  noStroke();

  you = new Ball();
  player = new Paddle();
  for (int i=0; i<bricks.length; i++) {
    bricks[i] = new Brick();
  }
}

void draw() {
  background(180, 200, 220);
  
  fill(150);
  textAlign(CENTER);
  textSize(20);
  text("Press A or D to move", 150, 385);
  textSize(15);
  text("Sacrifice lives to win, mwahahaha", 150, 335);
  
  hit();
  you.show();
  player.show();
  for (int i=0; i<bricks.length; i++) {
    bricks[i].show();
  }

  if (gameOver==true) {
    startScreen();
  } else {
    you.run();
    player.move();
    if (check()) {
      is = true;
    } else {
      is = false;
    }
  }
}

void mousePressed(){
  gameOver = false;
  lives++;
}


boolean check() {
  if ( you.getY()==player.getY() && 
    you.getX()>player.getX()-25 && 
    you.getX()<player.getX()+25 ) {
    return true;
  }
  return false;
}

void hit() {
  for (int i = 0; i<bricks.length; i++) {
    for (int w = 0; w<11; w++) {
      if ( you.getY()-10==bricks[i].getY()+20 &&
        you.getX()>bricks[i].getX()-10 &&
        you.getX()<bricks[i].getX()+40 &&
        bricks[i].isGhost() == false
        ) {
        you.bounceOff();
        bricks[i].breaks();
      }else{
        isHit=false;
      }
    }
  }
}

void startScreen(){
  fill(100);
  textAlign(CENTER);
  textSize(20);
  text("You have lost "+lives+" life/lives", 150, 275);//for the sake of time ;-;
  if(number==220){
    text("You have won", 150, 300);
  } else {
    text("Click to continue", 150, 300);
  }
    
}

class Ball{
  //The ball has...
  int x,y;
  boolean up,right;
  
  //Constructor
  Ball(){
    x = int(random(290));
    y = 200;
    up = false;
    right = true;
  }
  
  void run(){
    show();
    move();
    bounce();
  }
  
  void show(){
    fill(100);
    ellipse(x,y,20,20);
  }
  
  void move(){
    if (up == true){
      y-=2;
    } else{
      y+=2;
    }
    if (right == true){
      x++;
    } else{
      x--;
    }
  }
  
  void bounce(){
    if (x-10<0 || x+10>300){
      right = !right;
    }
    if (is == true){
      up = true;
    }
    if (y-10<0){
      up = !up;
    }
    if(y>390){
      gameOver=true;
      x = int(random(290));
      y = 200;
    }
  }
  
  void bounceOff(){
    up = !up;
    number++;
  }
  
  int getX(){
    return x;
  }
  int getY(){
    return y+10;
  }
}
class Brick {
  int x, y;
  boolean broken;
  boolean ghost;
  
  Brick() {
    x=int(random(10))*30;
    y=int(random(10))*20;
    broken = false;
    ghost = false;
  }
  
  void show() {
    if(broken){
     ghost = true;
    } else {
      fill(70);
      rect(x, y, 30, 20);
      fill(120);
      rect(x+25, y, 5, 20);
      ghost = false;
    }
  }
  
  void breaks() {
    broken = true;
  }
  
  boolean isGhost(){
    if ( ghost == true){
      return true;
    }
    return false;
  }

  int getX() {
    return x;
  }
  int getY() {
    return y;
  }
}

class Paddle{
  //Brick has
  int y,x;
  //Constructor 
  Paddle(){
    y=350;
    x=150;
    }
  //Paddle does
  void run(){
    
  }
  
  void show(){
    fill(230);
    rect(x-25, y, 50, 10);
  }
  void move(){
    if(key=='a' && x-25>0){
      x-=2;
    }else if(key=='d' && x+25<300){
      x+=2;
    }
  }
  
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
}


