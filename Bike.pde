class Bike {
  PVector pos; //current position of the player
  ArrayList<PVector> run; //All position visited by the player
  PVector speed; //A vector of speed and direction
  color color_bike; //Color of the Bike
  color color_run; // Color of the position already visited
  int score = 0;

  Bike(float x, float y, PVector dir, color c_) {
    speed = dir.copy();
    pos = new PVector(x, y);
    color_bike = c_;
    color_run = color(red(c_) * 1.2, green(c_) * 1.2, blue(c_) * 1.2);
    run = new ArrayList<PVector>();
  }

  void show() {
    fill(color_run);
    noStroke();
    for (PVector v : run) {
      rect(v.x, v.y, scale, scale);
    }
    fill(color_bike);
    stroke(0);
    ellipse(pos.x + scale/2, pos.y + scale/2, scale, scale);
  }

  void update() {
    if (!isGameOver) {
      run.add(new PVector(pos.x, pos.y));
      pos.x += speed.x * scale;
      pos.y += speed.y * scale;
      pos.x = constrain(pos.x, 0, width - scale);
      pos.y = constrain(pos.y, 0, height - scale);
    }
  }

  void changeDir(PVector p) {
    if (p.x != (-1 * speed.x) && p.y != (-1 * speed.y)) {
      speed.x = p.x;
      speed.y = p.y;
      //update();
    }
  }
}