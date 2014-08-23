String procText="Yay";
PFont procFont;

void proc()
{
  proc.beginDraw();
  
  proc.background(0,0);
  
  if(procMode==1)
  {
    proc.textAlign(CENTER,CENTER);
    proc.textFont(procFont);
    proc.pushMatrix();
    proc.translate(width/2,height/2);
    proc.noSmooth();
    proc.scale(1+procParam*3);
    proc.text(procText,0,0);
    proc.popMatrix();
  }
  
  proc.endDraw();
}
