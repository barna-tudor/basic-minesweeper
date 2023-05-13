void keyPressed()
{
  if (keyPressed&&keyCode==SHIFT)
  {
    gamePlaying=false;
    inMenu=true;
  }
}
void mousePressed()
{
  if (gamePlaying)
  {
    for (int i=1; i<GameFieldHeight-1; i++)
    {
      for (int j=1; j<GameFieldWidth-1; j++)
      {
        if (GameField[i][j].Revealed==false)
        {
          if ((mouseX>(j-1)*CellWidth&&mouseX<j*CellWidth-1)&&(mouseY>(i-1)*CellHeight&&mouseY<i*CellHeight))
          {

            if (mouseButton==LEFT&&!GameField[i][j].Flagged)
            {
              if (GameField[i][j].CellType==FREE)
              {
                reveal(i, j);
              }
              GameField[i][j].Revealed=true;
              if (GameField[i][j].CellType==BOMB)
              {
                gamePlaying=false;
                background(0);
                fill(255);
                textSize(5*sqrt(GameFieldHeight*GameFieldWidth));
                text("Game Over", width/2, height/2);
              }
              if (GameField[i][j].CellType==FREE)
              {
                reveal(i, j);
              }
            }
            if (mouseButton==RIGHT)
            {
              if (GameField[i][j].Flagged)
              {
                GameField[i][j].Flagged=false;
                CurrentFlags--;
              } else
              {
                if (CurrentFlags<MaxFlags)
                {
                  GameField[i][j].Flagged=true;
                  CurrentFlags++;
                }
              }
            }
          }
        }
      }
    }
  } else
  {
    if (inMenu)
    {
      if ((mouseX>150-40-16&&mouseX<150-40+16)&&(mouseY>190-20&&mouseY<190+20))
      {
        w--;
        if (w<=9)
          w=40;
      }
      if ((mouseX>150+40-16&&mouseX<150+40+16)&&(mouseY>190-20&&mouseY<190+20))
      {
        w++;
        if (w>=41)
          w=10;
      }
      if ((mouseX>350-40-16&&mouseX<350-40+16)&&(mouseY>190-20&&mouseY<190+20))
      {
        h--;
        if (h<=9)
          h=25;
      }
      if ((mouseX>350+40-16&&mouseX<350+40+16)&&(mouseY>190-20&&mouseY<190+20))
      {
        h++;
        if (h>=26)
          h=10;
      }
      if ((mouseX>250-40&&mouseX<250+40)&&(mouseY>270-20&&mouseY<270+20))
      {
        inMenu=false;
        GameFieldWidth=w+2;
        GameFieldHeight=h+2;
        BombNumber=GameFieldWidth*GameFieldHeight/10;
        MaxFlags=1+floor(BombNumber*1.1);
        CellWidth=40;
        CellHeight=40;
        textSize(40);
        GameField=new Cell[GameFieldHeight][GameFieldWidth];
        BombX=new int[BombNumber+1];
        BombY=new int[BombNumber+1];
        SetGameField();
        surface.setSize(int(CellWidth*w), int(CellHeight*h));
        gamePlaying=true;
      }
    }
  }
}
void reveal(int i, int j)
{
  if ((i>=1&&i<=GameFieldHeight-2)&&(j>=1&&j<=GameFieldWidth-2)&&!GameField[i][j].Revealed)
  {
    if (GameField[i][j].CellType!=BOMB&&GameField[i][j].Flagged==false)
    {
      GameField[i][j].Revealed=true;
      if (GameField[i][j].CellType!=NUMBER)
      {
        reveal(i-1, j);
        reveal(i-1, j-1);
        reveal(i-1, j+1);
        reveal(i, j-1);
        reveal(i, j+1);
        reveal(i+1, j);
        reveal(i+1, j-1);
        reveal(i+1, j+1);
      }
    }
  }
}
