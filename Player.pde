class Player{
  float x;
  float y;
  public Player(float x, float y){
    this.x=x;
    this.y=y;
  }
  
  public void drawPlayer(){
    rect(x,y,50,50);
  }
  
  public void changeX(float change){
    x += change;
  }
  
  public void changeY(float change){
    y += change;
  }
}
