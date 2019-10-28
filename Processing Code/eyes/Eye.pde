class Eye {
  
  public int x, y = 0;
  public int irisSize = 200; //iris
  public int pupSize = 80; //pupils
  public int whiteSize = 50; //white spot - TODO: elaborate later 
  
  
  private int eyeRad = 128;
  private int lidY = 40; //lid y startpos
  private int lidL = 10; //lid controlPoint left
  private int lidR = 10; //lid controlPoint right
  private PVector lookAt;
  
  PGraphics Can; // Canvas for the Eye 
  
  Eye(int xPos, int yPos) {
    this.x = xPos;
    this.y = yPos;
    this.Can = createGraphics(256, 256);
    lookAt = new PVector(128, 128);
  }
  
  
  public void update() {
    //lookAt.x = int(map(mouseX, 0, 640, 0, 256));
    //lookAt.y = int(map(mouseY, 0, 480, 0, 256));
    float targetX = mPosX;
    float targetY = mPosY;
    float dx = targetX - lookAt.x;
    float dy = targetY - lookAt.y;
    lookAt.x += dx * easing;
    lookAt.y += dy * easing;
  }
  
  public void draw() {
    Can.beginDraw();
    Can.background(255);
    Can.noStroke();
    iris(Can);
    pupil(Can);
    whiteSpots(Can);
    upperLid(Can);
    Can.endDraw();
    image(Can, x, y);
  }
  
  
  private void iris(PGraphics C) {
    C.fill(0,20,200);
    C.ellipse(lookAt.x,lookAt.y,irisSize, irisSize);
  }
  
  private void pupil(PGraphics C) {
    C.fill(0);
    C.ellipse(lookAt.x, lookAt.y, pupSize, pupSize);
  }
  
  private void whiteSpots(PGraphics C) {
    C.fill(255);
    C.ellipse(lookAt.x + 40,lookAt.y-40,whiteSize,whiteSize);
  }
  
  private void upperLid(PGraphics C) {
    C.noStroke();
    C.fill(0);
    C.beginShape();
    C.vertex(0,lidY);
    C.bezierVertex(86,lidL, 172,lidR, 256,lidY);
    C.vertex(256,0);
    C.vertex(0,0);
    C.vertex(0,120);
    C.endShape(CLOSE);
  }
  
  public void mPressed() {
    this.lidY = 120;
    this.lidL = 80;
    this.lidR = 80;
  }
  
  public void mReleased() {
    this.lidY = 20;
    this.lidL = this.lidR = -10;
  }
  
  
}
