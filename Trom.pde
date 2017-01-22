
int scale = 10; //The bike will move scale by scale,
Bike p1;
Bike p2;

boolean isGameOver = false;
boolean loose_p1 = false;
boolean loose_p2 = false;

PVector up = new PVector(0, -1);
PVector down = new PVector(0, 1);
PVector right = new PVector(1, 0);
PVector left = new PVector(-1, 0);

void setup() {
  size(1200, 800);
  p1 = new Bike(0, height/2, right, color(223, 116, 12)  );
  p2 = new Bike(width - scale, height/2, left, color(111, 195, 223) );
  frameRate(20); //modify the value the speed up or slow the game update frequency
  textSize(32);
}

// WASD or ZQSD for Player1 
//Arrow keys    for Player 2
void keyPressed() {
  //----------- p1 -----------------
  if (!isGameOver) {
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

  if (key == 'R' || key == 'r') {
    p1.pos = new PVector(0, height/2) ;
    p2.pos = new PVector(width - scale, height/2);
    p1.speed = right.copy();
    p2.speed = left.copy();
    p1.run = new ArrayList<PVector>();
    p2.run = new ArrayList<PVector>();
    isGameOver = false;
    loose_p1 = false;
    loose_p2 = false;
  }
  if (key == 'x' || key == 'X') {
    noLoop();
  }
}

void draw() {
  background(0);

  p1.show();
  p2.show();

  p1.update();
  p2.update();
  if (!isGameOver) {
    if (gameOver())
    {
      println(isGameOver);
      isGameOver = true;
    }
  } else {
    displayScore();
  }
}

//Return True if the game is over.
boolean gameOver() {
  //Check if the bikes hit themselves directly
  if (p1.pos.x == p2.pos.x && p1.pos.y == p2.pos.y) {
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
    text("DRAW !", width / 2, height / 3);
  else if (loose_p2) {
    fill(223, 116, 12);
    text("P1 WIN !", width / 2, height / 3);
    p1.score += 1;
  } else if (loose_p1) {
    fill(111, 195, 223);
    text("P2 WIN !", width / 2, height / 3);
    p2.score += 1;
  }
  return loose_p1 || loose_p2;
}

void displayScore() {
  text(p1.score, width / 4, height / 2);
  text(p2.score, 3 * width / 4, height/2);
  
  if (loose_p2 && loose_p1)
    text(" DRAW ", (width / 2) - (32 * 2) + 5, height / 3);
  else if (loose_p2) {
    fill(223, 116, 12);
    text("P1 WIN", width / 2 - (32 * 2) + 5, height / 3);
  } else if (loose_p1) {
    fill(111, 195, 223);
    text("P2 WIN", width / 2 - (32 * 2) + 5, height / 3);
  }
}