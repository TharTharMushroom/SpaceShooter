class Enemy{
  float x;
  float y;
  float wide;
  float high;
  int hp;
  public Enemy(float x, float y, float wide, float high, int hp){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.hp=hp;
  }
  public void drawEnemy(){
    rect(x,y,wide,high);
  }
  public int getHP(){
    return hp;
  }
  
}
