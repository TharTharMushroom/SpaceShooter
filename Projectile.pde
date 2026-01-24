/**
 * Represents a projectile fired by the player.
 * Uses trigonometric movement and AABB collision detection to interact with enemies.
 */
class Projectile {
  float x;
  float y;
  float wide;
  float high;
  float xVel;
  float yVel;
  float speed;
  float angle;
  int damage;

  /**
   * Constructor for Projectile.
   * @param x Starting x-coordinate.
   * @param y Starting y-coordinate.
   * @param wide Width of the projectile hitbox.
   * @param high Height of the projectile hitbox.
   * @param angle Direction in degrees (converted to radians internally).
   * @param speed Pixels moved per frame.
   * @param damage Health reduction applied to enemies on impact.
   */
  public Projectile(float x, float y, float wide, float high, float angle, float speed, int damage) {
    this.x = x;
    this.y = y;
    this.wide = wide;
    this.high = high;
    // Processing trig functions (sin/cos) require radian input
    this.angle = radians(angle);
    this.speed = speed;
    this.damage = damage;
  }

  /**
   * Renders the projectile to the canvas.
   */
  public void drawProj() {
    rect(x, y, wide, high);
  }

  /**
   * Updates position based on current angle and speed.
   */
  public void update() {
    // Convert polar coordinates (angle/speed) to Cartesian velocity (x/y)
    xVel = cos(angle) * speed;
    yVel = sin(angle) * speed;
    x += xVel;
    y += yVel;
  }

  /** @return Damage value of this projectile. */
  public int getDamage() {
    return damage;
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
   * Checks for intersection between this projectile and a target rectangle.
   * Assumes rectMode(CENTER) for both objects.
   * * @param checkX Center x of the target.
   * @param checkY Center y of the target.
   * @param checkWide Width of the target.
   * @param checkHigh Height of the target.
   * @return True if the projectile overlaps the target area.
   */
  public boolean checkCollision(float checkX, float checkY, float checkWide, float checkHigh) {
    // Standard AABB (Axis-Aligned Bounding Box) collision check
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
