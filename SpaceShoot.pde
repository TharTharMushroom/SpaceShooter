import java.util.*;
Player p;
boolean leftKey, rightKey, upKey, downKey, shootKey;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void setup() {
  size(960, 540);
  p = new Player(50,50,50,50,10);
  enemies.add(new Enemy(500, 250, 30, 30, 100));
  rectMode(CENTER);
}

void draw(){
  background(0);
  updatePlayerMovement();
  p.update();
  p.drawPlayer();
  updateEnemies();
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
  if(shootKey){
    p.shootProj();
  }
}

public void updateEnemies(){
    for(int i = enemies.size()-1; i>=0;i--){
      enemies.get(i).drawEnemy();
      if(enemies.get(i).getHP()<0){
        enemies.remove(i);
      }
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
    shootKey = true;
  }
  if(key == 'b' || key == 'B'){
    p.addBeam(new Beam(p.getX(), p.getY(), 20, 15));
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
  if(key == 'a' || key == 'A'){
    shootKey = false;
  }
}
