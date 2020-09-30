class Food extends Dot{
  Food(int x, int y, int maxX, int maxY){
    super(x, y, maxX, maxY);
  }
  void newPos(){
    x = rnd.nextInt(maxX + 1);
    y = rnd.nextInt(maxY + 1);
  }
  
void moveFood(Player player1, Player player2){
    if (rnd.nextInt(3) < 2) {
      //We follow
      //As opposed to enemies, the food will run from the player closest to them
      //NOTE: dx and dy can be from different players (ie. dy could be closer for player1, while dx is closer for player2)
      int dx = abs(player1.getX() - x) < abs(player2.getX() - x) ? player1.getX() - x : player2.getX() - x;
      int dy = abs(player1.getY() - y) < abs(player2.getY() - y) ? player1.getY() - y : player2.getY() - y;
      if (abs(dx) > abs(dy))
      {
        if (dx > 0)
        {
          //Player is to the right
          moveLeft();
        } else
        {
          //Player is to the left
          moveRight();
        }
      } else if (dy > 0)
      {
        //Player is down;
        moveUp();
      } else
      {//Player is up;
        moveDown();
      }
    } else
    {
      //We move randomly
      int move = rnd.nextInt(4);
      if (move == 0)
      {
        //Move right
        moveLeft();
      } else if (move == 1)
      {
        //Move left
        moveRight();
      } else if (move == 2)
      {
        //Move up
        moveDown();
      } else if (move == 3)
      {
        //Move down
        moveUp();
      }
    }
  }
  
}
