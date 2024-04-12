class Player{
  
  //Variables
  
  float w,h,x,y,vx,vy;
  float accelerationX;
  float accelerationY;
  float speedLimit;
  
  float friction;
  float bounce;
  float gravity;
  
  boolean isOnGround;
  float jumpForce;
  
  float halfWidth;
  float halfHeight;
  
  String collisionSide;
  
  Player(){
    
    w=100;
    h=65;
    x=400;
    y=150;
    vx=0;
    vy=0;
    accelerationX=0;
    accelerationY=0;
    speedLimit=5;
    isOnGround=false;
    jumpForce=-10;
    
    friction=0.96;
    bounce=-0.7;
    gravity=3;
    
    halfWidth=w/2;
    halfHeight=h/2;
    
    collisionSide="";
  
  }
  
  
  //Movimiento
  void update(){
    if(left&&!right){
       accelerationX=-0.2;
    }
    if(right&&!left){
       accelerationX=0.2;
    }
    if(!left&&!right){
      accelerationX=0;
    
    }
    if(up&&!down){
      accelerationY=-0.2;
    }
    if(down&&!up){
      accelerationY=0.2;
    }
    if(!up&&!down){
      accelerationY=0;
    }
    
    //Velocidad maxima
    vx+=accelerationX;
    vy+=accelerationY;
    
    if(vx>speedLimit){
      vx=speedLimit;
    }
    if(vx<-speedLimit){
      vx=-speedLimit;
    }
    if(vy>speedLimit){
      vy=speedLimit;
    }
    if(vy<-speedLimit){
      vy=-speedLimit;
    }
    
    //Mover al jugador
    x+=vx;
    y+=vy;

  }

 
 void display(){
   fill(0,255,0,128);
   rect(x,y,w,h);
 }
}
