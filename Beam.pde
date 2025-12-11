class Beam{
  float x;
  float y;
  float wide;
  int duration;
  public Beam(float x, float y, float wide, int duration){
    this.x=x;
    this.y=y;
    this.wide=wide;
    this.duration=duration;
  }
  
  public void drawBeam(){
    rect(x,y,width,wide);
  }
  
  public void update(float xUpd, float yUpd){
    duration -= 1;
    x=xUpd;
    y=yUpd;
  }
  
  public int beamDur(){
    return duration;
  }
}
