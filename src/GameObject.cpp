#include "Main.h"

GameObject::GameObject(SDL_Renderer * ren, float x, float y, int width, int height)
{
    this->x = x;
    this->y = y;
    this->width = width;
    this->height = height;
    this->renderer = ren;
}

Collider GameObject::collider(){

    Collider col(x,y,width,height);
    return col;
}