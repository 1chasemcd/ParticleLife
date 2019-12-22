class Particle
{
  PVector pos;
  Type type;
  float radius = 10;
  
  Particle(int index, PVector pos, ArrayList<Type> list)
  {
    this.pos = pos;
    this.type = list.get(index);
  }
  
  void show()
  {
    fill(type.c);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void update(ArrayList<Particle> particles)
  {
    PVector increase = new PVector();
    
    if (mouse.inMouse(this))
    {
      increase.set(mouse.setPos());
    }
    else if (gui.running)
    {
      for (Particle forcing: particles)
      {
        if (this != forcing)
        {
          increase.add(this.applyForce(forcing));
        }
      }
      
      increase.limit(12);
    }
    
    this.pos.add(increase);
    this.keepInBounds();
  }
  
  PVector applyForce(Particle other)
  {
    float ratio;
    
    if (this.pos.dist(other.pos) == 0)
    {
      ratio = 0;
    }
    else
    {
      ratio = this.forceEq(other) / this.pos.dist(other.pos);
    }
    
    PVector increase = new PVector(ratio * (this.pos.x - other.pos.x), 
                                   ratio * (this.pos.y - other.pos.y));
    return increase;
  }
  
  float forceEq(Particle other)
  {
    float a = this.type.attraction[other.type.index];
    float r = this.type.repelDist[other.type.index];
    float m = this.type.middle[other.type.index];
    float d = this.pos.dist(other.pos);
    
    if (0 <= d && d <= 2 * r)
    {
      return abs((2 * a / (4 * r * r)) * pow(d - 2 * r, 2));
    }
    else if (2 * r <= d && d < m + 2 * r)
    {
      return a / m * d - 2 * r * a / m;
    }
    else if (m + 2 * r <= d && d <= 2 * m + 2 * r)
    {
      return - a / m * d + 2 * m * a / m + 2 * r * a / m;
    }
    
    return 0;
  }
  
  void keepInBounds()
  {
    if (pos.x > width)
    {
      pos.x = width;
    }
    else if (pos.x < 0)
    {
      pos.x = 0;
    }
    
    if (pos.y > height)
    {
      pos.y = height;
    }
    else if (pos.y < 0)
    {
      pos.y = 0;
    }
  }
}
