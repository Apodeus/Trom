
int scale = 10; //The bike will move scale by scale,
Bike p1;
Bike p2;

PVector up = new PVector(0, -1);
PVector down = new PVector(0, 1);
PVector right = new PVector(1, 0);
PVector left = new PVector(-1, 0);

void setup() {
  size(1200, 800);
  p1 = new Bike(0            , height/2, right, color(223, 116, 12)  );
  p2 = new Bike(width - scale, height/2,  left, color(111, 195, 223) );
  frameRate(20); //modify the value the speed up or slow the game update frequency
}

// WASD or ZQSD for Player1 
//Arrow keys    for Player 2
void keyPressed() {
  //----------- p1 -----------------
  if (key == 'Z' || key == 'z')
    p1.changeDir(up);

  else if (key == 'S' || key == 's')
    p1.changeDir(down);

  else if (key == 'D' || key == 'd')
    p1.changeDir(right);

  else if (key == 'Q' || key == 'q')
    p1.changeDir(left);

  // ------ p2 -----------
  if (keyCode == DOWN)
    p2.changeDir(down);

  else if (keyCode == UP)
    p2.changeDir(up);

  else if (keyCode == RIGHT)
    p2.changeDir(right);

  else if (keyCode == LEFT)
    p2.changeDir(left);
}

void draw() {
  background(0);
  if (gameOver())
    noLoop();

  p1.show();
  p2.show();
  p1.update();
  p2.update();
}

//Return True if the game is over.
boolean gameOver() {
  boolean loose_p1 = false;
  boolean loose_p2 = false;
  
  //Check if the bikes hit themselves directly
  if (p2.pos.x == p1.pos.x && p2.pos.y == p1.pos.y) {
    loose_p1 = true;
    loose_p2 = true;
  }
  //Check if the bikes hit the wall of player 1
  for (PVector t : p1.run) {
    if (p2.pos.x == t.x && p2.pos.y == t.y)
      loose_p2 = true;

    if (p1.pos.x == t.x && p1.pos.y == t.y)
      loose_p1 = true;
  }
  //Check if the bikes hit the wall of player 2
  for (PVector t : p2.run) {
    if (p1.pos.x == t.x && p1.pos.y == t.y)
      loose_p1 = true;

    if (p2.pos.x == t.x && p2.pos.y == t.y)
      loose_p2 = true;
  }

  //Print the result
  if (loose_p2 && loose_p1)
    println("DRAW");
  else if (loose_p2)
    println("P1 WIN");
  else if (loose_p1)
    println("P2 WIN");
  
  return loose_p1 || loose_p2;
}