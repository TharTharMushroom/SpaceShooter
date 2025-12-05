class Player{
  float x;
  float y;
  float xVel=0;
  float yVel=0;
  float friction = 0.92;
  public Player(float x, float y){
    this.x=x;
    this.y=y;
  }
  
  public void drawPlayer(){
    rect(x,y,50,50);
  }
  
  public void update(){
    xVel *= friction;
    yVel *= friction;
    x+=xVel;
    y+=yVel;
  }
  
  public void changeX(float change){
    xVel += change;
  }
  
  public void changeY(float change){
    yVel += change;
  }
}
