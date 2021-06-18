class MainEnviroment{

    int state; //shows state of game 
    int MENU_PAGE = 1; int GAME_PAGE = 2; int SCORE_PAGE = 3; int GAMEOVER_PAGE = 4; //stages
    MenuEnviroment menu;
    GameEnviroment game;
    

    MainEnviroment(){
        state = MENU_PAGE;
        menu = new MenuEnviroment(this);
        game = new GameEnviroment(this);
    }

    void update(PVector mouse, PVector screenSize){
        switch (state) {

            case MENU_PAGE:
            menu.update(mouse, screenSize);
            menu.render();
            break;

            case GAME_PAGE:
            game.update(mouse, screenSize);
            game.render();
            break;

        }
    }
}