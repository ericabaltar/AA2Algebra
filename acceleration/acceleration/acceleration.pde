//Acceleration 

//Variables
Player p;

boolean left, right, up, down, space;


//Setup
void setup(){
size(900,700);

left=false;
right=false;
up=false;
down=false;
space=false;

//player values

p=new Player();
  
}

//Draw
void draw(){
background(#F0A7E4);
p.update();
p.display();
}

//Functions
void keyPressed(){
switch(keyCode){
  
case 37:
  left=true;
  break;

case 39:
  right=true;
  break;
  
case 38:
  up=true;
  break;
  
case 40:
  down=true;
  break;
  
case 32:
  space=true;
  break;
 
  }
}

void keyReleased(){
  switch(keyCode){
  
case 37:
  left=false;
  break;

case 39:
  right=false;
  break;
  
case 38:
  up=false;
  break;
  
case 40:
  down=false;
  break;
  
case 32:
  space=false;
  break;
 
  }
}
 
