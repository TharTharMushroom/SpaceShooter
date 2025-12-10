import java.util.*;
ArrayList<Projectile> projs = new ArrayList<Projectile>();
Player p;
boolean leftKey, rightKey, upKey, downKey;
void setup() {
  size(960, 540);
  p = new Player(50,50);
}

void draw(){
  background(0);
  updatePlayerMovement();
  updateProjectiles();
  p.update();
  p.drawPlayer();
}

void updatePlayerMovement(){
  if(upKey){
    p.changeY(-1);
  }
  if(downKey){
    p.changeY(1);
  }
  if(leftKey){
    p.changeX(-1);
  }
  if(rightKey){
    p.changeX(1);
  }
}

void updateProjectiles(){
  for(int i = 0; i<projs.size();i++){
    projs.get(i).update();
    projs.get(i).drawProj();
  }
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      upKey = true;
    }
    if (keyCode == DOWN) {
      downKey = true;
    }
    if (keyCode == LEFT) {
      leftKey = true;
    }
    if (keyCode == RIGHT) {
      rightKey = true;
    }
  }
  if(key == 'a' || key == 'A'){
    projs.add(new Projectile(p.getX(), p.getY(), 0.0));
  }
}

void keyReleased(){
  if (key == CODED) {
    if (keyCode == UP) {
      upKey = false;
    }
    if (keyCode == DOWN) {
      downKey = false;
    }
    if (keyCode == LEFT) {
      leftKey = false;
    }
    if (keyCode == RIGHT) {
      rightKey = false;
    }
  }
}
