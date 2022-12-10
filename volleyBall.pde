import fisica.*; //<>//
boolean mouseReleased=false;
boolean wasPressed=false;

PImage buttonImg;

boolean wkey, skey, akey, dkey;
boolean upkey, downkey, leftkey, rightkey;
boolean canScore=true;

int scorer;
String winner;

color white=#FFFFFF;
color lightBlue=#4cc9f0;
color midBlue=#4361ee;
color darkBlue=#3a0ca3;
color darkPurple=#7209b7;
color pink=#f72585;
color yellow=#ffd60a;
color orange=#ff7d00;
color black=#080000;

FWorld world;
FBox leftPlayer;
FBox rightPlayer;
FCircle ball;
FBox leftPlatform;
FBox rightPlatform;

int leftScore=0;
int rightScore=0;

int cooldown=36;
int threshold=0;

int mode=1;
int GAME=1; 
int GAMEOVER=2;

void setup() {
  size(800, 800);
  setWorld();

  leftPlayer = makeStand(darkPurple, 200, 600);
  rightPlayer = makeStand(pink, 600, 600);
  makeBall(darkBlue, 100);
  makePlatform();

  world.setEdges(white);
  world.setEdges(390, 500, 410, 700);
}

void draw() {
  click();
  if(mode==1){
    game();
  }else if(mode==2){
    gameOver();
  }
}

void game(){
  background(lightBlue);

  /*fill(yellow);
   rect(0, 700, width, 100);*/

  rectMode(CORNER);
  fill(white);
  rect(390, 500, 20, 300);

  textSize(50);
  textAlign(CENTER);
  text(leftScore, 200, 300);
  text(rightScore, 600, 300);

  handlePlayerInput();

  if (hitGround(leftPlatform)) {
    if (canScore) {
      rightScore++;
      scorer=2;      
      canScore=false;
    }
  }
  if (hitGround(rightPlatform)) {
    if (canScore) {
      leftScore++;
      scorer=1;
      canScore=false;
    }
  }
  
  if(leftScore>=5){
    mode=2;
    winner="LeftWin";
  }else if(rightScore>=5){
    mode=2;
    winner="RightWin";
  }
  
  if(!canScore){
    reset();
  }

  if (canScore) {
    world.step();
  }
  world.draw();
}

void setWorld() {
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 900);
}

void makePlatform() {
  leftPlatform=new FBox(400, 100);
  leftPlatform.setStatic(true);
  leftPlatform.setFillColor(yellow);
  leftPlatform.setPosition(200, 750);
  leftPlatform.setGrabbable(false);
  world.add(leftPlatform);
  rightPlatform=new FBox(400, 100);
  rightPlatform.setStatic(true);
  rightPlatform.setFillColor(orange);
  rightPlatform.setPosition(600, 750);
  rightPlatform.setGrabbable(false);
  world.add(rightPlatform);
}

FBox makeStand(color c, int x, int y) {
  FBox stand=new FBox(100, 100);
  stand.setStrokeWeight(2);
  stand.setPosition(x, y);
  stand.setFillColor(c);
  world.add(stand);
  return stand;
}

void makeBall(color c, int d) {
  ball=new FCircle(d);
  ball.setStrokeWeight(2);
  int xPos=(int) random(200, 600);
  ball.setPosition(xPos, 400-d/2-100);
  ball.setFillColor(c);
  ball.setRestitution(1);

  world.add(ball);
}

boolean hitGround(FBox ground) {
  ArrayList<FContact> contactArrList=ball.getContacts();
  for (int i=0; i<contactArrList.size(); i++) {
    FContact temp=contactArrList.get(i);
    if (temp.contains(ground)) {
      return true;
    }
  }
  return false;
}

void reset() {
  println(threshold);
  threshold++;
  if (threshold<cooldown) {
    canScore=false;
  }else {
    world.step();
    canScore=true; 
    threshold=0;
  }

  if (scorer==1) {
    ball.setPosition(leftPlayer.getX(), 400-100/2-30);
  } else if (scorer==2) {
    ball.setPosition(rightPlayer.getX(), 400-100/2-30);
  }
  ball.setVelocity(0, 9.8);
}

boolean isContacting(FBody body) {
  ArrayList<FContact> contacts=body.getContacts();
  if (contacts.size()>0) {
    return true;
  }
  return false;
}

void handlePlayerInput() {
  float leftvx=leftPlayer.getVelocityX();
  float leftvy=leftPlayer.getVelocityY();
  float rightvx=rightPlayer.getVelocityX(); 
  float rightvy=rightPlayer.getVelocityY();
    
  if (isContacting(leftPlayer)) {
    if (wkey) {
      leftPlayer.setVelocity(leftvx, -550);
    }
    if (skey) {
      leftPlayer.setVelocity(leftvx, 550);
    }
    if (akey) {
      leftPlayer.setVelocity(-200, leftvy);
    }
    if (dkey) {
      leftPlayer.setVelocity(200, leftvy);
    }
  }
  if (isContacting(rightPlayer)) {
    if (upkey) {
      rightPlayer.setVelocity(rightvx, -550);
    }
    if (downkey) {
      rightPlayer.setVelocity(rightvx, 550);
    }
    if (leftkey) {
      rightPlayer.setVelocity(-200, rightvy);
    }
    if (rightkey) {
      rightPlayer.setVelocity(200, rightvy);
    }
  }
}

void keyPressed() {
  if (key=='w'||key=='W') {
    wkey=true;
  }
  if (key=='a'||key=='A') {
    akey=true;
  }
  if (key=='d'||key=='D') {
    dkey=true;
  }
  if (key=='s'||key=='S') {
    skey=true;
  }
  if (keyCode==UP) {
    upkey=true;
  }
  if (keyCode==DOWN) {
    downkey=true;
  }
  if (keyCode==RIGHT) {
    rightkey=true;
  }
  if (keyCode==LEFT) {
    leftkey=true;
  }
}

void keyReleased() {
  if (key=='w'||key=='W') {
    wkey=false;
  }
  if (key=='a'||key=='A') {
    akey=false;
  }
  if (key=='d'||key=='D') {
    dkey=false;
  }
  if (key=='s'||key=='S') {
    skey=false;
  }
  if (keyCode==UP) {
    upkey=false;
  }
  if (keyCode==DOWN) {
    downkey=false;
  }
  if (keyCode==RIGHT) {
    rightkey=false;
  }
  if (keyCode==LEFT) {
    leftkey=false;
  }
}
