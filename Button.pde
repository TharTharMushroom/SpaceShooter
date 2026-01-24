/**
 * Represents a functional UI button used for scene navigation and character selection.
 */
class Button {
  float x;
  float y;
  float high;
  float wide;
  int next;
  int purpose;
  color c;
  String text;

  /**
   * Constructor for creating a new Button.
   * @param x The center x-coordinate.
   * @param y The center y-coordinate.
   * @param wide The width of the button.
   * @param high The height of the button.
   * @param next The value to pass (e.g., scene ID or character ID) when clicked.
   * @param purpose The functional category of the button (0: none, 1: scene, 2: select, 3: p1, 4: p2).
   * @param c The fill color of the button.
   * @param text The label displayed on the button.
   */
  public Button(float x, float y, float wide, float high, int next, int purpose, color c, String text) {
    this.x = x;
    this.y = y;
    this.wide = wide;
    this.high = high;
    this.next = next;
    this.purpose = purpose;
    this.c = c;
    this.text = text;
  }

  /**
   * Renders the button and its text label to the screen.
   */
  public void drawButton() {
    fill(c);
    rect(x, y, wide, high);
    fill(255);
    // Offset text by 8 pixels on the y-axis to visually center it vertically
    text(text, x, y + 8);
  }

  /**
   * Gets the functional purpose of the button.
   * @return An integer representing the button's role.
   */
  public int getPurpose() {
    return purpose;
  }

  /**
   * Gets the destination scene or character ID associated with this button.
   * @return The next ID value.
   */
  public int getNext() {
    return next;
  }

  /**
   * Updates the button's fill color.
   * @param col The new color to apply.
   */
  public void colorChange(color col) {
    c = col;
  }

  /**
   * Checks if the mouse cursor is currently hovering over the button's area.
   * @return True if the mouse is within the button bounds.
   */
  public boolean checkCollision() {
    /* * Since rectMode(CENTER) is used in setup(), 
     * the edges are calculated as: center +/- (dimension / 2).
     */
    if (x + wide/2 > mouseX && x - wide/2 < mouseX && 
        y + high/2 > mouseY && y - high/2 < mouseY) {
      return true;
    } else {
      return false;
    }
  }
}
