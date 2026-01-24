//  Devin Flanders
//  1/23/26
//  Space shooter game with multiple characters made to improve my java abilities

import java.util.*;

// Global Variables
Player p1, p2, p;
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

/**
 * Initializes the environment settings and initial scene.
 */
void setup() {
  size(960, 540);
  textSize(30);
  rectMode(CENTER);
  textAlign(CENTER);
  rewriteScene();
}

/**
 * Main game loop: handles background, combat logic, and button updates.
 */
void draw() {
  background(0);
  if (inCombat) {
    checkWaves();
    updatePlayerMovement();
    playersUpdates();
    updateEnemies();
    updateEnemyProjectiles();
    
    // UI HUD
    text(playerHP, 40, 40); 
    text(frameRate, 80, 80);
    
    // Game Over Check
    if (playerHP <= 0) {
      playerEndLevel(false);
    }
  }
  updateButtons();
}

/**
 * Updates and renders all active UI buttons.
 */
public void updateButtons() {
  // Iterating backwards to handle potential removals or layered drawing
  for (int i = buttons.size() - 1; i >= 0; i--) {
    buttons.get(i).drawButton();
  }
}

/**
 * Handles the transition when a level concludes.
 * @param win True if the player won, false otherwise.
 */
public void playerEndLevel(boolean win) {
  inCombat = false;
  enemies.clear();
  enemyProjs.clear();
  
  // Set scene based on outcome: 4 for Win, 5 for Loss
  if (win) {
    currentScene = 4;
  } else {
    currentScene = 5;
  }
  rewriteScene();
}

/**
 * Monitors the current enemy list and wave queue to progress the level.
 */
public void checkWaves() {
  if (enemies.size() == 0) {
    if (waveList.size() == 0) {
      playerEndLevel(true); // No enemies and no more waves means victory
    } else {
      newWave();
    }
  }
}

/**
 * Processes the waveList queue and populates the active enemy list.
 * Stops when it encounters a null value, which acts as a wave separator.
 */
public void newWave() {
  while (waveList.size() > 0) {
    if (waveList.get(0) != null) {
      enemies.add(waveList.get(0));
      waveList.remove(0);
    } else {
      // Encountered a wave break (null), remove it and stop adding for now
      waveList.remove(0);
      break;
    }
  }
}

/**
 * Initializes combat variables and populates the wave list for the level.
 */
