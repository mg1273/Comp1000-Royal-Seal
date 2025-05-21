float x;
float y;
float dx;
float dy;
float currentRoom;
float crowned;
boolean inGame = false;

float barMove = 50;
float barDirection = 10;
float rectSize = 200;
float rectSpot;

float yVelocity = 10;
float gravity = 0.25;
float why = 0;
float jumpPower;
boolean isJumping = false;

int sealDir = -1;

//----------------------------------------------------------------------------------------

void setup()
{
  size(800, 600);
  frameRate(60);
}

//----------------------------------------------------------------------------------------

void draw()
{
  beachBG();
  
    if (currentRoom == 1) {
    pond();
  }

  if (sealDir == -1) {
    drawSeal();
  } else if (sealDir == 1) {
    flippedSeal();
  }
  
  if (isJumping) {
    gJump();
  }



  boundary();

  if (currentRoom == -1)
  {
    kingdomBG();
  }

  if (inGame == true)
  {
    fishingGame();
  }
  
  
  
}

//----------------------------------------------------------------------------------------

void drawSeal()
{
  pushMatrix();
  translate(0, why);
  fill(255, 255, 255); //arms
  triangle(342 + x, 430, 322 + x, 473, 381 + x, 457);
  triangle(452 + x, 470, 510 + x, 460, 512 + x, 493);
  triangle(597 + x, 373, 629 + x, 346, 617.0 + x, 391.0);
  triangle(607 + x, 372, 644 + x, 365, 609 + x, 400);

  //body and head
  ellipse(475 + x, 400, 300, 150);
  ellipse(410 + x, 390, 180, 160);

  fill(0, 0, 0); // eyes
  circle(373 + x, 392, 15);
  circle(440 + x, 392, 15);

  ellipse(407 + x, 399, 18, 10); // mouth and nose
  fill(255, 255, 255);
  arc(390 + x, 399, 35, 35, 0, 2);
  arc(425 + x, 399, 35, 35, 1, 3);
  fill(0, 0, 0);
  ellipse(407 + x, 399, 18, 10);

  fill(255, 255, 255); // eye shine
  circle(375 + x, 390, 5);
  circle(442 + x, 390, 5);
  popMatrix();

  if (x < -300) {
    dx = -dx;
  } else if (x > 150) {
    dx = -dx;
  }
}

//----------------------------------------------------------------------------------------

void beachBG()
{
  //beach and sky background
  background(0, 255, 255);
  noStroke();
  fill(194, 178, 128);
  rect(0, 400, 800, 600);
  stroke(0);
}

//----------------------------------------------------------------------------------------

void boundary()
{
  if (x < -648)
  {
    x = 648;
    currentRoom = currentRoom - 1;
  }

  if (x > 648)
  {
    x = -648;
    currentRoom = currentRoom + 1;
  }

  if (currentRoom == -1 && x < -55 && crowned == 0) // if at castle and at door and not crowned
  {
    x = -55; //blocks from going in
  }
}

//----------------------------------------------------------------------------------------

void kingdomBG()
{
  fill(210, 209, 205);
  rect(130, 250, -200, 250);
  rect(130, 100, 130, 400);
  fill(130, 73, 11);
  rect(180, 300, 40, 195); //door
  rect(220, 300, 40, 195);
  fill(0, 0, 0);
  textSize(25);
  text("kingdom", 156, 166);
}

//----------------------------------------------------------------------------------------

void pond()
{
  fill(0, 191, 255);
  ellipse(575, 500, 400, 190);

  stroke(139, 69, 19, 255);
  strokeWeight(20);
  line(359, 512, 534, 237);
  strokeWeight(1);
  stroke(0);

  if (inGame) {
    line(534, 237, 573, 487);
  }
}

//----------------------------------------------------------------------------------------

void fishingGame()
{
  //holding bar thing
  fill(128, 128, 128);
  rect(50, 100, 700, 40);


  //catch spot bar thing
  fill(255, 255, 255);
  rect(rectSpot, 100, rectSize, 40);

  //moving bar thing
  rect(barMove, 90, 20, 60);
  barMove = barMove + barDirection;

  if (barMove > 730) {
    barDirection = -10;
  } else if (barMove < 50) {
    barDirection = 10;
  }
}

//----------------------------------------------------------------------------------------

void flippedSeal()
{
  translate(0, why);
  pushMatrix(); // saves positions until popMatrix() / encapsulates the drawings
  translate(width, 0);
  scale(-1, 1);

  fill(255); // arms
  triangle(342 - x, 430, 322 - x, 473, 381 - x, 457);
  triangle(597 - x, 373, 629 - x, 346, 617.0 - x, 391.0);
  triangle(607 - x, 372, 644 - x, 365, 609 - x, 400);

  ellipse(475 - x, 400, 300, 150); // body
  ellipse(410 - x, 390, 180, 160); // head

  fill(0); // eyes
  circle(373 - x, 392, 15);
  circle(440 - x, 392, 15);

  ellipse(407 - x, 399, 18, 10); // mouth
  fill(255);
  arc(390 - x, 399, 35, 35, 0, 2);
  arc(425 - x, 399, 35, 35, 1, 3);
  fill(0);
  ellipse(407 - x, 399, 18, 10);

  fill(255); // eye shine
  circle(375 - x, 390, 5);
  circle(442 - x, 390, 5);

  triangle(460 - x, 470, 510 - x, 460, 512 - x, 493); // put triangle on top

  popMatrix();
}



//---------------------------------------------------------------------------------------- BUILT IN FUNCTIONS

void keyPressed()
{

  if (key == 'a' || key == 'A') {
    dx = -8;
    x = x + dx;
    sealDir = -1;
  } else if (key == 'd' || key == 'D')
  {
    dx = 8;
    x = x + dx;
    sealDir = 1;
  }
  
    if (key == ' ' && inGame == false && isJumping == false) {
        isJumping = true;
        why = 1;
        gJump();
  }


  if (key == 'e' && inGame == false && currentRoom == 1) {
    rectSpot = random(50, 500);
    inGame = true;
  } 
  else if (key == ' ' && inGame == true) {
    inGame = false;

    if (barMove >= rectSpot && barMove <= rectSpot + rectSize) {
      println("caught!");
    }
  }
  
  
  
}
//----------------------------------------------------------------------------------------

void gJump() {
  why = why - yVelocity;
  yVelocity -= gravity;
  
  if (why >= 0) {
     why = 0;
     isJumping = false;
     println("grounded");
     yVelocity = 10;
  }

}

//----------------------------------------------------------------------------------------

void mousePressed()
{
  dx = 0;
  println(x);
}

//----------------------------------------------------------------------------------------

void mouseReleased()
{
  println(mouseX + ", " + mouseY);
}

//----------------------------------------------------------------------------------------
