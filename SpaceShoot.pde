import java.util.*;
Player p;
boolean leftKey, rightKey, upKey, downKey;
void setup() {
  size(960, 540);
  p = new Player(50,50);
}

void draw(){
  background(0);
  updatePlayerMovement();
  p.update();
  p.drawPlayer();
  p.updateProjectiles();
  p.updateBeams();
  
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
    p.addProj(new Projectile(p.getX(), p.getY(), 20.0, 4));
  }
  if(key == 'b' || key == 'B'){
    p.addBeam(new Beam(p.getX(), p.getY(), 20, 20));
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
