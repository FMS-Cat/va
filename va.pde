int w=240,h=240;

int sel=0;
float bpm=120;
int millisP;
float beat,beatFX;
int beatView;

String console="";
String consoleP="";
String consoleS="";
int consoleMode;
PFont font;

int pm;
int[] pm0x=new int[9],pm0y=new int[9],pm1x=new int[9],pm1y=new int[9],pm2x=new int[9],pm2y=new int[9],pm3x=new int[9],pm3y=new int[9];
PShader pmShader;

import themidibus.*;
MidiBus myBus;

import processing.video.*;
Movie[] mov=new Movie[4];
int movSel;

import gifAnimation.*;
PImage[][] gif=new PImage[4][];
float[] gifBeat=new float[4];
int gifSel;

PGraphics proc;
float procParam;
int procMode;

PShader[] shader=new PShader[4];
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
  
  MidiBus.list();
  myBus=new MidiBus(this,1,-1);
  
  for(int c=0;c<4;c++)
  {
    mov[c]=new Movie(this,"_/_.png");
    mov[c].loop();
    mov[c].volume(0);
  }
  
  for(int c=0;c<4;c++)
  {
    gif[c]=Gif.getPImages(this,"_/_.gif");
  }
  
  proc=createGraphics(width,height);
  
  for(int c=0;c<4;c++)
  {
    shader[c]=loadShader("_/_.glsl");
    fxAble[c]=1;
  }
  
  mouseP[0]=-1;mouseP[1]=-1;beatP=-1;
}

void draw(){
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
  
  for(int c=0;c<4;c++)
  {
    if(mov[c].time()>=mov[c].duration()-.1)mov[c].jump(0.);
  }
  
  if(mouseP[0]!=-1){
    if(mouseP[0]==4){procParam=mouseX*1./width;}else{param[mouseP[0]]=mouseX*1./width;}
  }
  if(mouseP[1]!=-1){
    if(mouseP[1]==4){procParam=mouseY*1./height;}else{param[mouseP[1]]=mouseX*1./height;}
  }
  if(beatP!=-1){
    if(beatP==4){procParam=beatPBas+sin(beatFX*PI)*beatPEnv;}else{param[beatP]=beatPBas+sin(beatFX*PI)*beatPEnv;}
  }
  
  if(pm==0){
    if(sel==0)
    {
      float size=max(width*1./mov[movSel].width,height*1./mov[movSel].height);
      image(mov[movSel],width/2,height/2,mov[movSel].width*size,mov[movSel].height*size);
    }
    
    if(sel==1)
    {
      float size=max(width*1./gif[gifSel][0].width,height*1./gif[gifSel][0].height);
      if(gifBeat[gifSel]==0)
      {
        image(gif[gifSel][frameCount%gif[gifSel].length],width/2,height/2,gif[gifSel][0].width*size,gif[gifSel][0].height*size);
      }else{
        image(gif[gifSel][int(((beat/gifBeat[gifSel])%1)*gif[gifSel].length)],width/2,height/2,gif[gifSel][0].width*size,gif[gifSel][0].height*size);
      }
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
  }else{
    for(int c=0;c<4;c++)
    {
      pmShader.set("size",width,height);
      pmShader.set("e0",pm0x[c],pm0y[c]);
      pmShader.set("e1",pm1x[c],pm1y[c]);
      pmShader.set("e2",pm2x[c],pm2y[c]);
      pmShader.set("e3",pm3x[c],pm3y[c]);
      pmShader.set("tex",mov[c]);
      filter(pmShader);
    }
    for(int c=0;c<4;c++)
    {
      pmShader.set("size",width,height);
      pmShader.set("e0",pm0x[c+4],pm0y[c+4]);
      pmShader.set("e1",pm1x[c+4],pm1y[c+4]);
      pmShader.set("e2",pm2x[c+4],pm2y[c+4]);
      pmShader.set("e3",pm3x[c+4],pm3y[c+4]);
      if(gifBeat[c]==0)
      {
        pmShader.set("tex",gif[c][frameCount%gif[c].length]);
      }else{
        pmShader.set("tex",gif[c][int(((beat/gifBeat[c])%1)*gif[c].length)]);
      }
      filter(pmShader);
    }
    proc();
    pmShader.set("size",width,height);
    pmShader.set("e0",pm0x[8],pm0y[8]);
    pmShader.set("e1",pm1x[8],pm1y[8]);
    pmShader.set("e2",pm2x[8],pm2y[8]);
    pmShader.set("e3",pm3x[8],pm3y[8]);
    pmShader.set("tex",proc);
    filter(pmShader);
  }
  
  if(consoleMode!=0)
  {
    fill(beatFX*127*beatView);
    noStroke();
    rect(0,height-15,width,15);
    if(consoleMode==1)fill(255,255,255);
    if(consoleMode==2)fill(0,255,102);
    if(consoleMode==3)fill(255,0,102);
    textFont(font);
    text(console,2,height-4);
  }
}

void movieEvent(Movie m){
  m.read();
}
