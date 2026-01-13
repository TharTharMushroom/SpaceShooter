class Enemy{
  float x;
  float y;
  float xVel = 0;
  float yVel = 0;
  float xVelChange = 0;
  float yVelChange = 0;
  float wide;
  float high;
  int hp;
  int shootCooldown;
  int totalShootCooldown;
  float friction = 0.96;
  public Enemy(float x, float y, float wide, float high, int hp, int totalShootCooldown){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.hp=hp;
    this.totalShootCooldown=totalShootCooldown;
    this.shootCooldown=totalShootCooldown;
  }
  
  public void drawEnemy(){
    rect(x,y,wide,high);
  }
  
  public void onDefeat(){
    //empty
  }
  
  public EnemyProj shootProj(EnemyProj proj){
    if(shootCooldown<=0){
      shootCooldown = totalShootCooldown;
      return proj;
    }else{
      return null;
    }
  }
  
  public void update(){
    shootCooldown -= 1;
    xVel += xVelChange;
    yVel += yVelChange;
    xVel *= friction;
    yVel *= friction;
    x+=xVel;
    y+=yVel;
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

class BasicEnemy extends Enemy{
  
  BasicEnemy(int x, int y){
    super(x, y, 60, 60, 120, 50);
    yVelChange=0.2;
  }
  
  public void update(){
    shootCooldown -= 1;
    xVel += xVelChange;
    yVel += yVelChange;
    xVel *= friction;
    yVel *= friction;
    x+=xVel;
    y+=yVel;
    if(y<50){
      yVelChange = 0.2;
    }else if(y>height-50){
      yVelChange = -0.2;
    }
  }
  
}
