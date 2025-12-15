class Player{
  float x;
  float y;
  float xVel=0;
  float yVel=0;
  float friction = 0.9;
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  ArrayList<Beam> beams = new ArrayList<Beam>();
  public Player(float x, float y){
    this.x=x;
    this.y=y;
  }
  
  public void drawPlayer(){
    rect(x,y,50,50);
  }
  
  public void update(){
    xVel *= friction;
    yVel *= friction;
    x+=xVel;
    y+=yVel;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
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
      if(projs.get(i).beamDur()<0){
        beams.remove(i);
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
