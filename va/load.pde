PImage[] loadTemp;
ArrayList<Integer> loadNum=new ArrayList<Integer>();
ArrayList<String> loadName=new ArrayList<String>();

void load()
{
  while(loadNum.size()!=0)
  {
    int num=loadNum.get(0);
    String name=loadName.get(0);
    loadNum.remove(0);
    loadName.remove(0);
    loadTemp=new PImage[0];
    loadTemp=Gif.getPImages(this,name);
    gif[num]=loadTemp;
  }
}
