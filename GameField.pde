boolean gamePlaying=false;
boolean inMenu=true;
final int BOMB=1;
final int NUMBER=2;
final int FREE=3;
int w=20, h=20;
int MaxFlags;
int CurrentFlags=0;
int GameFieldWidth;
int GameFieldHeight;
int BombNumber;
Cell[][] GameField;
float CellHeight;
float CellWidth;
int[] BombX;
int[] BombY;
public class Cell
{
  int CellType=3;
  boolean Revealed=false;
  int x, y;
  int NumberValue;
  boolean Flagged=false;
}
void SetGameField()
{
  CurrentFlags=0;
  int ct=0;
  for (int i=0; i<GameFieldHeight; i++)
  {
    for (int j=0; j<GameFieldWidth; j++)
    {
      GameField[i][j]=new Cell();
      GameField[i][j].x=i;
      GameField[i][j].y=j;
      GameField[i][j].CellType=FREE;
      GameField[i][j].Revealed=false;
    }
  }
  while (ct<BombNumber)
  {
    int x=floor(random(1, GameFieldWidth-1));
    int y=floor(random(1, GameFieldHeight-1));
    while (GameField[y][x].CellType==BOMB)
    {
      x=floor(random(1, GameFieldWidth-1));
      y=floor(random(1, GameFieldHeight-1));
    }
    BombX[ct]=x;
    BombY[ct]=y;
    GameField[y][x].CellType=BOMB;
    GameField[y-1][x-1].NumberValue++;
    GameField[y-1][x].NumberValue++;
    GameField[y-1][x+1].NumberValue++;
    GameField[y][x-1].NumberValue++;
    GameField[y][x+1].NumberValue++;
    GameField[y+1][x-1].NumberValue++;
    GameField[y+1][x].NumberValue++;
    GameField[y+1][x+1].NumberValue++;
    if (GameField[y-1][x-1].CellType!=BOMB)
      GameField[y-1][x-1].CellType=NUMBER;
    if (GameField[y-1][x].CellType!=BOMB)
      GameField[y-1][x].CellType=NUMBER;
    if (GameField[y-1][x+1].CellType!=BOMB)
      GameField[y-1][x+1].CellType=NUMBER;
    if (GameField[y][x-1].CellType!=BOMB)
      GameField[y][x-1].CellType=NUMBER;
    if (GameField[y][x+1].CellType!=BOMB)
      GameField[y][x+1].CellType=NUMBER;
    if (GameField[y+1][x-1].CellType!=BOMB)
      GameField[y+1][x-1].CellType=NUMBER;
    if (GameField[y+1][x].CellType!=BOMB)
      GameField[y+1][x].CellType=NUMBER;
    if (GameField[y+1][x+1].CellType!=BOMB)
      GameField[y+1][x+1].CellType=NUMBER;
    ct++;
  }
}
void DrawGameField(int startX, int startY)
{
  rectMode(CORNER);
  for (int i=1; i<GameFieldHeight-1; i++)
  {
    for (int j=1; j<GameFieldWidth-1; j++)
    {
      if (GameField[i][j].Revealed==true)
      {
        noStroke();
        fill(200);
        rect(startX+(j-1)*CellWidth+1, startY+(i-1)*CellHeight+1, CellWidth-1, CellHeight-1);
        stroke(0);
        switch (GameField[i][j].CellType)
        {
        case NUMBER:
          fill(200);
          fill(0);
          text(GameField[i][j].NumberValue, startX+(j-1)*CellHeight+CellHeight/2, startY+(i-1)*CellWidth+CellWidth/2-4);
          break;
        case BOMB:
          fill(0);
          rect(startX+(j-1)*CellWidth+5, startY+(i-1)*CellHeight+5, CellWidth-10, CellHeight-10);
          break;
        }
      } else
      {
        stroke(0);
        fill(#CB21FF);
        rect(startX+(j-1)*CellWidth, startY+(i-1)*CellHeight, CellWidth, CellHeight);
        if (GameField[i][j].Flagged)
        {
          fill(255);
          rect(startX+(j-1)*CellWidth+5, startY+(i-1)*CellHeight+5, CellWidth-10, CellHeight-10);
        }
      }
    }
  }
}
void CheckWin()
{
  boolean win=true;
  for (int i=0; i<BombNumber; i++)
  {
    if (!GameField[BombY[i]][BombX[i]].Flagged)
    {
      win=false;
    }
  }
  if (win)
  {
    gamePlaying=false;
    background(0);
    fill(255);
    textSize(100);
    text("You Win", width/2, height/2);
  }
}
