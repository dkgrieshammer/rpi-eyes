// separated all that stuff to functions to have more overview

void flobManagerInit() {
  String[] devices = GLCapture.list(); // used if specific raspberry pi GLCapture is used
  //video = new GLCapture(this); 
  //can be more specific, choose if on Raspberry; osx throws error if capture smaller than sketch size
  video = new GLCapture(this, devices[0], 640, 480, 25);
  video.start();
  videoinput = createImage(videores, videores, RGB);
  flob = new Flob(this, videoinput, width,height);
  flob.setTresh(tresh); //set the new threshold to the binarize engine
  flob.setThresh(tresh); //typo
  flob.setSrcImage(videotex);
  flob.setImage(videotex); //  pimage i = flob.get(Src)Image();
  flob.setBackground(videoinput); // zero background to contents of video
  flob.setBlur(0); //new : fastblur filter inside binarize
  flob.setMirror(true,false);
  flob.setOm(0); //flob.setOm(flob.STATIC_DIFFERENCE);
  flob.setOm(1); //flob.setOm(flob.CONTINUOUS_DIFFERENCE);
  flob.setFade(fade); //only in continuous difference
  /// or now just concatenate messages
  //flob.setThresh(tresh).setSrcImage(videotex).setBackground(videoinput).setBlur(0).setOm(1).setFade(fade).setMirror(true,false);
  boolean feats[] = {true,true,true,true,true};
  flob.setTrackFeatures( feats ); //not sure what that is, guess what kind of features flob looking for
  blobs = new ArrayList();
}

void flobManagerUpdate() {
  // main image loop
  if(video.available()) {
     video.read();
     videoinput.copy(video, 0, 0, 640, 480, 0, 0, videores, videores);
     blobs = flob.calc(flob.binarize(videoinput));
  }
  //get and use the data
  int numblobs = blobs.size();//flob.getNumBlobs();
  // we just need one blob actually)
  if(numblobs > 0) {
    mainBlob = (ABlob)flob.getABlob(0);
    mPosX = map(mainBlob.cx, 0, 640, 0, 256);
    mPosY = map(mainBlob.cy, 0, 480, 0, 256);
  }
  //float xtreme[] = flob.getABlobExtreme
}

void flobManagerDrawFlobcenter() {
  if(mainBlob != null) {
    pushStyle();
    fill(255,0,0);
    ellipse(mainBlob.cx, mainBlob.cy, 50,50);
    popStyle();
  }
  
}

// only use for debugging purpose
void flobManagerDrawImage() {
  image(flob.getSrcImage(), 0, 0, width, height);
}
