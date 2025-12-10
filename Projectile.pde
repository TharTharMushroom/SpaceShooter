class Projectile{
  float x;
  float y;
  float xVel;
  float yVel;
  float speed = 3;
  float angle;
  public Projectile(float x, float y, float angle){
    this.x=x;
    this.y=y;
    this.angle=radians(angle);
  }
  
  public void drawProj(){
    rect(x,y,10,10);
  }
  
  public void update(){
    xVel = cos(angle)*speed;
    yVel = sin(angle)*speed;
    x+=xVel;
    y+=yVel;
  }
  
}
