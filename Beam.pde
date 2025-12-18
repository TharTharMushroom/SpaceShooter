class Beam{
  float x;
  float y;
  float high;
  float wide;
  int duration;
  public Beam(float x, float y, float high, int duration){
    this.x=x;
    this.y=y;
    this.high=high;
    this.duration=duration;
  }
  
  public void drawBeam(){
    rect(x,y,width,high);
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
