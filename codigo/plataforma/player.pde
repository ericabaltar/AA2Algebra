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
  
  PImage playerImage;

  
 // Constructor
  Player(){
    
    w=100;
    h=65;
    x=400;
    y=150;
    vx=0;
    vy=0;
    
    accelerationX=0;
    accelerationY=0;
    speedLimit = 15;
    isOnGround=false;
    jumpForce = -50; // Para ajustar la fuerza del salto
    
    friction=0.96;
    bounce=-0.7;
    gravity = 0.3;
    
    halfWidth=w/2;
    halfHeight=h/2;
    
    collisionSide="";
  
  }
  
  
  //Movimiento
  void update(){
    
    if(left&&!right){
       accelerationX=-0.2;
       friction=1;
       
    }
    if(right&&!left){
       accelerationX=0.2;
       friction=1;
       
    }
    if(!left&&!right){
      accelerationX=0;
    
    }
    if(up&&!down){
      //accelerationY=-0.2;
      //gravity=0;
      vy=jumpForce;
      isOnGround=false;
      friction=1;
    
    if(up&&!down&&isOnGround){
      vy=jumpForce;
      isOnGround=false;
      friction=1;
    }
      
    }
    if(down&&!up){
      //accelerationY=0.2;
      //friction=1;
     
    }
    if(!up&&!down){
      //accelerationY=0;
    }
    
    if(!up&&!down&&!left&&!right){
      friction=0.96;
     // gravity=0.3;
    }
    
    //Velocidad maxima
    vx+=accelerationX;
    vy+=accelerationY;
    
    vx*=friction;
    //vy*=friction;
    
    vy+=gravity;
    
    if(vx>speedLimit){
      vx=speedLimit;
    }
    if(vx<-speedLimit){
      vx=-speedLimit;
    }
    if(vy>3*speedLimit){
      vy=3*speedLimit;
    }
    if(vy<-speedLimit){
      vy=-speedLimit;
    }
    if(abs(vx)<0.2){
      vx=0;
    }
    
    //Mover al jugador
    x+=vx;
    y+=vy;
    
    checkBoundaries();

  }

void checkBoundaries(){
  //Left
  if(x<0){
    vx*=bounce;
    x=0;
  }
  //Right
  if(x+w>width){
    vx*=bounce;
    x=width-w;
  }
  //Top
  if(y<0){
    vy*=bounce;
    y=0;
  }
  if(y+h>height){
    isOnGround=true;
    vy=0;
    y=height-h;
  }
}
 
 void display(){
 image(playerImage, x, y, w, h);
 }
 
 void jump() {
    if (isOnGround) { // Solo salta si está en el suelo
      vy = jumpForce;
      isOnGround = false;
    }
  }
}
