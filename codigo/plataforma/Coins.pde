class Coin {
  float x, y;
  float w, h;
  boolean collected;
  PImage coinImage;

  Coin(float _x, float _y, float _w, float _h, String imagePath) {
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    collected = false;
    coinImage = loadImage(imagePath);
  }

  void display() {
    if (!collected) {
      image(coinImage, x, y, w, h);
    }
  }

  boolean intersects(Player player) {
    if (!collected && player.x + player.w > x && player.x < x + w && player.y + player.h > y && player.y < y + h) {
      collected = true;
      score++; // Aumenta el puntaje cuando se recolecta una moneda
      return true;
    }
    return false;
  }
  
  // Método para actualizar la posición de la moneda
  void update(float newX, float newY) {
    x = newX;
    y = newY;
  }
}