public void startCombat() {
  playerHP = 5;
  if (assignCharacters()) {
    enemies.clear();
    waveList.clear();
    inCombat = true;
    
    // Wave configuration: 'null' acts as a delimiter between enemy groups
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

/**
 * Instantiates the selected characters for player 1 and player 2.
 * @return True if both players are successfully assigned.
 */
public boolean assignCharacters() {
  // Logic to map integer selection to specific Character Class types
  switch(p1Select) {
    case 1: p1 = new Red(); break;
    case 2: p1 = new Blue(); break;
    case 3: p1 = new Green(); break;
    case 4: p1 = new Yellow(); break;
    default: p1 = null; currentScene = 3; rewriteScene(); break;
  }
  switch(p2Select) {
    case 1: p2 = new Red(); break;
    case 2: p2 = new Blue(); break;
    case 3: p2 = new Green(); break;
    case 4: p2 = new Yellow(); break;
    default: p2 = null; currentScene = 3; rewriteScene(); break;
  }
  
  return (p1 != null && p2 != null);
}

/**
 * Clears and rebuilds the scene UI based on the currentScene state.
 */
public void rewriteScene() {
  buttons.clear();
  switch(currentScene) {
    case 0: // Transition to Gameplay
      startCombat(); 
      break;
    case 1: // Main Menu
      buttons.add(new Button(480, 200, 480, 60, 3, 1, color(61, 181, 255), "Start"));
      break;
    case 2: // Info Screen
      buttons.add(new Button(600, 400, 50, 50, 1, 1, color(255, 255, 255), ""));
      break;
    case 3: // Character Selection Screen
      characterSelectButtons(600, 180); 
      buttons.add(new Button(480, 50, 600, 50, 0, 0, color(255, 61, 61), "Select two characters"));
      buttons.add(new Button(230, 270, 200, 350, 0, 3, color(255, 255, 255), "")); 
      buttons.add(new Button(430, 270, 200, 350, 0, 4, color(255, 255, 255), ""));
      buttons.add(new Button(320, 490, 300, 60, 1, 1, color(61, 181, 255), "Back")); 
      buttons.add(new Button(640, 490, 300, 60, 0, 1, color(61, 181, 255), "Begin"));
      playerPicturesChange();
      break;
    case 4: // Win Screen
      buttons.add(new Button(480, 200, 480, 60, 1, 1, color(61, 181, 255), "You Won!"));
      break;
    case 5: // Loss Screen
      buttons.add(new Button(480, 200, 480, 60, 1, 1, color(61, 181, 255), "You Lost..."));
      break;
    default: 
      print("Something went wrong");
      break;
  }
}

/**
 * Helper to generate the grid of character selection buttons.
 */
public void characterSelectButtons(int x, int y) {
    buttons.add(new Button(x, y, 50, 50, 1, 2, color(255, 0, 0), ""));
    buttons.add(new Button(x + 50, y, 50, 50, 2, 2, color(0, 0, 255), ""));
    buttons.add(new Button(x + 100, y, 50, 50, 3, 2, color(0, 255, 0), ""));
    buttons.add(new Button(x, y + 50, 50, 50, 4, 2, color(255, 255, 0), ""));
}

/**
 * Manages character slot assignment when a user clicks a character button.
 * @param in The character ID selected.
 */
public void playerSelectChange(int in) {
  // Logic to ensure a character can't be picked twice
  if (p1Select == 0 && in != p2Select) {
    p1Select = in;
  } else if (p2Select == 0 && in != p1Select) {
    p2Select = in;
  }
  playerPicturesChange();
}

/**
 * Updates button colors on the selection screen to reflect current character choices.
 */
public void playerPicturesChange() {
  for (int j = buttons.size() - 1; j >= 0; j--) {
    // Purpose 3 corresponds to Player 1 preview, Purpose 4 to Player 2
    if (buttons.get(j).getPurpose() == 3) {
      buttons.get(j).colorChange(getPlayerColor(p1Select));
    } else if (buttons.get(j).getPurpose() == 4) {
      buttons.get(j).colorChange(getPlayerColor(p2Select));
    } 
  }
}

/**
 * Returns the color associated with a character ID.
 * @param in Character ID.
 * @return The corresponding color object.
 */
public color getPlayerColor(int in) {
  switch(in) {
    case 0: return color(255, 255, 255);
    case 1: return color(255, 0, 0);
    case 2: return color(0, 0, 255);
    case 3: return color(0, 255, 0);
    case 4: return color(255, 255, 0);
    default: return color(255, 255, 255);
  }
}

/**
 * Updates logic, projectiles, and collisions for both player instances.
 */
public void playersUpdates() {
  switchCD--;
  
  // Update and draw both players regardless of which is active
  p1.update();
  p1.drawPlayer();
  p1.updateProjectiles();
  p1.updateCollisions(enemies);
  
  p2.update();
  p2.drawPlayer();
  p2.updateProjectiles();
  p2.updateCollisions(enemies);
  
  // Pointer 'p' tracks the currently controlled player
  p = currPlayer == 1 ? p1 : p2;
}

/**
 * Handles logic for enemy projectiles, including screen-bounds and player collision.
 */
public void updateEnemyProjectiles() {
    for (int i = enemyProjs.size() - 1; i >= 0; i--) {
      enemyProjs.get(i).update();
      enemyProjs.get(i).drawProj();
      
      // Collision detection with the active player
      if (enemyProjs.get(i).checkCollision(p.getX(), p.getY(), p.getWide(), p.getHigh())) {
        if (immuneCD <= 0) {
            playerHP -= 1;
            immuneCD = 60; // 1 second of IFrames at 60fps
        }
        enemyProjs.remove(i);
        continue;
      }
      
      // Off-screen cleanup
      if (enemyProjs.get(i).getX() < -50 || enemyProjs.get(i).getX() > width + 50) {
        enemyProjs.remove(i);
      }
    }
}
  
/**
 * Updates enemy logic, handles enemy shooting, and removes dead enemies.
 */
public void updateEnemies() {
  for (int i = enemies.size() - 1; i >= 0; i--) {
    enemies.get(i).update();
    enemies.get(i).drawEnemy();
    
    // Attempt to fire a projectile
    EnemyProj en = enemies.get(i).shootProj(new EnemyProj(enemies.get(i).getX(), enemies.get(i).getY(), 10, 10, 180, 5));
    if (en != null) {
      enemyProjs.add(en);
    }
    
    // Death check
    if (enemies.get(i).getHP() < 0) {
      enemies.remove(i);
    }
  }
}

/**
 * Reads input flags to modify player coordinates and state.
 */
void updatePlayerMovement() {
  immuneCD--;
  
  // Directional Movement
  if (upKey)    p.changeY(-1);
  if (downKey)  p.changeY(1);
  if (leftKey)  p.changeX(-1);
  if (rightKey) p.changeX(1);
  
  // Combat Actions
  if (shootKey) p.shootProj();
  if (superKey) p.shootSuper();
  
  // Swap Character Logic
  if (switchKey && switchCD <= 0) {
    currPlayer = (currPlayer == 1) ? 2 : 1;
    switchCD = maxSwitchCD;
    immuneCD = 30; // Brief invincibility window on switch
  }
}

/**
 * Standard Processing input handler for key presses.
 */
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP)    upKey = true;
    if (keyCode == DOWN)  downKey = true;
    if (keyCode == LEFT)  leftKey = true;
    if (keyCode == RIGHT) rightKey = true;
  }
  if (key == 'a' || key == 'A') shootKey = true;
  if (key == 's' || key == 'S') superKey = true;
  if (key == 'z' || key == 'Z') switchKey = true;
  
  // Debug/Special Beam functionality
  if (key == 'b' || key == 'B') {
    p1.addBeam(new Beam(p1.getX(), p1.getY(), 20, 15));
  }
}

/**
 * Standard Processing input handler for key releases.
 */
void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP)    upKey = false;
    if (keyCode == DOWN)  downKey = false;
    if (keyCode == LEFT)  leftKey = false;
    if (keyCode == RIGHT) rightKey = false;
  }
  if (key == 'a' || key == 'A') shootKey = false;
  if (key == 'z' || key == 'Z') switchKey = false;
  if (key == 's' || key == 'S') superKey = false;
}

/**
 * Handles mouse clicks for UI interaction based on button purpose.
 */
void mousePressed() {
  for (int i = buttons.size() - 1; i >= 0; i--) {
    if (buttons.get(i).checkCollision()) {
      int purpose = buttons.get(i).getPurpose();
      
      if (purpose == 1) {
        // Scene Navigation
        currentScene = buttons.get(i).getNext();
        rewriteScene();
      } else if (purpose == 2) {
        // Selecting a character ID
        playerSelectChange(buttons.get(i).getNext());
      } else if (purpose == 3) {
        // Deselecting Player 1
        p1Select = 0;
        playerPicturesChange();
      } else if (purpose == 4) {
        // Deselecting Player 2
        p2Select = 0;
        playerPicturesChange();
      }
      break; // Only trigger one button per click
    }
  }
}
