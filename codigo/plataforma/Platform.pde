class Platform{
  float w,h,x,y;
  String typeof;
  float halfWidth;
  float halfHeight;
  PImage platformImage;
  boolean touched;
  
  Platform(float _x, float _y, float _w, float _h, String _typeof, String imagePath){
    w=_w;
    h=_h;
    x=_x;
    y=_y;
    typeof=_typeof;
    platformImage = loadImage(imagePath);
    halfWidth=w/2;
    halfHeight=h/2;
    touched = true; 
  }
  
  void display(){
    image(platformImage, x, y, w, h);
  }
  
  // Método para mover la plataforma hacia abajo
  void moveDown(float speed){
    y += speed;
  }
}
