
void setup()
{
  size(300, 300);
  surface.setResizable(true);
  strokeWeight(3);
  textAlign(CENTER, CENTER);
}
void draw()
{
  if (gamePlaying)
  {
    surface.setSize(int(CellWidth*w), int(CellHeight*h));
    background(100);
    DrawGameField(0, 0);
    CheckWin();
  } else
  {
    if (inMenu)
    {
      surface.setSize(500, 300);
      background(255);
      textSize(32);
      fill(0);
      text("Cells", 250, 50);
      text('W', 150, 150);
      text('H', 350, 150);
      text(w, 150, 190);
      text(h, 350, 190);
      text('-', 150-40, 190);
      text('+', 150+40, 190);
      text('-', 350-40, 190);
      text('+', 350+40, 190);
      text("Play", 250, 270);
    }
  }
}
