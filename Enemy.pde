/**
 * Base class for all enemy types. 
 * Handles movement physics, health tracking, and projectile timing.
 */
class Enemy {
  float x;
  float y;
  float xVel = 0;
  float yVel = 0;
  float xVelChange = 0;
  float yVelChange = 0;
  float wide;
  float high;
  int hp;
  int shootCooldown;
  int totalShootCooldown;
  float friction = 0.96;

  /**
   * Constructor for the Enemy base class.
   * @param x Initial x-coordinate.
   * @param y Initial y-coordinate.
   * @param wide Width of the enemy hitbox/sprite.
   * @param high Height of the enemy hitbox/sprite.
   * @param hp Initial health points.
   * @param totalShootCooldown The number of frames between shots.
   */
  public Enemy(float x, float y, float wide, float high, int hp, int totalShootCooldown) {
    this.x = x;
    this.y = y;
    this.wide = wide;
    this.high = high;
    this.hp = hp;
    this.totalShootCooldown = totalShootCooldown;
    this.shootCooldown = totalShootCooldown;
  }

  /**
   * Renders the enemy to the screen using a rectangle.
   */
  public void drawEnemy() {
    rect(x, y, wide, high);
  }

  /**
   * Hook method called when the enemy's HP reaches zero.
   * Can be overridden by subclasses for specific death effects.
   */
  public void onDefeat() {
    // Logic for loot drops or explosions can be added here
  }

  /**
   * Evaluates if the enemy is ready to fire based on the cooldown timer.
   * @param proj The projectile object to be returned if firing is successful.
   * @return The projectile object if cooldown is ready; null otherwise.
   */
  public EnemyProj shootProj(EnemyProj proj) {
    if (shootCooldown <= 0) {
      shootCooldown = totalShootCooldown; // Reset the timer
      return proj;
    } else {
      return null;
    }
  }

  /**
   * Basic physics update involving velocity, acceleration (change), and friction.
   */
  public void update() {
    shootCooldown -= 1;
    
    // Apply acceleration to velocity
    xVel += xVelChange;
    yVel += yVelChange;
    
    // Apply air resistance/friction to dampen movement
    xVel *= friction;
    yVel *= friction;
    
    // Update position based on final velocity
    x += xVel;
    y += yVel;
  }

  /**
   * Reduces the enemy's health.
   * @param dmg The amount of damage to subtract from current HP.
   */
  public void changeHP(int dmg) {
    hp -= dmg;
  }

  public int getHP() { return hp; }
  public float getX() { return x; }
  public float getY() { return y; }
  public float getWide() { return wide; }
  public float getHigh() { return high; }
}

/**
 * A simple implementation of an Enemy that moves vertically in a "bounce" pattern.
 */
class BasicEnemy extends Enemy {

  /**
   * Constructor for BasicEnemy.
   * Sets default size, health, and fire rate.
   */
  BasicEnemy(int x, int y) {
    super(x, y, 60, 60, 120, 50);
    yVelChange = 0.2; // Start with a downward acceleration
  }

  /**
   * Overridden update method to include screen-boundary logic for vertical movement.
   */
  @Override
  public void update() {
    // Standard physics updates
    shootCooldown -= 1;
    xVel += xVelChange;
    yVel += yVelChange;
    xVel *= friction;
    yVel *= friction;
    x += xVel;
    y += yVel;
    
    // Boundary Check: If the enemy hits the top/bottom "buffer," reverse its acceleration
    if (y < 50) {
      yVelChange = 0.2; // Accelerate downwards
    } else if (y > height - 50) {
      yVelChange = -0.2; // Accelerate upwards
    }
  }
}
