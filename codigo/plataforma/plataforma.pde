// Variables
Player p;
ArrayList<Platform> platforms;
int numPlatforms = 3; // Número inicial de plataformas
float platformSpeed = 1; // Velocidad de las plataformas
PImage backgroundImage;
int score = 0; // Puntuación del jugador
boolean left, right, up, down, space; // Declarar las variables de teclas
boolean gameOver = false;

ArrayList<Coin> coins;


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
  
  // Inicializar lista de monedas
  coins = new ArrayList<Coin>();
  
}

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

    // Buscar la moneda asociada a esta plataforma
    Coin coin = null;
    for (Coin c : coins) {
      if (c.x >= platform.x && c.x + c.w <= platform.x + platform.w && c.y + c.h <= platform.y && c.y + c.h >= platform.y - 5) {
        coin = c;
        break;
      }
    }
    
    if (coin != null) {
        coin.update(platform.x + platform.w / 2 - coin.w / 2, platform.y - coin.h); // Actualiza la posición de la moneda
        coin.display();
    }

    // Eliminar plataformas que están fuera de la pantalla
    if (platform.y > height) {
        platforms.remove(i);
        Coin coinToRemove = null;
        for (Coin c : coins) {
          if (c.x >= platform.x && c.x + c.w <= platform.x + platform.w && c.y + c.h <= platform.y && c.y + c.h >= platform.y - 5) {
            coinToRemove = c;
            break;
          }
        }
        if (coinToRemove != null) {
            coins.remove(coinToRemove);
        }
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
    Platform newPlatform = new Platform(x, y, w, h, "safe", "platform.png");
    platforms.add(0, newPlatform);
    
    // Agregar una nueva moneda asociada a la nueva plataforma
    float coinX = x + w / 2 - 25; // Posición X de la moneda centrada en la plataforma
    float coinY = y - 50; // Posición Y de la moneda arriba de la plataforma
    Coin newCoin = new Coin(coinX, coinY, 50, 50, "coin.png"); // Crea una moneda
    coins.add(0, newCoin); // Agrega la moneda a la lista de monedas
  }
  
  // Mostrar y verificar la colisión con las monedas  
  for (int i = coins.size() - 1; i >= 0; i--) {
    Coin coin = coins.get(i);
    coin.display();
    if (coin.intersects(p)) {
        coins.remove(i); // Elimina la moneda de la lista de monedas
        i--; // Decrementa el índice para evitar saltar un elemento después de eliminarlo
    }
  }
  
  p.checkCollision(platforms);

  displayScore();
  
   // Verificar si el jugador ha llegado al fondo de la pantalla
  if (p.y + p.h >= height) {
    gameOver = true;
  }
  
  if (gameOver) {
    background(0);
    fill(255);
    textSize(48);
    textAlign(CENTER, CENTER);
    text("Game Over", width / 2, height / 2);
  }
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
