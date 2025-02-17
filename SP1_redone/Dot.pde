import java.util.Random;

class Dot
{
  int x;
  int y;
  final int maxX;
  final int maxY;
  Random rnd = new Random();
  
  public Dot(int x, int y, int maxX, int maxY)
  {
    this.x = x;
    this.y = y;
    this.maxX = maxX;
    this.maxY = maxY;
  }
  
  public int getX()
  {
    return x;
  }
  
  public int getY()
  {
    return y;
  }
  
  public void moveLeft()
  {
    --x;
    if(x < 0)
    {
      x = 0;
    }
  }
  
  public void moveRight()
  {
    ++x;
    if(x > maxX)
    {
      x = maxX;
    }
  }
  
  public void moveUp()
  {
    --y;
    if(y < 0)
    {
      y = 0;
    }
  }
  
  public void moveDown()
  {
    ++y;
    if(y > maxY)
    {
      y = maxY;
    }
  }
  
  boolean checkCollision(Dot player){
    return (x == player.x && y == player.y);
  }
  
}
