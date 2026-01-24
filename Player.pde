/**
 * Base class for all playable characters.
 * Handles physics, screen boundaries, projectile/beam management, and collision detection.
 */
class Player {
  float x;
  float y;
  float wide;
  float high;
  float xVel = 0;
  float yVel = 0;
  float friction = 0.9;
  int shootCooldown = 0;
  int superCooldown = 0;
  int totalShootCooldown;
  int totalSuperCooldown;
  ArrayList<Projectile> projs = new ArrayList<Projectile>();
  ArrayList<Beam> beams = new ArrayList<Beam>();

  /**
   * Constructor for the Player base class.
   * @param x Initial x-position.
   * @param y Initial y-position.
   * @param wide Width of the player hitbox.
   * @param high Height of the player hitbox.
   * @param totalShootCooldown Frames required between standard shots.
   * @param totalSuperCooldown Frames required between super ability uses.
   */
  public Player(float x, float y, float wide, float high, int totalShootCooldown, int totalSuperCooldown) {
    this.x = x;
    this.y = y;
    this.wide = wide;
    this.high = high;
    this.totalShootCooldown = totalShootCooldown;
    this.totalSuperCooldown = totalSuperCooldown;
  }

  /**
   * Renders the player as a simple rectangle.
   */
  public void drawPlayer() {
    rect(x, y, wide, high);
  }

  /**
   * Updates cooldowns and movement physics.
   */
  public void update() {
    shootCooldown -= 1;
    superCooldown -= 1;
    
    // Apply friction to dampen velocity over time
    xVel *= friction;
    yVel *= friction;
    
    x += xVel;
    y += yVel;
    
    stayInScreen();
  }

  /**
   * Spawns a basic projectile if the cooldown is ready.
   */
  public void shootProj() {
    if (shootCooldown <= 0) {
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, 0, 8, 10));
      shootCooldown = totalShootCooldown;
    }
  }

  /**
   * Spawns a high-damage super projectile if the cooldown is ready.
   */
  public void shootSuper() {
    if (superCooldown <= 0) {
      projs.add(new Projectile(p.getX(), p.getY(), 50, 50, 0, 10, 45));
      superCooldown = totalSuperCooldown;
    }
  }

  /**
   * Constrains the player coordinates to the visible screen area.
   */
  public void stayInScreen() {
    // Check against left and right edges
    if (x < wide/2) x = wide/2;
    if (x > width - wide/2) x = width - wide/2;
    
    // Check against top and bottom edges
    if (y < high/2) y = high/2;
    if (y > height - high/2) y = height - high/2;
  }

  public float getX() { return x; }
  public float getY() { return y; }
  public float getWide() { return wide; }
  public float getHigh() { return high; }
  public int getShootCD() { return shootCooldown; }

  public void changeX(float change) { xVel += change; }
  public void changeY(float change) { yVel += change; }
  public void addBeam(Beam beam) { beams.add(beam); }

  /**
   * Nested loop to check all player projectiles against all active enemies.
   * @param enemies List of enemies to check for collisions.
   */
  public void updateCollisions(ArrayList<Enemy> enemies) {
    for (int i = projs.size() - 1; i >= 0; i--) {
      for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy ene = enemies.get(j);
        // If projectile hits enemy, apply damage and remove projectile
        if (projs.get(i).checkCollision(ene.getX(), ene.getY(), ene.getWide(), ene.getHigh())) {
          enemies.get(j).changeHP(projs.get(i).getDamage());
          projs.remove(i);
          break; // Projectile is gone; stop checking other enemies for this one
        }
      }
    }
  }

  /**
   * Moves and draws projectiles; removes them if they travel too far off-screen.
   */
  public void updateProjectiles() {
    for (int i = projs.size() - 1; i >= 0; i--) {
      projs.get(i).update();
      projs.get(i).drawProj();
      if (projs.get(i).getX() < -50 || projs.get(i).getX() > width + 50) {
        projs.remove(i);
      }
    }
  }

  /**
   * Handles beam logic, temporarily switching rectMode to facilitate beam origin drawing.
   */
  public void updateBeams() {
    rectMode(CORNER); // Beams often grow from a specific point
    for (int i = beams.size() - 1; i >= 0; i--) {
      beams.get(i).update(getX(), getY());
      beams.get(i).drawBeam();
      if (beams.get(i).beamDur() < 0) {
        beams.remove(i);
      }
    }
    rectMode(CENTER); // Revert to center mode for other game objects
  }
}

