void noteOn(int ch,int pit,int vel) {
  if(ch==1)
  {
    if(60<=pit&&pit<=63)
    {
      gifSel=pit-60;
    }
    if(pit==72)
    {
      beat=0;
      beatFX=1;
    }
  }
  
  println("Note : "+ch+" - "+pit+" - "+vel);
}

void controllerChange(int ch,int num,int val){
  if(ch==1)
  {
    if(1<=num&&num<=4)
    {
      int layer=num-1;
      param[layer]=val/127.;
    }
  }
  
  println("MIDI CC : "+ch+" - "+num+" - "+val);
}
