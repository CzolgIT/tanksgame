#ifndef Menu_h
#define Menu_h

#include "Main.h"

class Menu : public Scene
{
public:

    Menu(Text* t , Configuration* c );
    void handleEvents( float frameTime );
    void draw( float frameTime );

private:

    int selected;
    Texture* button;
    Texture* logo;

};

#endif
