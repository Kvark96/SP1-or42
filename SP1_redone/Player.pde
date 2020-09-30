class Player extends Dot
{

  private int lifePoints;
  Keys moveKeys;
  // Movement keys are assigned as integers through the creation of a Key Object.
  Player(int x, int y, int maxX, int maxY, int up, int left, int down, int right)
  {
      super(x, y, maxX, maxY);
      moveKeys = new Keys(up, left, down, right);
  }
  
  void onKeyPressed(int n){
    moveKeys.onKeyPressed(n);
  }
  
  void onKeyReleased(int n){
    moveKeys.onKeyReleased(n);
  }
  
  void updatePlayer(){
    //Update player
    if (moveKeys.wDown() && !moveKeys.sDown())
    {
      moveUp();
    }
    if (moveKeys.aDown() && !moveKeys.dDown())
    {
      moveLeft();
    }
    if (moveKeys.sDown() && !moveKeys.wDown())
    {
      moveDown();
    }
    if (moveKeys.dDown() && !moveKeys.aDown())
    {
      moveRight();
    }
  }
  
  void adjustLife(int change){
    lifePoints += change;
  }
  
  int getLife(){
    return lifePoints;
  }
  
}
