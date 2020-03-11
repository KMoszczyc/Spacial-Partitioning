class Particle {
 PVector pos,vel,acc;
 float r;
 int id;
 int  cellX,cellY;

   Particle(float x, float y, float r,int id) {
    pos=new PVector(x,y);
    vel=new PVector(random(-3,3),random(-3,3));
    acc=new PVector();
    this.r=r;
    this.id=id;
   }
   
   boolean collision(Particle b) {
     
      if (id == b.id)
        return false;
        
      float distance = pos.dist(b.pos);
      if(distance>=r+b.r) return false;
      
       //setting collided particles to the edge of the collision
      float overlap = 0.5f*(distance - r - b.r);
      float newX = overlap*(pos.x-b.pos.x)/distance;
      float newY = overlap*(pos.y-b.pos.y)/distance;
      pos.sub(newX,newY);
      b.pos.add(newX,newY);
      
      distance = pos.dist(b.pos);
      //normal and tangental vector;
      PVector N = PVector.sub(b.pos,pos).div(distance);
      float nx = (b.pos.x -pos.x)/distance;
      float ny = (b.pos.y -pos.y)/distance;
 
      
      PVector K = PVector.sub(vel,b.vel); 
      float p = 2*(nx*K.x + ny*K.y)/(r+b.r);
      vel.x = vel.x - p*b.r*nx;
      vel.y = vel.y - p*b.r*ny;
      b.vel.x = b.vel.x + p*r*nx;
      b.vel.y = b.vel.y + p*r*ny;
      
      //energy loss after collision
      vel.mult(0.995);
      b.vel.mult(0.995);
        return true;
   }
    void applyForce(PVector force) {
     acc.add(force); 
    }
   void update() {
     vel.add(acc);
    // vel.limit(5);
   // vel.mult(0.9);
     pos.add(vel);
     acc.mult(0);
   }
   void show() {
    // fill(0,20,230);
     noStroke();
    ellipse(pos.x,pos.y,r*2,r*2);
   }
   void borders(){
    if(pos.x+r>=width){
    vel.x*=-1;
    pos.x=width-r;
    }
    if(pos.x-r<=0){
      vel.x*=-1;
      pos.x=r;
    }
    if(pos.y+r>=height) {
    vel.y*=-1;
     pos.y=height-r;
    }
    if(pos.y-r<=0){
      vel.y*=-1;
      pos.y=r;
    }
   }
}
