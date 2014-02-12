class ball
{
  private int w, h, x, y, originX, originY, top, bottom, right, left;
  private float d, speedX, speedY, speedConstant;
  private color c, b, r;
  private  final double speedup = Math.pow(2, 1/20d);
  public ball(int w, int h, float speed, color b, color r)
  {
    this.w = w;
    this.h = h;
    x = w/2;
    y=h/2;
    originX=x;
    originY=y;
    d= (w+h)/40f;
    speedConstant = speed;
    this.b = b;
    this.r=r;
    reset(0);
  }
  /*
  0 --> Does not matter
   1 --> +1 for blue
   2 --> +2 for red
   */
  public short Update(int maxLeft, int maxRight, int maxTop, int maxBottom, rect rTop, rect rBottom)
  {
    // Set ball_x and ball_y
    top = (int)(y-d/2);
    bottom =(int)(y+d/2);
    right =(int)(x+d/2);
    left =(int)(x-d/2);
    // RIGHT LEFT side
    if ((right > maxRight && speedX > 0) || (left < maxLeft && speedX < 0))
    {
      speedX*=-1;
    }
    // TOP
    if (top <= rTop.getHitLine())
    {
      if (rTop.isInnerX(left, right))
      {
        // Reflect here
        //Don't reflect if y is poitive
        if (speedY <0)
        {
          speedY*=-speedup;
          speedX *=speedup;
        }
      }
      //Either hit a rect, or possible point
      else if (top <= maxTop)
      {
        //Point for blue
        reset(1);
        return 1;
      }
    }
    if (bottom >= rBottom.getHitLine())
    {
      if (rBottom.isInnerX(left, right))
      {
        //Reflect here
        //Don't reflect if y is negative
        if (speedY > 0)
        {
          speedY*=-speedup;
          speedX *=speedup;
        }
      }

      else if (bottom >= maxBottom)
      {
        // Point for red
        reset(2);
        return 2;
      }
    }
    x +=  (speedX* ( 60 / frameRate) * speedConstant); 
    y += (speedY* ( 60 / frameRate) * speedConstant);
    return 0;
  }

  /*
 0--> black
   1--> blue
   2-->red
   */
  public void reset(int i)
  {
    x= originX;
    y= originY;
    if (i == 0)
      c = color(0);
    else if (i==1)
      c=b;
    else
      c=r;
    speedX= getSpeed();
    speedY=getSpeed();
    if((i==1 &&speedY <0)||(i==2&& speedY>0 ))
    speedY*=-1;
  }
  public void Draw()
  {
    noStroke();
    fill(c);
    ellipse(x, y, d, d);
  }
  private float getSpeed()
  {
    float speed, noise = random(-10, 10);
    if (h < w)
    {
      speed = random(h, w)/(2*h/3);
    } 
    else
    {
      speed = random(w, h)/(2*w/3);
    }
    if (noise <0)
      speed*=1;
    return speed;
  }
}

