class Enemy extends Dot{
  Enemy(int x, int y, int maxX, int maxY){
    super(x, y, maxX, maxY);
  }
  
  void moveEnemy(Player player1, Player player2){
    //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        // NOTE: I have changed this so that it determines which player is closest, and chases them
        //       This does result in a problem where the enemies won't move if both players are (nearly) equally close to them,
        //       but I'm pretty sure this is unavoidable in a simple game like this.
        //       Also, enemies will follow player2 from start, since they are closer when spawning, but this is unimportant.
        int dx = abs(player1.getX() -   x) < abs(player2.getX() -   x) ? player1.getX() -  x : player2.getX() -  x;
        int dy = abs(player1.getY() -  y) < abs(player2.getY() -  y) ? player1.getY() -  y : player2.getY() - y;

        if (abs(dx) > abs(dy))
        {
          if (dx > 0)
          {
            //Player is to the right
             moveRight();
          } else
          {
            //Player is to the left
             moveLeft();
          }
        } else if (dy > 0)
        {
          //Player is down;
           moveDown();
        } else
        {//Player is up;
           moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
           moveRight();
        } else if (move == 1)
        {
          //Move left
           moveLeft();
        } else if (move == 2)
        {
          //Move up
           moveUp();
        } else if (move == 3)
        {
          //Move down
           moveDown();
        }
      }
  }
  
}
