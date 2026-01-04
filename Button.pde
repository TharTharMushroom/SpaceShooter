class Button{
  float x;
  float y;
  float high;
  float wide;
  int next;
  boolean sceneButton;
  public Button(float x, float y, float wide, float high, int next, boolean sceneButton){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.next=next;
    this.sceneButton=sceneButton;
  }
  
  public void drawButton(){
    rect(x, y, wide, high);
  }
  
  public boolean isSceneButton(){
    return sceneButton;
  }
  
  public int getNext(){
    return next;
  }
  
  public boolean checkCollision(){
    if(x+wide/2 > mouseX && x-wide/2 < mouseX && y+high/2 > mouseY && y-high/2 < mouseY){
      return true;
    }else{
      return false;
    }
  }
}