// --- SUBCLASSES ---

/**
 * Red Character: Specializes in spread shots (Triple shot basic, 5-shot super).
 */
class Red extends Player {
  Red() {
    super(10, 10, 40, 40, 15, 200);
  }

  @Override
  public void drawPlayer() {
    fill(255, 0, 0);
    rect(x, y, wide, high);
    fill(255);
  }

  @Override
  public void shootProj() {
    if (shootCooldown <= 0) {
      // Fires three projectiles at different angles
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, -20, 6, 4));
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, 0, 6, 4));
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, 20, 6, 4));
      shootCooldown = totalShootCooldown;
    }
  }

  @Override
  public void shootSuper() {
    if (superCooldown <= 0) {
      // Fires a wide fan of 5 high-damage projectiles
      for (int i = -40; i <= 40; i += 20) {
        projs.add(new Projectile(p.getX(), p.getY(), 30, 30, i, 9, 10));
      }
      superCooldown = totalSuperCooldown;
    }
  }
}

/**
 * Blue Character: Balanced stats with standard single-shot and large super.
 */
class Blue extends Player {
  Blue() {
    super(10, 10, 40, 40, 8, 200);
  }

  @Override
  public void drawPlayer() {
    fill(0, 0, 255);
    rect(x, y, wide, high);
    fill(255);
  }

  @Override
  public void shootProj() {
    if (shootCooldown <= 0) {
      projs.add(new Projectile(p.getX(), p.getY(), 10, 10, 0, 8, 10));
      shootCooldown = totalShootCooldown;
    }
  }

  @Override
  public void shootSuper() {
    if (superCooldown <= 0) {
      projs.add(new Projectile(p.getX(), p.getY(), 50, 50, 0, 10, 45));
      superCooldown = totalSuperCooldown;
    }
  }
}

/**
 * Green Character: High fire rate with a "Super" that grants enhanced ammo temporary buffs.
 */
class Green extends Player {
  int enhancedAmmo = 0;

  Green() {
    super(10, 10, 40, 40, 5, 150);
  }

  @Override
  public void drawPlayer() {
    fill(0, 255, 0);
    rect(x, y, wide, high);
    fill(255);
  }

  @Override
  public void shootProj() {
    if (shootCooldown <= 0) {
      // Logic for switching between standard shots and enhanced super-ammo shots
      if (enhancedAmmo > 0) {
        enhancedAmmo--;
        projs.add(new Projectile(p.getX(), p.getY(), 25, 25, random(-5, 5), 9, 10));
      } else {
        projs.add(new Projectile(p.getX(), p.getY(), 10, 10, random(-10, 10), 7, 5));
      }
      shootCooldown = totalShootCooldown;
    }
  }

  @Override
  public void shootSuper() {
    if (superCooldown <= 0) {
      enhancedAmmo = 10; // Replenishes special ammo instead of firing a single shot
      superCooldown = totalSuperCooldown;
    }
  }
}

/**
 * Yellow Character: Slow fire rate but extremely high damage and large projectiles.
 */
class Yellow extends Player {
  Yellow() {
    super(10, 10, 40, 40, 30, 250);
  }

  @Override
  public void drawPlayer() {
    fill(255, 255, 0);
    rect(x, y, wide, high);
    fill(255);
  }

  @Override
  public void shootProj() {
    if (shootCooldown <= 0) {
      projs.add(new Projectile(p.getX(), p.getY(), 30, 30, 0, 8, 30));
      shootCooldown = totalShootCooldown;
    }
  }

  @Override
  public void shootSuper() {
    if (superCooldown <= 0) {
      // Fires a massive projectile with very high damage
      projs.add(new Projectile(p.getX(), p.getY(), 100, 100, 0, 4, 150));
      superCooldown = totalSuperCooldown;
    }
  }
}
