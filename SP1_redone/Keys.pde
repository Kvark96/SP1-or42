class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;
  
  private int upKey, leftKey, downKey, rightKey;
  
  // Takes the variables as integers, since both the arrow keys and character keys can be converted into this.
  public Keys(int upKey, int leftKey, int downKey, int rightKey){
    this.upKey = upKey;
    println("upKey = " + upKey);
    this.leftKey = leftKey;
    println("leftKey = " + leftKey);
    this.downKey = downKey;
    println("downKey = " + downKey);
    this.rightKey = rightKey;
    println("rightKey = " + rightKey);
  }
  
  public boolean wDown()
  {
    return wDown;
  }
  
  public boolean aDown()
  {
    return aDown;
  }
  
  public boolean sDown()
  {
    return sDown;
  }
  
  public boolean dDown()
  {
    return dDown;
  }
  
  
  // This is changed to accomodate the new integer format.
  // Since upper and lower case characters share a numeric value, it is only necessary to use one conditional.
  void onKeyPressed(int n)
  {
    if(n == upKey)
    {
      wDown = true;
    }
    else if (n == leftKey)
    {
      aDown = true;
    }
    else if(n == downKey)
    {
      sDown = true;
    }
    else if(n == rightKey)
    {
      dDown = true;
    }
  }
  
  void onKeyReleased(int n)
  {
    if(n == upKey)
    {
      wDown = false;
    }
    else if (n == leftKey)
    {
      aDown = false;
    }
    else if(n == downKey)
    {
      sDown = false;
    }
    else if(n == rightKey)
    {
      dDown = false;
    }
  }
}
