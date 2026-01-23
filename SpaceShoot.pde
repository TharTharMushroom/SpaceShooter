import java.util.*;
Player p1, p2, p;
// red, blue
int p1Select, p2Select = 0;
boolean leftKey, rightKey, upKey, downKey, shootKey, superKey, switchKey;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<EnemyProj> enemyProjs = new ArrayList<EnemyProj>();
ArrayList<Enemy> waveList = new ArrayList<Enemy>();
ArrayList<Button> buttons = new ArrayList<Button>();
int playerHP;
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
  textAlign(CENTER);
  rewriteScene();
}

void draw(){
  background(0);
  if(inCombat){
    checkWaves();
    updatePlayerMovement();
    playersUpdates();
    updateEnemies();
    updateEnemyProjectiles();
    text(playerHP, 40, 40); 
    text(frameRate, 80, 80);
    if(playerHP<=0){
      playerEndLevel(false);
    }
  }
  updateButtons();
}

public void updateButtons(){
  for(int i = buttons.size()-1; i>=0;i--){
    buttons.get(i).drawButton();
  }
}

public void playerEndLevel(boolean win){
  inCombat = false;
  enemies.clear();
  enemyProjs.clear();
  if(win){
    currentScene = 4;
  }else{
    currentScene = 5;
  }
  rewriteScene();
}

public void checkWaves(){
  if(enemies.size()==0){
    if(waveList.size()==0){
      playerEndLevel(true);
    }else{
      newWave();
    }
  }
}

public void newWave(){
  while(waveList.size()>0){
    if(waveList.get(0)!=null){
      enemies.add(waveList.get(0));
      waveList.remove(0);
    }else{
      waveList.remove(0);
      break;
    }
  }
}

public void startCombat(){
  playerHP = 5;
  if(assignCharacters()){
    enemies.clear();
    waveList.clear();
    inCombat = true;
    waveList.add(new BasicEnemy(800, 100));
    waveList.add(null);
    waveList.add(new BasicEnemy(850, 400));
    waveList.add(new BasicEnemy(750, 200));
    waveList.add(null);
    waveList.add(new BasicEnemy(800, 100));
    waveList.add(new BasicEnemy(800, 500));
    waveList.add(new BasicEnemy(800, 300));
  }
}

public boolean assignCharacters(){
  switch(p1Select){
    case 1: p1 = new Red(); break;
    case 2: p1 = new Blue(); break;
    case 3: p1 = new Green(); break;
    case 4: p1 = new Yellow(); break;
    default: p1 = null; currentScene=3; rewriteScene(); break;
  }
  switch(p2Select){
    case 1: p2 = new Red(); break;
    case 2: p2 = new Blue(); break;
    case 3: p2 = new Green(); break;
    case 4: p2 = new Yellow(); break;
    default: p2 = null; currentScene=3; rewriteScene(); break;
  }
  if(p1!=null&&p2!=null){
    return true;
  }else{
    return false;
  }
}

public void rewriteScene(){
  buttons.clear();
  switch(currentScene){
    // 0 - starts combat
    case 0: startCombat(); break;
    // 1 - home screen
    case 1: buttons.add(new Button(480, 200, 480, 60, 3, 1, color(61, 181, 255),"Start"));
            //buttons.add(new Button(400, 400, 50, 80, 2, 1, color(255,255,255),""));
            break;
    // 2 - character info
    case 2: buttons.add(new Button(600, 400, 50, 50, 1, 1, color(255,255,255),""));
            break;
    // 3 character select
    case 3: characterSelectButtons(600, 180); 
            buttons.add(new Button(480, 50, 600, 50, 0, 0, color(255, 61, 61),"Select two characters"));
            buttons.add(new Button(230, 270, 200, 350, 0, 3, color(255,255,255),"")); 
            buttons.add(new Button(430, 270, 200, 350, 0, 4, color(255,255,255),""));
            buttons.add(new Button(320, 490, 300, 60, 1, 1, color(61, 181, 255),"Back")); 
            buttons.add(new Button(640, 490, 300, 60, 0, 1, color(61, 181, 255),"Begin"));
            playerPicturesChange();
            break;
     // 4 win level
     case 4: buttons.add(new Button(480, 200, 480, 60, 1, 1, color(61, 181, 255),"You Won!"));break;
     // 5 lose level
     case 5: buttons.add(new Button(480, 200, 480, 60, 1, 1, color(61, 181, 255),"You Lost..."));break;
    default: print("Something went wrong");break;
  }
}

public void characterSelectButtons(int x, int y){
    buttons.add(new Button(x, y, 50, 50, 1, 2, color(255,0,0),""));
    buttons.add(new Button(x+50, y, 50, 50, 2, 2, color(0,0,255),""));
    buttons.add(new Button(x+100, y, 50, 50, 3, 2, color(0,255,0),""));
    buttons.add(new Button(x, y+50, 50, 50, 4, 2, color(255,255,0),""));
}

public void playerSelectChange(int in){
  if(p1Select==0&&in!=p2Select){
    p1Select=in;
  }else if(p2Select==0&&in!=p1Select){
    p2Select=in;
  }
  playerPicturesChange();
}

public void playerPicturesChange(){
  for(int j = buttons.size()-1; j>=0;j--){
    if(buttons.get(j).getPurpose()==3){
      buttons.get(j).colorChange(getPlayerColor(p1Select));
    }else if(buttons.get(j).getPurpose()==4){
      buttons.get(j).colorChange(getPlayerColor(p2Select));
    } 
  }
}

public color getPlayerColor(int in){
  switch(in){
    case 0: return color(255,255,255);
    case 1: return color(255,0,0);
    case 2: return color(0,0,255);
    case 3: return color(0,255,0);
    case 4: return color(255,255,0);
    default: return color(255, 255, 255);
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
      if(buttons.get(i).getPurpose()==1){
        currentScene = buttons.get(i).getNext();
        rewriteScene();
      }else if(buttons.get(i).getPurpose()==2){
        playerSelectChange(buttons.get(i).getNext());
      }else if(buttons.get(i).getPurpose()==3){
        p1Select=0;
        playerPicturesChange();
      }else if(buttons.get(i).getPurpose()==4){
        p2Select=0;
        playerPicturesChange();
      }
      break;
    }
  }
}
