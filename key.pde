void keyPressed(){
  if(consoleMode!=1)console="";
  if(key==BACKSPACE){
    if(0<console.length()){
      console=console.substring(0,console.length()-1);
    }
  }
  else if(key==TAB){
    if(consoleMode==0){
      consoleMode=1;
    }else{
      consoleMode=0;
    }
  }
  else if(key==ENTER||key==RETURN){
    if(consoleMode==1){
      consoleP=console;
      if(3<=console.length()&&console.substring(0,3).equals("gif")){
        if(3==console.length()){yikes();return;}
        int num=console.charAt(3)-48;
        if(num<0||3<num){yikes();return;}
        if(4==console.length()){
          gifSel=num;
          yay();return;
        }else if(9<=console.length()&&console.substring(5,9).equals("load")){
          if(console.length()<11){plz("filename");return;}
          String name=console.substring(10,console.length());
          byte[] temp=loadBytes(name);
          if(temp==null){
            consoleMode=3;console="not found";return;
          }
          if(!console.substring(console.length()-4,console.length()).equals(".gif")){
            consoleMode=3;console="the file you want to load isn't gif";return;
          }
          loadNum.add(new Integer(num));
          loadName.add(new String(name));
          gifName[num]=name;
          yay();return;
        }else if(9<=console.length()&&console.substring(5,9).equals("beat")){
          if(console.length()<11){plz("value");return;}
          String val=console.substring(10,console.length());
          if(Float.isNaN(float(val))){nan();return;}
          gifBeat[num]=float(val);
          yay();return;
        }else{
          consoleMode=3;console="nope";return;
        }
      }else if(4<=console.length()&&console.substring(0,4).equals("proc")){
        if(6<=console.length()){
          if(9<=console.length()&&console.substring(5,9).equals("text")){
            if(11<=console.length()){
              procText=console.substring(10,console.length());
              yay();return;
            }else{
              procFont=loadFont("_/helv.vlw");
              procMode=1;
              yay();return;
            }
          }else if(8<=console.length()&&console.substring(5,8).equals("img")){
            if(10<=console.length()){
              String name=console.substring(9,console.length());
              byte[] temp=loadBytes(name);
              if(temp==null){
                consoleMode=3;console="not found";return;
              }
              procImg=loadImage(name);
              yay();return;
            }else{
              if(procImg==null){
                consoleMode=3;console="please load the image first";return;
              }
              procMode=2;
              yay();return;
            }
          }else if(10<=console.length()&&console.substring(5,10).equals("param")){
            if(console.length()<12){plz("value");return;}
            String val=console.substring(11,console.length());
            if(Float.isNaN(float(val))){nan();return;}
            procParam=float(val);
            yay();return;
          }else{
            consoleMode=3;console="nope";return;
          }
        }else{
          procMode=0;
          yay();return;
        }
      }else if(2<=console.length()&&console.substring(0,2).equals("fx")){
      if(2==console.length()){yikes();return;}
        int num=console.charAt(2)-48;
        if(num<0||3<num){yikes();return;}
        if(6<=console.length()&&console.substring(4,6).equals("en")){
          fxAble[num]=1;
          yay();return;
        }else if(7<=console.length()&&console.substring(4,7).equals("dis")){
          fxAble[num]=0;
          yay();return;
        }else if(9<=console.length()&&console.substring(4,9).equals("param")){
          if(console.length()<11){plz("value");return;}
          String val=console.substring(10,console.length());
          if(Float.isNaN(float(val))){nan();return;}
          param[num]=float(val);
          yay();return;
        }else if(8<=console.length()&&console.substring(4,8).equals("load")){
          if(console.length()<10){plz("filename");return;}
          String name=console.substring(9,console.length());
          byte[] temp=loadBytes(name);
          if(temp==null){consoleMode=3;console="not found";return;}
          if(!console.substring(console.length()-5,console.length()).equals(".glsl")){
            consoleMode=3;console="the file you want to load isn't glsl";return;
          }
          shader[num]=loadShader(name);
          fxName[num]=name;
          yay();return;
        }else{
          consoleMode=3;console="nope";return;
        }
      }else if(3<=console.length()&&console.substring(0,3).equals("bpm")){
        if(console.length()<5){plz("value");return;}
        String val=console.substring(4,console.length());
        if(Float.isNaN(float(val))){nan();return;}
        bpm=float(val);
        yay();return;
      }else if(3<=console.length()&&console.substring(0,3).equals("tap")){
        tapCount--;
        if(tapCount==0){
          bpm=60000*15./(millis()-tap);
          consoleMode=2;console="your current bpm is "+bpm;return;
        }
        if(tapCount==-1){
          tap=millis();
          tapCount=15;
        }
        consoleMode=1;console="tap "+tapCount;return;
      }else if(4==console.length()&&console.substring(0,4).equals("down")){
        beat=0;
        beatFX=1;
        yay();return;
      }else if(8==console.length()&&console.substring(0,8).equals("beatview")){
        beatView=1-beatView;
        yay();return;
      }else if(4<=console.length()&&console.substring(0,4).equals("beat")){
        if(4==console.length()){
          beatP=-1;
          yay();return;
        }else if(8<=console.length()&&console.substring(5,8).equals("bas")){
          if(console.length()<10){plz("value");return;}
          String val=console.substring(9,console.length());
          if(Float.isNaN(float(val))){nan();return;}
          beatPBas=float(val);
          yay();return;
        }else if(8<=console.length()&&console.substring(5,8).equals("env")){
          if(console.length()<10){plz("value");return;}
          String val=console.substring(9,console.length());
          if(Float.isNaN(float(val))){nan();return;}
          beatPEnv=float(val);
          yay();return;
        }else{
          int num=console.charAt(4)-48;
          if(num<0||4<num){consoleMode=3;console="YIKES! You have to select the bank by enter a digit 0-4 (proc is 4)";return;}
          beatP=num;
          yay();return;
        }
      }else if(6<=console.length()&&console.substring(0,5).equals("mouse")){
        int vars;
        if(console.substring(5,6).equals("x")){vars=0;}
        else if(console.substring(5,6).equals("y")){vars=1;}
        else{consoleMode=3;console="WTF you have to enter \"x\" or \"y\"";return;}
        if(6==console.length()){
          mouseP[vars]=-1;
          yay();return;
        }else{
          int num=console.charAt(6)-48;
          if(num<0||4<num){consoleMode=3;console="YIKES! You have to select the bank by enter a digit 0-4 (proc is 4)";return;}
          mouseP[vars]=num;
          yay();return;
        }
      }else if(6==console.length()&&console.substring(0,6).equals("cursor")){
        if(cursor==0){cursor();cursor=1;}else{noCursor();cursor=0;}
        yay();return;
      }else if(2<=console.length()&&console.substring(0,2).equals("pm")){
        if(2==console.length()){
          pm=(++pm)%3;
          yay();return;
        }else if(7==console.length()&&console.substring(3,7).equals("save")){
          savePm();
          yay();return;
        }else if(3<=console.length()){
          int num=console.charAt(2)-48;
          if(num<0||4<num){yikes();return;}
          if(console.length()<5){console=console.substring(0,3)+" 0";}
          int pos=console.charAt(4)-48;
          if(pos<0||3<pos){consoleMode=3;console="OUCH! You have to select the position by enter a digit 0-3";return;}
          if(pos==0){pm0x[num]=mouseX;pm0y[num]=mouseY;consoleMode=1;console=console.substring(0,4)+"1";return;}
          else if(pos==1){pm1x[num]=mouseX;pm1y[num]=mouseY;consoleMode=1;console=console.substring(0,4)+"2";return;}
          else if(pos==2){pm2x[num]=mouseX;pm2y[num]=mouseY;consoleMode=1;console=console.substring(0,4)+"3";return;}
          else if(pos==3){pm3x[num]=mouseX;pm3y[num]=mouseY;yay();return;}
          else{consoleMode=3;console="nope";return;}
        }else{
          consoleMode=3;console="nope";return;
        }
      }else if(4==console.length()&&console.substring(0,4).equals("save")){
        savePreset();
        yay();return;
      }else if(3==console.length()&&console.substring(0,3).equals("yay")){
        yay();return;
      }else{
        consoleMode=3;console="nope";return;
      }
    }
  }
  else if(key==CODED){
    if(keyCode==LEFT){
      consoleMode=1;
      console=consoleS;
    }else if(keyCode==RIGHT){
      consoleS=console;
    }else if(keyCode==UP){
      consoleMode=1;
      console=consoleP;
    }
  }
  else{
    consoleMode=1;
    console+=key;
  }
}

void plz(String s){
  consoleMode=3;
  console="plz enter a "+s;
}

void yikes(){
  consoleMode=3;
  console="YIKES! You have to select the bank by enter a digit 0-3";
}

void nan(){
  consoleMode=3;
  console="NaN deyanen";
}

void yay(){
  consoleMode=2;
  String ret="";
  switch((int)random(17)){
    case 0:ret="yay";break;
    case 1:ret="nya";break;
    case 2:ret="wlecome";break;
    case 3:ret="done";break;
    case 4:ret="waaaaa";break;
    case 5:ret="blablablablabla";break;
    case 6:ret="success";break;
    case 7:ret="hehe";break;
    case 8:ret="yo";break;
    case 9:ret="wow";break;
    case 10:ret="nemui";break;
    case 11:ret="very good";break;
    case 12:ret="such visual";break;
    case 13:ret="so cool";break;
    case 14:ret="lgtm";break;
    case 15:ret="hai";break;
    case 16:ret="yep";break;
  }
  console=ret;
}
