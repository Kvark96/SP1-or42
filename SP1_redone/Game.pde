import java.util.Random;

class Game
{
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;

  private Player player1;
  private Player player2;
  private Enemy[] enemies;
  // Food array and maxLife
  private int lifeFromFood = 10;
  private Food[] food;
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

    // Initializes two players, with seperate movement keys
    println("Player 1 initialized.");
    player1 = new Player(0, 0, width-1, height-1, Character.getNumericValue('w'), Character.getNumericValue('a'), Character.getNumericValue('s'), Character.getNumericValue('d'));
    println("Player 2 initialized.");
    player2 = new Player(width-1, 0, width-1, height-1, UP, LEFT, DOWN, RIGHT);
    enemies = new Enemy[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Enemy(width-1, height-1, width-1, height-1);
    }
    // Assigns value to numberOfFood and initiates food array
    player1.adjustLife(maxLife);
    player2.adjustLife(maxLife);
    food = new Food[numberOfFood];
    for (int i = 0; i < numberOfFood; ++i) {
      food[i] = new Food(rnd.nextInt(width), rnd.nextInt(height), width-1, height-1);
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

  public int getPlayerLife(String playerNum)
  {
    if (playerNum == "P1") {
      return player1.getLife();
    } else {
      return player2.getLife();
    }
  }

  public void onKeyPressed(int n)
  {
    player1.onKeyPressed(n);
    player2.onKeyPressed(n);
  }

  public void onKeyReleased(int n)
  {
    player1.onKeyReleased(n);
    player2.onKeyReleased(n);
  }

  public void update()
  {
    updatePlayer(); 
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }

  // Can be called to check whether the game is over. The name is self-explanatory.
  public boolean isGameOver() {
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
    player1.updatePlayer();
    player2.updatePlayer();
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      enemies[i].moveEnemy(player1, player2);
    }
  }

  private void updateFood() {
    for (int i = 0; i < food.length; i++) {
      food[i].moveFood(player1, player2);
    }
  }


  private void populateBoard()
  {
    //Insert players
    board[player1.getX()][player1.getY()] = 1;
    board[player2.getX()][player2.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert food
    for (int i = 0; i < food.length; ++i) {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if(enemies[i].checkCollision(player1)){
        player1.adjustLife(-1);
        gameOver = player1.getLife() <= 0;
      } else if(enemies[i].checkCollision(player2)){
        player2.adjustLife(-1);
        gameOver = player2.getLife() <= 0;
      }
    }
    //Check food collisions
    // NOTE: Food collisions are a bit glitchy at times, but I would argue the same is true for enemies.
    //       I am not entirely sure what is causing the problem. I suspect it may have something to do with
    //       the order of the methods being called, but that is just a hunch.
    //       Could also be the fact that the game is running at 10 FPS.
    for (int i = 0; i < food.length; ++i) {
      if (food[i].checkCollision(player1))
      {
        //We have a collision
        //Add 10 to player1.lifePoints unless this extends beyond maxLife
        if (player1.getLife() < maxLife) {
          if (maxLife - player1.getLife() >= lifeFromFood) {
            player1.adjustLife(lifeFromFood);
          } else {
            player1.adjustLife(maxLife - player1.getLife());
          }
        }
        // Move the food to a new random location on the board.
        food[i].newPos();
      } else if (food[i].checkCollision(player2))
      {
        // We have a player 2 collision
        // Same procedure as above
        if (player2.getLife() < maxLife) {
          if (maxLife - player2.getLife() >= lifeFromFood) {
            player2.adjustLife(lifeFromFood);
          } else {
            player2.adjustLife(maxLife - player2.getLife());
          }
        }
        food[i].newPos();
      }
    }
  }
}
