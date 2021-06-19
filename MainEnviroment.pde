class MainEnviroment {

  int state; //shows state of game 
  final int MENU_PAGE = 1; //stages
  final int GAME_PAGE = 2; 
  final int SCORE_PAGE = 3; 
  final int GAMEOVER_PAGE = 4;
  MenuEnviroment menu;
  GameEnviroment game;
  PApplet app;

  MainEnviroment(PApplet app) {
    this.app=app;
    state = MENU_PAGE;
    menu = new MenuEnviroment(this); //passing main screen as object to states can be changed.
    game = new GameEnviroment(this);
  }

  void update(PVector mouse) {
    
    switch (state) { //all states and there methods

    case MENU_PAGE:
      menu.update(mouse);
      menu.render();
      break;

    case GAME_PAGE:
      game.update(mouse);
      game.render();
      break;
     
     
    }
  }

  void setState(int i) {
    state = i;
  }

  PApplet getApp() {
    return app;
  }
}
