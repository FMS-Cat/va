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

void savePm()
{
  table=new Table();
  
  table.addColumn("num");
  table.addColumn("0x");
  table.addColumn("0y");
  table.addColumn("1x");
  table.addColumn("1y");
  table.addColumn("2x");
  table.addColumn("2y");
  table.addColumn("3x");
  table.addColumn("3y");
  
  for(int c=0;c<4;c++)
  {
    TableRow row=table.addRow();
    row.setInt("num",c);
    row.setInt("0x",pm0x[c]);
    row.setInt("0y",pm0y[c]);
    row.setInt("1x",pm1x[c]);
    row.setInt("1y",pm1y[c]);
    row.setInt("2x",pm2x[c]);
    row.setInt("2y",pm2y[c]);
    row.setInt("3x",pm3x[c]);
    row.setInt("3y",pm3y[c]);
  } 
  saveTable(table,"data/pm.csv");
}

void loadPm()
{
  table=loadTable("pm.csv","header");
  
  for(TableRow row:table.rows())
  {
    int num=row.getInt("num");
    pm0x[num]=row.getInt("0x");
    pm0y[num]=row.getInt("0y");
    pm1x[num]=row.getInt("1x");
    pm1y[num]=row.getInt("1y");
    pm2x[num]=row.getInt("2x");
    pm2y[num]=row.getInt("2y");
    pm3x[num]=row.getInt("3x");
    pm3y[num]=row.getInt("3y");
  }
}
