import java.util.*;
Player p1, p2, p;
boolean leftKey, rightKey, upKey, downKey, shootKey, superKey, switchKey;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<EnemyProj> enemyProjs = new ArrayList<EnemyProj>();
ArrayList<Button> buttons = new ArrayList<Button>();
int playerHP = 5;
int immuneCD = 0;
int currPlayer = 1;
int switchCD = 0;
int maxSwitchCD = 200;
int currentScene = 1;
int levelSelect;
boolean inCombat = false;

void setup() {
  size(960, 540);
  textSize(30);
  rectMode(CENTER);
  rewriteScene();
}

void draw(){
  background(0);
  if(inCombat){
    updatePlayerMovement();
    playersUpdates();
    updateEnemies();
    updateEnemyProjectiles();
    text(playerHP, 40, 40); 
    text(frameRate, 80, 80);
  }
  updateButtons();
}

public void updateButtons(){
  for(int i = buttons.size()-1; i>=0;i--){
    buttons.get(i).drawButton();
  }
}

public void startCombat(){
  inCombat = true;
  p1 = new Blue();
  p2 = new Red();
  enemies.add(new Enemy(500, 250, 30, 30, 100, 60));
  enemies.add(new Enemy(700, 350, 70, 50, 200, 100));
}

public void rewriteScene(){
  buttons.clear();
  switch(currentScene){
    case 0: startCombat(); break;
    case 1: buttons.add(new Button(300, 300, 50, 50, 0, true));
            buttons.add(new Button(400, 400, 50, 80, 2, true));
            break;
    case 2: buttons.add(new Button(600, 400, 50, 50, 1, true));
            break;
    default: print("Something went wrong");break;
  }
}

public void playersUpdates(){
  switchCD--;
  p1.update();
  p1.drawPlayer();
  p1.updateProjectiles();
  p1.updateCollisions(enemies);
  p2.update();
  p2.drawPlayer();
  p2.updateProjectiles();
  p2.updateCollisions(enemies);
  p = currPlayer == 1 ? p1 : p2;
}

public void updateEnemyProjectiles(){
    for(int i = enemyProjs.size()-1; i>=0;i--){
      enemyProjs.get(i).update();
      enemyProjs.get(i).drawProj();
      if(enemyProjs.get(i).checkCollision(p.getX(), p.getY(), p.getWide(), p.getHigh())){
        if(immuneCD<=0){
            playerHP -= 1;
            immuneCD = 60;
        }
        enemyProjs.remove(i);
        continue;
      }
      if(enemyProjs.get(i).getX()<-50||enemyProjs.get(i).getX()>width+50){
        enemyProjs.remove(i);
      }
    }
  }
  
  public void updateEnemies(){
    for(int i = enemies.size()-1; i>=0;i--){
      enemies.get(i).update();
      enemies.get(i).drawEnemy();
      EnemyProj en = enemies.get(i).shootProj(new EnemyProj(enemies.get(i).getX(), enemies.get(i).getY(), 10, 10, 180, 5));
      if(en != null){
        enemyProjs.add(en);
      }
      if(enemies.get(i).getHP()<0){
        enemies.remove(i);
      }
    }
  }

void updatePlayerMovement(){
  immuneCD--;
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
  if(superKey){
    p.shootSuper();
  }
  if(switchKey&&switchCD<=0){
    if(currPlayer==1){
      currPlayer=2;
    }else{
      currPlayer=1;
    }
    switchCD=maxSwitchCD;
    immuneCD = 30;
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
  if(key == 's' || key == 'S'){
    superKey = true;
  }
  if(key == 'z' || key == 'Z'){
    switchKey = true;
  }
  if(key == 'b' || key == 'B'){
    p1.addBeam(new Beam(p1.getX(), p1.getY(), 20, 15));
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
  if(key == 'z' || key == 'Z'){
    switchKey = false;
  }
  if(key == 's' || key == 'S'){
    superKey = false;
  }
}

void mousePressed(){
  for(int i = buttons.size()-1; i>=0;i--){
    if(buttons.get(i).checkCollision()){
      if(buttons.get(i).isSceneButton()){
        currentScene = buttons.get(i).getNext();
        rewriteScene();
      }else{
        
      }
      break;
    }
  }
}
