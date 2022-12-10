void gameOver(){
  background(yellow);
  leftScore=0;
  rightScore=0;
  
   fill(black);
  text(winner, width/2, height/2);
  
  Button restartButton=new Button("Restart", width/2, height/2+200, 100, 50, yellow, lightBlue);
  restartButton.act(); 
  restartButton.show();
  
  if(restartButton.clicked){
    mode=1; 
  }
}
