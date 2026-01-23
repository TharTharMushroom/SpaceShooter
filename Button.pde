class Button{
  float x;
  float y;
  float high;
  float wide;
  int next;
  int purpose;
  color c;
  String text;
  public Button(float x, float y, float wide, float high, int next, int purpose, color c, String text){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.next=next;
    this.purpose=purpose;
    this.c=c;
    this.text=text;
  }
  
  public void drawButton(){
    fill(c);
    rect(x, y, wide, high);
    fill(255);
    text(text, x, y+8);
  }
  
  //0 nothing, 1 change scene, 2 change character, 3 char one, 4 char 2
  public int getPurpose(){
    return purpose;
  }
  
  public int getNext(){
    return next;
  }
  
  public void colorChange(color col){
    c=col;
  }
  
  public boolean checkCollision(){
    if(x+wide/2 > mouseX && x-wide/2 < mouseX && y+high/2 > mouseY && y-high/2 < mouseY){
      return true;
    }else{
      return false;
    }
  }
}
