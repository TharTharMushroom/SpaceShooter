class Projectile{
  float x;
  float y;
  float wide;
  float high;
  float xVel;
  float yVel;
  float speed;
  float angle;
  int damage;
  public Projectile(float x, float y, float wide, float high, float angle, float speed, int damage){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.angle=radians(angle);
    this.speed=speed;
    this.damage=damage;
  }
  
  public void drawProj(){
    rect(x,y,wide,high);
  }
  
  public void update(){
    xVel = cos(angle)*speed;
    yVel = sin(angle)*speed;
    x+=xVel;
    y+=yVel;
  }
  
  public int getDamage(){
    return damage;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public boolean checkCollision(float checkX, float checkY, float checkWide, float checkHigh){
    if(x+wide/2 > checkX - checkWide/2 && x-wide/2 < checkX + checkWide/2 && y+high/2 > checkY - checkHigh/2 && y-high/2 < checkY + checkHigh/2){
      return true;
    }else{
      return false;
    }
  }
}
