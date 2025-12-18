class Projectile{
  float x;
  float y;
  float wide;
  float high;
  float xVel;
  float yVel;
  float speed;
  float angle;
  public Projectile(float x, float y, float wide, float high, float angle, float speed){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.angle=radians(angle);
    this.speed=speed;
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
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public boolean checkCollision(float checkX, float checkY, float checkWide, float checkHigh){
    if((checkX + checkWide >= x-wide && checkX+checkWide <= x + wide) && (checkY + checkHigh >= y - high && checkHigh <= y + high)){
      return true;
    }else{
      return false;
    }
  }
}
