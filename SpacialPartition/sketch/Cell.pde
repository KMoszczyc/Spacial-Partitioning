class Cell {
 PVector pos;
 ArrayList<Particle>arr;
 color col;
   Cell(int x, int y) {
    pos= new PVector(x,y); 
    col = color(random(255),random(255),random(255));
    arr=new ArrayList<Particle>();
   }
  void show() {
   noFill();
   stroke(col);
   strokeWeight(1);
   rect(pos.x,pos.y,cellSize,cellSize); 
   fill(col);
   noStroke();
   for(Particle p:arr){
    p.show(); 
   }
  }
  boolean contains(Particle p) {
   return p.pos.x>=pos.x && p.pos.x<=pos.x + cellSize &&
         p.pos.y>=pos.y && p.pos.y<=pos.y + cellSize;
  }
  int findParticle(Particle p) {
    for(int i=0;i<arr.size();i++){
   if(arr.get(i).id==p.id)
   return i;
   }
    return -1;
  }
}