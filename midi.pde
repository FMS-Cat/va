void controllerChange(int ch,int num,int val){
  if(12<=ch&&ch<16)
  {
    int layer=ch-12;
    if(num==1)param[layer]=val/127.;
  }
  
  println("MIDI CC : "+ch+" - "+num+" - "+val);
}
