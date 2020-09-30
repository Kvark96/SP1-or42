/**
 * Array 2D. 
 * 
 * Demonstrates the syntax for creating a two-dimensional (2D) array.
 * Values in a 2D array are accessed through two index values.  
 * 2D arrays are useful for storing images. In this example, each dot 
 * is colored in relation to its distance from the center of the image. 
 */

import java.util.Random;

Game game = new Game(25, 25, 5, 5);
PFont font;

public void settings() {
  size(1001, 1001);
}

void setup()
{
  frameRate(10);
  font = createFont("Arial", 16, true);
  textFont(font, 16);
}

void keyReleased()
{
  if (key == CODED) {
    game.onKeyReleased(keyCode);
  } else {
    game.onKeyReleased(Character.getNumericValue(key));
  }
}

void keyPressed()
{
  if (key == CODED){
    game.onKeyPressed(keyCode);
  } else {
  game.onKeyPressed(Character.getNumericValue(key));
  }
}

void draw() {
  if (!game.isGameOver())
  {
    game.update();
  }
  background(0); //Black
  // This embedded loop skips over values in the arrays based on
  // the spacer variable, so there are more values in the array
  // than are drawn here. Change the value of the spacer variable
  // to change the density of the points
  int[][] board = game.getBoard();
  for (int y = 0; y < game.getHeight(); y++)
  {
    for (int x = 0; x < game.getWidth(); x++)
    {
      if (board[x][y] == 0)
      {
        fill(0, 0, 0);
      } else if (board[x][y] == 1)
      {
        fill(0, 0, 255);
      } else if (board[x][y] == 2)
      {
        fill(255, 0, 0);
      } else if (board[x][y] == 3)
      {
        fill(0, 255, 0);
      } else if (board[x][y] == 4)
      {
        fill(0, 255, 255);
      }
      stroke(100, 100, 100);
      rect(x*40, y*40, 40, 40);
    }
  }
  fill(255);
  text("Player 1 life: "+game.getPlayerLife("P1"), 25, 25);
  text("Player 2 life: "+game.getPlayerLife("P2"), width-135, 25);
  if (game.isGameOver()) {      // If the game is over, it will check whether player1 has more than 0 life, thus determining the victor.
    textAlign(CENTER, CENTER);
    textSize(36);
    stroke(230);
    strokeWeight(6);
    if (game.getPlayerLife("P1") > 0) {
      fill(0, 0, 255);
      rect(0, 0, width, height);
      fill(0);
      text("PLAYER 1 WINS", width / 2, height / 2);
    } else {
      fill(0, 255, 255);
      rect(0, 0, width, height);
      fill(0);
      text("PLAYER 2 WINS", width / 2, height / 2);
    }
  }
}


/*
  DONE : Der skal tilføjes mad som er grønt. Maden er levende og skal bevæge sig rundt ligesome fjenderne, men i stedet for at løbe mod spillere, skal de løbe væk fra dem.
 DONE : Hver gang du rammer et felt med mad på får du mere liv (playerLife) - dog aldrig mere end max (lav en variable til dette). Herefter forsvinder maden.
 Du skal lave endnu en spiller som er en anden farve end den første, men ikke samme som fjender og mad. Den nye spiller skal styres med piletasterne.
 Når en spiller har mindre end 1 playerLife tilbage, forsvinder den. Den sidste spiller der er tilbage vinder spillet.
 
 Aflevering: 
 Upload jeres færdige projekt til github og aflevér linket på moodle inden torsdag den 1. Okt. kl 18.00.
 
 
 
 
 */
