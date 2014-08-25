int w=1280,h=768;

float bpm=120;
int millisP;
float beat,beatFX;
int beatView;
int tap,tapCount;

String console="";
String consoleP="";
String consoleS="";
int consoleMode;
PFont font;

int pm=0;
int[] pm0x=new int[5],pm0y=new int[5],pm1x=new int[5],pm1y=new int[5],pm2x=new int[5],pm2y=new int[5],pm3x=new int[5],pm3y=new int[5];
PShader pmShader,pmShader4;

import themidibus.*;
MidiBus myBus;

import gifAnimation.*;
PImage[][] gif=new PImage[4][0];
String[] gifName=new String[4];
float[] gifBeat=new float[4];
int gifSel;

PGraphics proc;
float procParam;
int procMode;

PShader[] shader=new PShader[4];
String[] fxName=new String[4];
float[] param=new float[4];
int fxAble[]=new int[4];

int[] mouseP=new int[2];
int beatP;
float beatPBas,beatPEnv;

int cursor=1;

void setup(){
  size(w,h,P2D);
  imageMode(CENTER);
  
  font=loadFont("_/font.vlw");
  
  pmShader=loadShader("_/pm.glsl");
  pmShader4=loadShader("_/pm4.glsl");
  
  MidiBus.list();
  myBus=new MidiBus(this,0,-1);
  
  gif[0]=Gif.getPImages(this,"_/_.gif");
  gifName[0]="_/_.gif";
  for(int c=1;c<4;c++){
    gif[c]=gif[0];
    gifName[c]="_/_.gif";
  }
  
  proc=createGraphics(width,height);
  
  for(int c=0;c<4;c++)
  {
    shader[c]=loadShader("_/_.glsl");
    fxName[c]="_/_.glsl";
    fxAble[c]=1;
  }
  
  mouseP[0]=-1;mouseP[1]=-1;beatP=-1;
  
  loadPreset();
  loadPm();
}

void draw(){
  thread("load");
  
  int gap=millis()-millisP;
  float beatPrv=beat;
  beat+=gap*1./60000*bpm;
  if(floor(beatPrv)!=floor(beat))
  {
    beatFX=1;
  }
  millisP=millis();
  beatFX*=.8;
  
  background(0);
  
  if(mouseP[0]!=-1){
    if(mouseP[0]==4){procParam=mouseX*1./width;}else{param[mouseP[0]]=mouseX*1./width;}
  }
  if(mouseP[1]!=-1){
    if(mouseP[1]==4){procParam=mouseY*1./height;}else{param[mouseP[1]]=mouseY*1./height;}
  }
  if(beatP!=-1){
    if(beatP==4){procParam=beatPBas+sin(beatFX*PI)*beatPEnv;}else{param[beatP]=beatPBas+sin(beatFX*PI)*beatPEnv;}
  }
  
  if(pm!=2)
  {
    float size=max(width*1./gif[gifSel][0].width,height*1./gif[gifSel][0].height);
    if(gifBeat[gifSel]==0)
    {
      image(gif[gifSel][int(((beat/4)%1)*gif[gifSel].length)],width/2,height/2,gif[gifSel][0].width*size,gif[gifSel][0].height*size);
    }else{
      image(gif[gifSel][int(((beat/gifBeat[gifSel])%1)*gif[gifSel].length)],width/2,height/2,gif[gifSel][0].width*size,gif[gifSel][0].height*size);
    }
    
    proc();
    image(proc,width/2,height/2);
    
    for(int c=0;c<4;c++)
    {
      if(fxAble[c]==0)continue;
      shader[c].set("size",width,height);
      shader[c].set("time",frameCount);
      shader[c].set("param",param[c]);
      filter(shader[c]);
    }
    
    if(pm==1)
    {
      pmShader4.set("size",width,height);
      pmShader4.set("E0",pm0x[0],pm0y[0]);
      pmShader4.set("E1",pm1x[0],pm1y[0]);
      pmShader4.set("E2",pm2x[0],pm2y[0]);
      pmShader4.set("E3",pm3x[0],pm3y[0]);
      pmShader4.set("E01",pm0x[1],pm0y[1]);
      pmShader4.set("E11",pm1x[1],pm1y[1]);
      pmShader4.set("E21",pm2x[1],pm2y[1]);
      pmShader4.set("E31",pm3x[1],pm3y[1]);
      pmShader4.set("E02",pm0x[2],pm0y[2]);
      pmShader4.set("E12",pm1x[2],pm1y[2]);
      pmShader4.set("E22",pm2x[2],pm2y[2]);
      pmShader4.set("E32",pm3x[2],pm3y[2]);
      pmShader4.set("E03",pm0x[3],pm0y[3]);
      pmShader4.set("E13",pm1x[3],pm1y[3]);
      pmShader4.set("E23",pm2x[3],pm2y[3]);
      pmShader4.set("E33",pm3x[3],pm3y[3]);
      filter(pmShader4);
    }
  }else{
    for(int c=0;c<4;c++)
    {
      pmShader.set("size",width,height);
      pmShader.set("E0",pm0x[c],pm0y[c]);
      pmShader.set("E1",pm1x[c],pm1y[c]);
      pmShader.set("E2",pm2x[c],pm2y[c]);
      pmShader.set("E3",pm3x[c],pm3y[c]);
      if(gifBeat[c]==0)
      {
        pmShader.set("tex",gif[c][int(((beat/4)%1)*gif[c].length)]);
      }else{
        pmShader.set("tex",gif[c][int(((beat/gifBeat[c])%1)*gif[c].length)]);
      }
      filter(pmShader);
    }
    proc();
    pmShader.set("size",width,height);
    pmShader.set("E0",pm0x[4],pm0y[4]);
    pmShader.set("E1",pm1x[4],pm1y[4]);
    pmShader.set("E2",pm2x[4],pm2y[4]);
    pmShader.set("E3",pm3x[4],pm3y[4]);
    pmShader.set("tex",proc);
    filter(pmShader);
  }
  
  if(consoleMode!=0)
  {
    fill(beatFX*127*beatView); //<>//
    noStroke();
    rect(0,height-15,width,15);
    if(consoleMode==1)fill(255,255,255);
    if(consoleMode==2)fill(0,255,102);
    if(consoleMode==3)fill(255,0,102);
    textFont(font);
    text(console,2,height-4);
  }
}
