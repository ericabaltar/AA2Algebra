// Variables
Player p;
ArrayList<Platform> platforms;
int numPlatforms = 3; // Número inicial de plataformas
float platformSpeed = 1; // Velocidad de las plataformas
PImage backgroundImage;
int score = 0; // Puntuación del jugador
boolean left, right, up, down, space; // Declarar las variables de teclas




// Setup
void setup(){
  size(700, 600);
  
  // Cargar imágenes
  backgroundImage = loadImage("nube.gif");
  
  // Inicializar jugador
  p = new Player();
  p.playerImage = loadImage("kitty.png");
  
  // Inicializar lista de plataformas con tres plataformas
  platforms = new ArrayList<Platform>();
  for (int i = 0; i < numPlatforms; i++) {
    float x = random(width - 200); // Posición X aleatoria
    float y = random(height); // Posición Y aleatoria
    float w = 200; // Ancho fijo
    float h = 25; // Altura fija
    platforms.add(new Platform(x, y, w, h, "safe", "platform.png"));
  }
}

// Draw
void draw(){
  image(backgroundImage, 0, 0, width, height);
  
  // Actualizar y mostrar jugador
  p.update();
  p.display();
  
  // Actualizar y mostrar plataformas
  for (int i = platforms.size() - 1; i >= 0; i--) {
    Platform platform = platforms.get(i);
    platform.moveDown(platformSpeed);
    platform.display();
    
    // Eliminar plataformas que están fuera de la pantalla
    if (platform.y > height) {
      platforms.remove(i);
    }
  }
  
  // Generar nueva plataforma solo si hay menos de tres en pantalla
  if (platforms.size() < 3) {
    float x = random(width - 200); // Posición X aleatoria
    float minY = height; // Inicializar con la posición Y más baja
    for (Platform platform : platforms) {
      minY = min(minY, platform.y); // Encontrar la posición Y más baja
    }
    float y = minY - random(150, 300); // Posición Y basada en la posición más baja
    float w = 200; // Ancho fijo
    float h = 25; // Altura fija
    platforms.add(0, new Platform(x, y, w, h, "safe", "platform.png"));
  }
  
  p.checkCollision(platforms);
  displayScore();
}

// Muestra la puntuación en pantalla
void displayScore() {
  fill(255);
  textSize(24);
  textAlign(RIGHT);
  text("Score: " + score, width - 20, 40);
}

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
