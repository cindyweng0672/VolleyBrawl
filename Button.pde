class Button {
  int x, y, w, h;
  boolean clicked; 
  color normal, highlighted;
  String text; 
  PImage img;
  
  boolean isText;

  Button(String text, int x, int y, int w, int h, color normal, color highlighted) {
    this.text=text;
    this.x=x; 
    this.y=y;
    this.w=w; 
    this.h=h; 
    this.normal=normal; 
    this.highlighted=highlighted; 
    clicked=false;
    isText=true;
  }
  
  Button(PImage img, int x, int y, int w, int h, color normal, color highlighted){
    this.img=img;
    this.x=x;
    this.y=y;
    this.w=w;
    this.h=h; 
    this.normal=normal;
    this.highlighted=highlighted;
    clicked=false;
    isText=false;
  }

  void show() {
    drawButton();
    if(isText){
      drawText();
    }else{
      drawImg();
    }
  }

  void act() {
    if(!isText){
      resizeImg();
    }
    buttonClicked();
    //checkClicked();
  }

  void buttonClicked() {
    if (mouseReleased && mouseX<x+w/2 && mouseX>x-w/2 && mouseY<y+h/2 && mouseY>y-h/2) {
      clicked=true;
    } else {
      clicked=false;
    }
  }

  /*void checkClicked() {
    if (mouseReleased && clicked==true) {
      backgroundColor=highlighted;
      println("fill");
      println(backgroundColor);
      println(highlighted);
    }
  }*/
  
  void drawButton(){
    rectMode(CENTER);
    
    stroke(black);
    if(mouseX<x+w/2 && mouseX>x-w/2 && mouseY<y+h/2 && mouseY>y-h/2){
      strokeWeight(8);
    }else{
      strokeWeight(4);
    }
    
    if (mouseX<x+w/2 && mouseX>x-w/2 && mouseY<y+h/2 && mouseY>y-h/2) {
      fill(highlighted);
    } else {
      fill(normal);
    }
    rect(x, y, w, h, 30);
  }
  
  void drawText(){
    textAlign(CENTER, CENTER);
    
    if (mouseX<x+w/2 && mouseX>x-w/2 && mouseY<y+h/2 && mouseY>y-h/2) {
      fill(normal);
    } else {
      fill(highlighted);
    } 
    textSize(w/4);
    text(text, x, y);
  }
  
  void drawImg(){
    imageMode(CENTER);
    image(img, x, y);
  }
  
  void resizeImg(){
    if(mouseX<x+w/2 && mouseX>x-w/2 && mouseY<y+h/2 && mouseY>y-h/2){
      img.resize(w/2+w/10, h/2+h/10);
    }else{
      img.resize(w/2, h/2);
    }
  }
}
