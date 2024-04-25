//gravedad

//Variables
Player p;
Platform p2;
boolean jumping = false;

boolean left, right, up, down, space;
PImage backgroundImage;

//Setup
void setup(){
size(700,600);
backgroundImage = loadImage("nube.gif");


left=false;
right=false;
up=false;
down=false;
space=false;

//player values

p=new Player();
p.playerImage = loadImage("kitty.png");
p2 = new Platform(300, 460, 200, 25, "safe", "platform.png");

  
}

//Draw
void draw(){
 image(backgroundImage, 0, 0, width, height);
  p.update();
  p.display();
  p2.display();
  
}
//Functions

String rectangleCollisions(Player r1, Platform r2) {
  if (r1.vy < 0) {
    return "none"; // Permite traspasar las plataformas
  }
  float dx = (r1.x + r1.w / 2) - (r2.x + r2.w / 2);
  float dy = (r1.y + r1.h / 2) - (r2.y + r2.h / 2);
  float combinedHalfWidths = r1.halfWidth + r2.halfWidth;
  float combinedHalfHeights = r1.halfHeight + r2.halfHeight;
  if (abs(dx) < combinedHalfWidths) {
    if (abs(dy) < combinedHalfHeights) {
      float overlapX = combinedHalfWidths - abs(dx);
      float overlapY = combinedHalfHeights - abs(dy);
      if (overlapX >= overlapY) {
        if (dy > 0) {
          r1.y += overlapY;
          return "top";
        } else {
          r1.y -= overlapY;
          return "bottom";
        }
      } else {
        if (dx > 0) {
          r1.x += overlapX;
          return "left";
        } else {
          r1.x -= overlapX;
          return "right";
        }
      }
    } else {
      return "none";
    }
  } else {
    return "none";
  }
}


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
