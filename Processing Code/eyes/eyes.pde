// fbx2 scales screen to 640x480
// screens 256x256 (scaled by 0.5) radius 128;
// separate screens are 320px (margin 32px) by 480 (margin 112px)
// so we sketch 256 by 256 and translate accordingly

import gohai.glvideo.*; // needed for Raspi Cam
import s373.flob.*; // nice Lib to do weighted blob detection
GLCapture video;

// ********************************************
// Flob floodfill Blob Detection Variables 
Flob flob;        // flob tracker instance
ArrayList blobs;  // an ArrayList to hold the gathered blobs
PImage videoinput; // needed since flob works on Imageobject
int tresh = 30;   // adjust treshold value here or keys t/T
int fade = 40;
int om = 1;
int videores=128;//64//256
String info="";
PFont font;
float fps = 60;
int videotex = 3; //case 0: videotex = videoimg;//case 1: videotex = videotexbin; 
//case 2: videotex = videotexmotion//case 3: videotex = videoteximgmotion;
ABlob mainBlob;

float easing = 0.1; // smooth the eye movement 
// ********************************************

float mPosX, mPosY; //darn globals
Eye eLeft;
Eye eRight;

void setup(){
  //fullScreen(P2D); //for RaspberryPi
  size(640,480,P2D);
  flobManagerInit();
  
  eLeft = new Eye(32, 112);
  eRight = new Eye(352, 112);
}

void draw() {
  
  flobManagerUpdate();
  
  background(255);
  //mPosX = map(mouseX, 0, 640, 0, 256);
  //mPosY = map(mouseY, 0, 480, 0, 256);
  eLeft.update();
  eRight.update();
  eLeft.draw();
  eRight.draw();
  //flobManagerDrawImage();
  flobManagerDrawFlobcenter();
}

void mouseClicked() {
  
}
void mousePressed() {
  eLeft.mPressed();
  eRight.mPressed();
}

void mouseReleased() {
  eLeft.mReleased();
  eRight.mReleased();
}

void drawMask() {
  beginShape();
  vertex(0,0);
  vertex(640,0);
  vertex(640,480);
  vertex(0,480);
  beginContour();
  vertex(32, 112 + 256);
  vertex(32+256, 112 + 256);
  vertex(32+256, 112);
  vertex(32, 112);
  endContour();
  beginContour();
  vertex(352, 112 + 256);
  vertex(352+256, 112 + 256);
  vertex(352+256, 112);
  vertex(352, 112);
  endContour();
  endShape();
}
