class Enemy{
  float x;
  float y;
  float xVel = 0;
  float yVel = 0;
  float wide;
  float high;
  int hp;
  int shootCooldown;
  int totalShootCooldown;
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
