class Player{
  float x;
  float y;
  float wide;
  float high;
  float xVel=0;
  float yVel=0;
  float friction = 0.9;
  int shootCooldown = 0;
  int totalShootCooldown;
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  ArrayList<Beam> beams = new ArrayList<Beam>();
  public Player(float x, float y, float wide, float high, int totalShootCooldown){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
    this.totalShootCooldown=totalShootCooldown;
  }
  
  public void drawPlayer(){
    rect(x,y,wide,high);
  }
  
  public void update(){
    shootCooldown -= 1;
    xVel *= friction;
    yVel *= friction;
    x+=xVel;
    y+=yVel;
    stayInScreen();
  }
  
  public void shootProj(){
    if(shootCooldown<=0){
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, 0, 8, 10));
      shootCooldown = totalShootCooldown;
    }
  }
  
  
  public void stayInScreen(){
    if(x<wide/2){
      x=wide/2;
    }
    if(x>width-wide/2){
      x=width-wide/2;
    }
    if(y<high/2){
      y=high/2;
    }
    if(y>height-high/2){
      y=height-high/2;
    }
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
  
  public int getShootCD(){
    return shootCooldown;
  }
  
  public void changeX(float change){
    xVel += change;
  }
  
  public void changeY(float change){
    yVel += change;
  }
  
  public void addBeam(Beam beam){
    beams.add(beam);
  }
  
  public void updateCollisions(ArrayList<Enemy> enemies){
    for(int i = projs.size()-1; i>=0; i--){
       for(int j = enemies.size()-1; j>=0; j--){
         Enemy ene = enemies.get(j);
         if(projs.get(i).checkCollision(ene.getX(), ene.getY(), ene.getWide(), ene.getHigh())){
           enemies.get(j).changeHP(projs.get(i).getDamage());
           projs.remove(i);
           break;
         }
      }
    }
  }
  
  public void updateProjectiles(){
    for(int i = projs.size()-1; i>=0;i--){
      projs.get(i).update();
      projs.get(i).drawProj();
      if(projs.get(i).getX()<-50||projs.get(i).getX()>width+50){
        projs.remove(i);
      }
    }
  }

  public void updateBeams(){
    rectMode(CORNER);
    for(int i = beams.size()-1; i>=0;i--){
      beams.get(i).update(getX(), getY());
      beams.get(i).drawBeam();
      if(beams.get(i).beamDur()<0){
        beams.remove(i);
      }
    }
    rectMode(CENTER);
  }
}
