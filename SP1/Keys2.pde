class Keys2{
  private boolean leftDown = false;
  private boolean rightDown = false;
  private boolean upDown = false; // This is a really weird variable name.
  private boolean downDown = false; // This is even weirder.
  
  public Keys2(){}
  
  public boolean upDown()
  {
    return upDown;
  }
  
  public boolean leftDown()
  {
    return leftDown;
  }
  
  public boolean downDown()
  {
    return downDown;
  }
  
  public boolean rightDown()
  {
    return rightDown;
  }
  
  
  
  void onKeyPressed(int n)
  {
    if(n == UP)
    {
      upDown = true;
    }
    else if (n == LEFT)
    {
      leftDown = true;
    }
    else if(n == RIGHT)
    {
      rightDown = true;
    }
    else if(n == DOWN)
    {
      downDown = true;
    }
  }
  
  
  void onKeyReleased(int n)
  {
    if(n == UP)
    {
      upDown = false;
    }
    else if (n == LEFT)
    {
      leftDown = false;
    }
    else if(n == RIGHT)
    {
      rightDown = false;
    }
    else if(n == DOWN)
    {
      downDown = false;
    }
  }
  
  
  
}
