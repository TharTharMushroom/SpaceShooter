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
  public void changeHP(int dmg){
    hp -= dmg;
  }
  public int getHP(){
    return hp;
  }
  public float getX(){
    return x;
  }
  public float getY(){
    return y;
  }
  public float getWide(){
    return wide;
  }
  public float getHigh(){
    return high;
  }
}
