class GUI
{
  Manager man;
  int selected;
  int frameIndex;
  float radius;
  boolean running;
  boolean justPressed;

  GUI(Manager man)
  {
    this.selected = 0;
    frameIndex = 0;
    this.man = man;
    radius = 10;
    running = true;
    justPressed = false;
  }

  void update()
  {
    if (mousePressed)
    {
      if (frameIndex % 2 == 0)
      {
        gui.mouseDown();
      }
      frameIndex ++;
    }
    else
    {
      frameIndex = 0;
      justPressed = false;
    }

    show();
  }

  void show()
  {
    float diameter = radius * 2;
    float space = diameter + 10;

    for (int i = 0; i < man.types.size(); i++)
    {
      fill(man.types.get(i).c);
      noStroke();

      if (selected == i)
      {
        stroke(255);
        strokeWeight(3);
      }

      ellipse(space + i * space, space, diameter, diameter);
      noStroke();
    }

    fill(255, 0, 0);
    ellipse(width - space, space, diameter, diameter);

    fill(0, 255, 0);
    ellipse(width - 2 * space, space, diameter, diameter);

    noFill();
    stroke(255);
    strokeWeight(3);
    ellipse(width - 3 * space, space, diameter, diameter);
  }

  void mouseDown()
  {
    float diameter = radius * 2;
    float space = diameter + 10;

    PVector pos = new PVector(mouseX, mouseY);
    for (int i = 0; i < man.types.size(); i++)
    {
      if (pos.dist(new PVector(space + i * space, space)) <= diameter)
      {
        selected = i;
        mouse.selected = false;
        return;
      }
    }

    if (pos.dist(new PVector(width-space, space)) <= diameter)
    {
      man.particles.clear();
      return;
    }

    if (pos.dist(new PVector(width - 2 * space, space)) <= diameter && !justPressed)
    {
      justPressed = true;
      running = !running;
      return;
    }

    if (pos.dist(new PVector(width - 3 * space, space)) <= diameter)
    {
      mouse.selected = true;
      return;
    }

    if (!mouse.selected)
    {
      man.addParticle(selected, mouseX, mouseY);
    }
  }
}
