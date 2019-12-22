Manager man;
Mouse mouse;
GUI gui;

void setup()
{
  size(1280, 778);
  noStroke();
  
  man = new Manager();
  man.randomTypes();
  man.randomParticles(200, 400);
  
  gui = new GUI(man);
  mouse = new Mouse();
}

void draw()
{
  background(0);
  gui.update();
  mouse.update();
  man.update();
}
