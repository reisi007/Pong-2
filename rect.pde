class rect
{
  private color c;
  private boolean blue = false;
  private float speed;
  private int positionX, positionY, totalWidth, realW, realH, hitline;
  public rect(int position, int totalWidth, int totalHeight)
  {
    realW = totalWidth/5;
    realH=totalHeight/60;
    speed=totalHeight/90f;
    positionX = totalWidth/2;
    if (position < totalHeight/2)
    {
      // RED -> Top
      c = color(171, 0, 0);
      positionY=position+realH/2;
      hitline= positionY+realH/2;
    }
    else
    {
      // BLUE -> Bottom
      c = color(0, 171, 171);
      blue = true;
      positionY= position-realH/2;
      hitline= positionY-realH/2;
    }
    this.totalWidth = totalWidth;
  } 
  public void Draw()
  {
    rectMode(CENTER);
    noStroke();
    fill(c);
    rect(positionX, positionY, realW, realH);
    //Hitline
    stroke(0);
    strokeWeight(2);
    line(positionX-realW/2, hitline, positionX+realW/2, hitline);
  }
  public void Update(float desPos)
  {
    if (desPos >=0)
    {
      if (Math.abs(desPos-positionX) >= speed)
      {
        if (desPos-positionX > 0)
          positionX +=speed;
        else
          positionX-=speed;
      }
      else
        positionX=(int)(desPos+0.5f);
    }
  }
  public boolean isInnerX(int a, int b)
  {
    if (b > (positionX-realW/2) && (positionX+realW/2) > a)
      return true;
    return false;
  }
  public int getHitLine()
  {
    return hitline;
  }
}

