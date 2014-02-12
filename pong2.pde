boolean  sketchFullScreen() {
  return  true ;
}
//Start Multitouch region
import android.view.MotionEvent;
float xTouch[];
float yTouch[];
public boolean surfaceTouchEvent(MotionEvent event) {
  if (start) {
    // Number of places on the screen being touched:
    int TouchEvents = event.getPointerCount();

    // If no action is happening, listen for new events else 
    for (int i = 0; i < TouchEvents; i++) {
      int pointerId = event.getPointerId(i);
      xTouch[pointerId] = event.getX(i); 
      yTouch[pointerId] = event.getY(i);
    }
    return super.surfaceTouchEvent(event);
  }
  else {
    start = true;
    loop();
    return true;
  }
}
//getFirst for Top bottom
private float getFirst(boolean top)
{
  for (int i=0; i < xTouch.length;i++)
  {
    if (top)
    {
      // yTouch smaller then displayH/2 and greater than 0
      if (yTouch[i] < displayH/2 && yTouch[i] > 0)
        return xTouch[i];
    }
    else
    {
      // yTouch greater then displayH/2
      if (yTouch[i] > displayH/2)
        return xTouch[i];
    }
  }
  return -1;
}
//End Multitouch region
boolean start = false;
void setup()
{
  noLoop();
  begin();
  // Say Hello to the user
  background(0, 128, 0);
  textAlign(CENTER);
  fill(255);
  String welcome = "Welcome to Pong", touch = "Touch the screen to start the game.";
  int size = 255;
  textFont(font, size);
  while(textWidth(welcome) > 0.8f * displayW)
  textFont(font, size-=5);
  text(welcome,displayW/2,displayH/3);
  size =255;
  while(textWidth(touch) > 0.8f * displayW)
  textFont(font, size-=5);
  text(touch,displayW/2,2*displayH/3);
  textFont(font,32);
}
private void begin() {
  // Init multitouch
  xTouch = new float[10];
  yTouch= new float[10];
  //Init variables
  displayW=displayWidth;
  displayH=displayHeight;
  if (displayW > displayH)
    smallSide = displayH;
  else
    smallSide = displayW;
  lineW = displayW/100;
  centerX= displayW/2;
  centerY = displayH/2;
  mouseRight = 14*displayW/20;
  mouseLeft = 6*displayW/20;
  helperCentralballSize = (displayW+displayH)/40;
  speed = displayH/400;
  smooth();
  // Initialize boxes
  Bottom = new rect(displayH-2*lineW, displayW, displayH);
  Top = new rect(2*lineW, displayW, displayH);
  // Initialize ball
  b = new ball(displayW, displayH, speed, blue, red);
  // Load font
  font = loadFont("font.vlw");
}
// Variables declaration area
int helperCentralballSize, lineW, displayH, displayW, centerX, centerY, mouseLeft, mouseRight, scoreUp, scoreDown, smallSide, score;
color bg =color(0, 128, 0), red = color(171, 0, 0), blue =color(0, 171, 171) ;
float speed;
PFont font;
rect Top, Bottom;
ball b;
private void Update()
{
  // Setting desired position of Top/Bottom
  Bottom.Update(getFirst(false));
  Top.Update(getFirst(true));
  score = b.Update(2*lineW, displayW-2*lineW, 2*lineW, displayH-2*lineW, Top, Bottom);
  if (score == 1)
    scoreDown++;
  else if (score==2)
    scoreUp++;
}
private void Draw()
{
  initNewDraw();
  Bottom.Draw();
  Top.Draw();
  b.Draw();
}
void draw()
{
  if (start)
  {
    // First update everything
    Update();
    //Then draw
    Draw();
  }
}
void initNewDraw()
{
  background(0, 128, 0);
  //Define color and weigth of strokes
  stroke(0, 102, 0);
  strokeWeight(lineW/4);
  fill(bg);
  /*// Mouse sensitive areas
   line(mouseLeft, 0f, mouseLeft, displayH);
   line(mouseRight, 0f, mouseRight, displayH);*/
  // Line in the middle in white
  strokeWeight(lineW);
  stroke(255);
  line(0, centerY, displayW, centerY);
  // Draw outer ellipse
  ellipse(centerX, centerY, smallSide*0.7, smallSide*0.7);
  // Draw point in the middle
  fill(255);
  noStroke();
  ellipse(centerX, centerY, helperCentralballSize, helperCentralballSize); 
  // Draw borders
  rectMode(CORNER);
  //LEFT
  rect(0, 0, 2*lineW, displayH);
  //RIGHT
  rect((displayW- 2*lineW), 0, 2*lineW, displayH);
  //TOP
  rect(0, 0, displayW, 2*lineW);
  //BOTTOM
  rect(0, displayH-2*lineW, displayW, 2*lineW);
  /*
  *  Draw text
   */
  textAlign(RIGHT);
  translate(4*lineW, 8*lineW); // Translate to the center
  rotate((float)(Math.PI)); 
  fill(red);
  text(scoreUp, 0,5*lineW);
  resetMatrix();
  textAlign(LEFT);
  fill(blue);
  text(scoreDown, 4*lineW, displayH-4*lineW);
  fill(0, 155);
  text((int)(frameRate+0.4f), displayW-11*lineW, 8*lineW);
}

