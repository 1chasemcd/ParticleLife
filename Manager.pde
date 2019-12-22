class Manager
{
  ArrayList<Type> types = new ArrayList<Type>();
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  void show()
  {
    for (Particle particle: particles)
    {
      particle.show();
    }
  }
  
  void update()
  {
    for (Particle moving: particles)
    {
      moving.update(particles);
    }
    
    show();
  }
  
  void addParticle(int type, float x, float y)
  {
    particles.add(new Particle(type, new PVector(x, y), types));
  }
  
  void addType(color c, float[] attraction, float[] middle, float[] repelDist)
  {
    types.add(new Type(c, attraction, middle, repelDist, types));
  }
  
  void randomParticles(int num, float rad)
  {
    for (int i = 0; i < num; i++)
    {
      float x = random(-1, 1);
      float y = random(-sqrt(1 - x*x), sqrt(1 - x*x));
      addParticle((int) random(0, types.size()), width/2 + x*rad, height/2 + y*rad);
    }
  }
  
  void randomTypes()
  {
    int len = (int) random(3, 12);
    for (int i = 0; i < len; i++)
    {
      float[] a = makeArray(-3, 3, len);
      float[] m = makeArray(15, 80, len);
      float[] r = makeArray(2, 15, len);
      color c = color(random(0, 255), random(0, 255), random(0, 255));
  
       man.addType(c, a, m, r);
    }
  }
  
  float[] makeArray(float lower, float upper, int len)
  {
    float[] arr = new float[len];
    
    for (int i = 0; i < len; i++)
    {
      arr[i] = random(lower, upper);
    }
    
    return arr;
  }
}
