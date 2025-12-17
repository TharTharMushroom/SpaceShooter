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
  public Player(float x, float y, float wide, float high){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.high=high;
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
      p.addProj(new Projectile(p.getX(), p.getY(), 10, 10, 0, 4));
      shootCooldown = 
    }
  }
  
  
  public void stayInScreen(){
    if(x<0){
      x=0;
    }
    if(x>width-wide){
      x=width-wide;
    }
    if(y<0){
      y=0;
    }
    if(y>height-high){
      y=height-high;
    }
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
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
  
  public void addProj(Projectile proj){
    projs.add(proj);
  }
  
  public void addBeam(Beam beam){
    beams.add(beam);
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
    for(int i = beams.size()-1; i>=0;i--){
      beams.get(i).update(p.getX(), p.getY());
      beams.get(i).drawBeam();
      if(beams.get(i).beamDur()<0){
        beams.remove(i);
      }
    }
  }
}
