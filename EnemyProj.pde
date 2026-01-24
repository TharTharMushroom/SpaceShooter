/**
 * Represents a projectile fired by an enemy.
 * Handles trigonometric movement based on angles and collision detection with the player.
 */
class EnemyProj {
  float x;
  float y;
  float wide;
  float high;
  float xVel;
  float yVel;
  float speed;
  float angle;

  /**
   * Constructor for EnemyProj.
   * @param x Starting x-coordinate.
   * @param y Starting y-coordinate.
   * @param wide Width of the projectile.
   * @param high Height of the projectile.
   * @param angle Direction of travel in degrees (converted to radians internally).
   * @param speed Total pixels moved per frame.
   */
  public EnemyProj(float x, float y, float wide, float high, float angle, float speed) {
    this.x = x;
    this.y = y;
    this.wide = wide;
    this.high = high;
    // Processing's sin() and cos() require radians
    this.angle = radians(angle);
    this.speed = speed;
  }

  /**
   * Renders the projectile as a rectangle.
   */
  public void drawProj() {
    rect(x, y, wide, high);
  }

  /**
   * Updates the projectile's position based on its angle and speed.
   */
  public void update() {
    /* * Calculate velocity components using trigonometry:
     * x component = cosine(angle) * hypotenuse (speed)
     * y component = sine(angle) * hypotenuse (speed)
     */
    xVel = cos(angle) * speed;
    yVel = sin(angle) * speed;
    
    x += xVel;
    y += yVel;
  }

  /** @return Current x-coordinate. */
  public float getX() {
    return x;
  }

  /** @return Current y-coordinate. */
  public float getY() {
    return y;
  }

  /**
   * Checks for a collision between this projectile and a rectangular target (usually the player).
   * Uses AABB (Axis-Aligned Bounding Box) logic assuming rectMode(CENTER).
   * * @param checkX Center x of the target.
   * @param checkY Center y of the target.
   * @param checkWide Width of the target.
   * @param checkHigh Height of the target.
   * @return True if the boxes overlap.
   */
  public boolean checkCollision(float checkX, float checkY, float checkWide, float checkHigh) {
    /*
     * We check if the edges of this projectile overlap the edges of the target.
     * Logic: (RightEdgeA > LeftEdgeB) AND (LeftEdgeA < RightEdgeB) AND 
     * (BottomEdgeA > TopEdgeB) AND (TopEdgeA < BottomEdgeB)
     */
    if (x + wide/2 > checkX - checkWide/2 && 
        x - wide/2 < checkX + checkWide/2 && 
        y + high/2 > checkY - checkHigh/2 && 
        y - high/2 < checkY + checkHigh/2) {
      return true;
    } else {
      return false;
    }
  }
}
