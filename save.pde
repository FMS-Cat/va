Table table;

void savePreset()
{
  table=new Table();
  
  table.addColumn("num");
  table.addColumn("name");
  table.addColumn("beat");
  table.addColumn("fxname");
  table.addColumn("param");
  table.addColumn("fxable");
  table.addColumn("assign");
  table.addColumn("env");
  table.addColumn("bpm");
  
  for(int c=0;c<4;c++)
  {
    TableRow row=table.addRow();
    row.setInt("num",c);
    row.setString("name",gifName[c]);
    row.setFloat("beat",gifBeat[c]);
    if(c<4)
    {
      row.setString("fxname",fxName[c]);
      row.setFloat("param",param[c]);
      row.setInt("fxable",fxAble[c]);
    }
    if(c==0)
    {
      row.setInt("assign",mouseP[0]);
      row.setFloat("env",beatPBas);
      row.setFloat("bpm",bpm);
    }
    if(c==1)
    {
      row.setInt("assign",mouseP[1]);
      row.setFloat("env",beatPEnv);
    }
    if(c==2)
    {
      row.setInt("assign",beatP);
    }
  }
  
  saveTable(table,"data/preset.csv");
}

void loadPreset()
{
  table=loadTable("preset.csv","header");
  
  for(TableRow row:table.rows())
  {
    int num=row.getInt("num");
    
    loadNum.add(new Integer(num));
    loadName.add(new String(row.getString("name")));
    gifName[num]=row.getString("name");
    gifBeat[num]=row.getFloat("beat");
    if(num<4)
    {
      shader[num]=loadShader(row.getString("fxname"));
      fxName[num]=row.getString("fxname");
      param[num]=row.getFloat("param");
      fxAble[num]=row.getInt("fxable");
    }
    if(num==0)
    {
      mouseP[0]=row.getInt("assign");
      beatPBas=row.getFloat("env");
      bpm=row.getFloat("bpm");
    }
    if(num==1)
    {
      mouseP[1]=row.getInt("assign");
      beatPEnv=row.getFloat("env");
    }
    if(num==2)
    {
      beatP=row.getInt("assign");
    }
  }
}
