Player p;
void setup() {
  size(960, 540);
  p = new Player(50,50);
}

void draw(){
  background(0);
  p.drawPlayer();
  p.changeX(5);
  p.changeY(3);
}
