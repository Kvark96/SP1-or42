import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private Keys2 keys2;
  private int playerLife;
  private int player2Life; // This is a fairly messy way of doing things. Creating Player and Enemy classes that inherit Dot would be easier,
  private Dot player;      // but since you've set the precedent by doing it through Game, I will follow through.
  private Dot player2;
  private Dot[] enemies;
  // Food array and maxLife
  private int lifeFromFood = 10;
  private Dot[] food;
  private int maxLife = 100;
  private boolean gameOver = false;


  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    }
    if (numberOfFood < 0) {
      throw new IllegalArgumentException("There must be food");
    }
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    keys2 = new Keys2();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(width-1, 0, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    // Assigns value to numberOfFood and initiates food array
    this.playerLife = maxLife;
    this.player2Life = maxLife;
    food = new Dot[numberOfFood];
    for (int i = 0; i < numberOfFood; i++) {
      food[i] = new Dot(rnd.nextInt(width), rnd.nextInt(height), width-1, height-1);
    }
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  public int getPlayer2Life() {
    return player2Life;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }
  public void onKeyPressed2(int n) {
    keys2.onKeyPressed(n);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }
  public void onKeyReleased2(int n) {
    keys2.onKeyReleased(n);
  }

  public void update()
  { 
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }
  
  // Can be called to check whether the game is over. The name is self-explanatory.
  public boolean isGameOver(){
    return gameOver;
  }


  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

  private void updatePlayer2()
  {
    //Update player
    if (keys2.upDown() && !keys2.downDown())
    {
      player2.moveUp();
    }
    if (keys2.leftDown() && !keys2.rightDown())
    {
      player2.moveLeft();
    }
    if (keys2.downDown() && !keys2.upDown())
    {
      player2.moveDown();
    }
    if (keys2.rightDown() && !keys2.leftDown())
    {
      player2.moveRight();
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        // NOTE: I have changed this so that it determines which player is closest, and chases them
        //       This does result in a problem where the enemies won't move if both players are (nearly) equally close to them,
        //       but I'm pretty sure this is unavoidable in a simple game like this.
        //       Also, enemies will follow player2 from start, since they are closer when spawning, but this is unimportant.
        int dx = abs(player.getX() - enemies[i].getX()) < abs(player2.getX() - enemies[i].getX()) ? player.getX() - enemies[i].getX() : player2.getX() - enemies[i].getX();
        int dy = abs(player.getY() - enemies[i].getY()) < abs(player2.getY() - enemies[i].getY()) ? player.getY() - enemies[i].getY() : player2.getY() - enemies[i].getY();

        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateFood() {
    for (int i = 0; i < food.length; i++) {
      if (rnd.nextInt(3) < 2) {
        //We follow
        //As before, the food will run from the player closest to them
        //NOTE: dx and dy can be from different players (ie. dy could be closer for player1, while dx is closer for player2)
        int dx = abs(player.getX() - food[i].getX()) < abs(player2.getX() - food[i].getX()) ? player.getX() - food[i].getX() : player2.getX() - food[i].getX();
        int dy = abs(player.getY() - food[i].getY()) < abs(player2.getX() - food[i].getX()) ? player.getY() - food[i].getY() : player2.getX() - food[i].getX();
        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveLeft();
        } else if (move == 1)
        {
          //Move left
          food[i].moveRight();
        } else if (move == 2)
        {
          //Move up
          food[i].moveDown();
        } else if (move == 3)
        {
          //Move down
          food[i].moveUp();
        }
      }
    }
  }


  private void populateBoard()
  {
    //Insert players
    board[player.getX()][player.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert food
    for (int i = 0; i < food.length; i++) {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
        // Game is over if player runs out of life
        gameOver = playerLife <= 0;
      } else if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY())
      {
        //We have a player2 collision
        --player2Life;
        // Game is over if player 2 runs out of life
        gameOver = player2Life <= 0;
      }
    }
    //Check food collisions
    // NOTE: Food collisions are a bit glitchy at times, but I would argue the same is true for enemies.
    //       I am not entirely sure what is causing the problem. I suspect it may have something to do with
    //       the order of the methods being called, but that is just a hunch.
    //       Could also be the fact that the game is running at 10 FPS.
    for (int i = 0; i < food.length; ++i) {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        //We have a collision
        //Add 10 to playerLife unless this extends beyond maxLife
        if (playerLife < maxLife) {
          if (maxLife - playerLife >= lifeFromFood) {
            playerLife += lifeFromFood;
          } else {
            playerLife = maxLife;
          }
        }
        // Move the food to a new random location on the board.
        food[i].x = rnd.nextInt(width);
        food[i].y = rnd.nextInt(height);
      } else if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY())
      {
        // We have a player 2 collision
        // Same procedure as above
        if (player2Life < maxLife) {
          if (maxLife - player2Life >= lifeFromFood) {
            player2Life += lifeFromFood;
          } else {
            player2Life = maxLife;
          }
        }
        food[i].x = rnd.nextInt(width);
        food[i].y = rnd.nextInt(height);
      }
    }
  }
}
