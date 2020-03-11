Cell[][]cells;
Particle[]particles;
int cellSize=100;
PVector gravity=new PVector(0,0.1);
void setup() {
  size(800,600,P2D);
  particles= new Particle[1000];
  cells=new Cell[width/cellSize][height/cellSize];
   for(int i=0;i<cells.length;i++) {
    for(int j=0;j<cells[i].length;j++) {
      cells[i][j]=new Cell(i*cellSize,j*cellSize);
    }
    }
  for(int i=0;i<particles.length;i++) {
    int x = (int)random(-width/2+100,width/2-100)+width/2;
    int y = (int)random(-height/2+100,height/2-100)+height/2;
  particles[i]=new Particle(x,y,random(5,8),i);
  cells[x/cellSize][y/cellSize].arr.add(particles[i]);
  particles[i].cellX=x/cellSize;
  particles[i].cellY=y/cellSize;
  }
}
  
void draw() {
  background(0);

PVector mouse = new PVector(mouseX,mouseY);
  for(int i=0;i<particles.length;i++) {
    if(mousePressed) {
    PVector force = PVector.sub(particles[i].pos,mouse);

     force.x=1/(force.x+80)*2;
     force.y=1/(force.y+80)*2;
     particles[i].applyForce(force);
    }
    particles[i].applyForce(gravity);
     
    particles[i].update();
    particles[i].borders();
    particles[i].show();
   int x= (int)particles[i].pos.x/cellSize;
   int y= (int)particles[i].pos.y/cellSize;
   int cellX=particles[i].cellX;
   int cellY=particles[i].cellY;
  //check where am i
   if(!cells[cellX][cellY].contains(particles[i])) {
     int index = cells[cellX][cellY].findParticle(particles[i]);
     cells[cellX][cellY].arr.remove(index);
     cells[x][y].arr.add(particles[i]);
     particles[i].cellX=x;
     particles[i].cellY=y;
     }
     //doing collision in our cell and the neighbouring cells
  for(int n=-1;n<=1;n++) {
    for(int m=-1;m<=1;m++) {
      if(x+n>=0 && x+n<width/cellSize && y+m>=0 && y+m<height/cellSize) {
      for(int j=0;j<cells[x+n][y+m].arr.size();j++) {
      //particles[i].collision(particles[j]);
       particles[i].collision(cells[x+n][y+m].arr.get(j));
      }
      }
    }
  }
  } 
  println(particles.length);
  println(frameRate);
  for(int i=0;i<cells.length;i++) {
    for(int j=0;j<cells[i].length;j++) {
      cells[i][j].show();
    }
  }
 // println(frameRate);
}
