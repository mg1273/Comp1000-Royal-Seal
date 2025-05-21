float x;
float y;
float dx;
float dy;
float currentRoom;
boolean crowned = false;
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

ArrayList<canGarbage> cansArray = new ArrayList<canGarbage>();
ArrayList<fishGuy> fishArray = new ArrayList<fishGuy>();

int sealDir = -1;

//----------------------------------------------------------------------------------------

void setup()
{
  size(800, 600);
  frameRate(120);
}

//----------------------------------------------------------------------------------------

void draw()
{
  beachBG();



  if (currentRoom == 1) { // fishing room
    pond();
    displayItems();
  }

  if (currentRoom == -2) // room to the left
  {
    inKingdom();
  }

  if (sealDir == -1) { // looking left
    drawSeal();
  } else if (sealDir == 1) { // looking right
    flippedSeal();
  }

  if (isJumping) { // whiles its in the air apply velocity and gravity
    gJump();
  }



  boundary(); //changes the room

  if (currentRoom == -1) // room to the left
  {
    kingdomBG();
  }

  if (inGame == true) // while in game show the fishing bar
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
  ellipse(475 + x, 400, 300, 150); //body
  ellipse(410 + x, 390, 180, 160); //head

  fill(0, 0, 0); // eyes
  circle(373 + x, 392, 15);
  circle(440 + x, 392, 15);


  fill(255, 255, 255);// mouth and nose
  arc(390 + x, 399, 35, 35, 0, 2);
  arc(425 + x, 399, 35, 35, 1, 3);
  fill(0, 0, 0);
  ellipse(407 + x, 399, 18, 10); // nose


  fill(255, 255, 255); // eye shine
  circle(375 + x, 390, 5);
  circle(442 + x, 390, 5);

  //crown
  if (crowned) {
    fill(212, 175, 55);
    ellipse(410+x, 324, 100, 20);
    rect(360+x, 324, 100, -20);
    ellipse(410+x, 324, 100, 20);
    noStroke();
    rect(361+x, 324, 99, -20);// clears the line to make it 3d cooler
    stroke(0);
    ellipse(410+x, 304, 100, 20);
    triangle(436+x, 311, 450+x, 268, 460+x, 304);
    triangle(392+x, 312, 411+x, 276, 423+x, 313);
    triangle(380+x, 310, 375+x, 265, 361+x, 304);
  }

  popMatrix();
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

  if (currentRoom == -1 && x <= -55 && !crowned) // if at castle and at door and not crowned
  {
    x = -55; //blocks from going in
    fill(0);
    textSize(30);
    text("the seal isn't very royal yet", width/2+20, height/3);
  }

  if (x > 320 && currentRoom == 1)
  {
    x = 320;
  }

  if (x < -320 && currentRoom == -2)
  {
    x = -320;
  }
}

//----------------------------------------------------------------------------------------

void beachBG()
{
  //beach and sky background
  background(0, 255, 255); // cyan for sky
  noStroke();
  fill(194, 178, 128); // Sky colour
  rect(0, 400, width, height); // sand
  stroke(0);
  fill(0);
  if (currentRoom == 0) {
    fill(0);
    textSize(20);
    text("Hold A to move Left, D to move Right, Space to Jump. (if not working turn off caps)", 20, 20);
    text("Go off screen to see other areas!", 20, 50);
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

  fill(0);
  textSize(20);
  text("Press E to start fishing! Space to reel in.", 20, 20);
  text("", 20, 50);

  if (inGame) {
    line(534, 237, 573, 487);
  }
}

//----------------------------------------------------------------------------------------

void inKingdom() {
  background(112, 128, 144);
  noStroke();
  fill(139, 0, 0); // Sky colour
  rect(0, 400, width, height); // sand
  stroke(0);
  fill(255);
  textSize(70);
  text("You win!", width/2-70, height/3);
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

  if (crowned) {
    fill(212, 175, 55);
    ellipse(410-x, 324, 100, 20);
    rect(360-x, 324, 100, -20);
    ellipse(410-x, 324, 100, 20);
    noStroke();
    rect(361-x, 324, 99, -20);// clears the line to make it 3d cooler
    stroke(0);
    ellipse(410-x, 304, 100, 20);
    triangle(436-x, 311, 450-x, 268, 460-x, 304);
    triangle(392-x, 312, 411-x, 276, 423-x, 313);
    triangle(380-x, 310, 375-x, 265, 361-x, 304);
  }

  popMatrix();
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

void displayItems() {
  for (int i = 0; i < cansArray.size(); i++) {
    cansArray.get(i).display();
  }

  for (int i = 0; i < fishArray.size(); i++) {
    fishArray.get(i).display();
  }
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
    println(x);
  }


  if (key == 'e' && inGame == false && currentRoom == 1) {
    rectSpot = random(50, 500);
    inGame = true;
  } else if (key == ' ' && inGame == true) {
    inGame = false;


    if (barMove >= rectSpot && barMove <= rectSpot + rectSize) {
      println("caught!");
      int whichItem = int(random(0, 4));
      print(whichItem);

      if (whichItem == 1) { // instantiate can
        println(" can added");
        cansArray.add(new canGarbage(random(0, width), random(375, height)));
      } else if (whichItem == 2) { // instantiate fish
        println(" fish added");
        fishArray.add(new fishGuy(random(0, width), random(375, height)));
      } else if (whichItem == 3) { // instantiate fish
        println(" crowned!");
        crowned = true;
      }
    }
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
