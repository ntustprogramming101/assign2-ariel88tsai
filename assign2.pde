PImage bg,groundhogldle,life,soil,soldier,cabbage,
title,startNormal,startHovered,gameover,restartNormal,restartHovered;

final int Game_Start = 0;
final int Game_Run = 1;
final int Game_Lose = 2;
int gameState = Game_Start;

float soldierX,soldierY,soldierWidth = 80;
float ghogX,ghogY,ghogWidth = 80;
float cabX,cabY,cabWidth = 80;
float x = 0,spacingX = 70;

int lifeAmount = 2;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
  groundhogldle = loadImage("img/groundhogIdle.png");
  life = loadImage("img/life.png");
  soil = loadImage("img/soil.png");
  soldier = loadImage("img/soldier.png");
  soldierY = 160+ 80 * floor(random(0,3));
  title = loadImage("img/title.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  gameover = loadImage("img/gameover.jpg");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  cabbage = loadImage("img/cabbage.png");
  
  cabX = 0+ 80 * floor(random(0,7));
  cabY = 160+ 80 * floor(random(0,3));
  ghogX = 320;
  ghogY = 80;
}

void draw() {
	// Switch Game State
  switch(gameState){
		case Game_Start:
    if(mouseX > 248 && mouseY >360 && mouseX < 392 && mouseY < 420){
      image(startHovered,248,360);
      if(mousePressed) gameState = Game_Run;
    }else{
    image(title,0,0);
    image(startNormal,248,360);
    }
    break;
    
		case Game_Run:
    image(bg,0,0);
    //grass
    noStroke();
    fill(124,204,25);
    rect(0,145,640,15);
    //sun
    fill(255,255,0);
    ellipse(590,50,130,130);
    fill(253,184,19);
    ellipse(590,50,120,120);
    //life
    for(int c = 0; c < lifeAmount; c++){
      image(life,10+(50+20)*c,10);
    }//(life, first lifeX + (lifeWidth + space between lives)*c)
    
    //soil
    image(soil,0,160);
    //groundHog 
    image(groundhogldle,ghogX,ghogY);
    //cabbage
    image(cabbage,cabX,cabY);
    //soldier animation
    image(soldier,soldierX,soldierY);
    soldierX = (soldierX + 4) % 720;
    
    //ghog touch soldier 
    if(soldierX < ghogX+ghogWidth && soldierX+soldierWidth > ghogX
    && soldierY < ghogY+ghogWidth && soldierY+soldierWidth > ghogY){
       ghogX = 320;
       ghogY = 80;
       lifeAmount--;
    }
    
    //ghog eat cabbage
    if(cabX < ghogX+ghogWidth && cabX+cabWidth > ghogX
    && cabY < ghogY+ghogWidth && cabY+cabWidth > ghogY){
      cabX = -80;
      cabY = -80;
      lifeAmount++;
    }
    
    //lose game
    if(lifeAmount <= 0)gameState = Game_Lose;
    break;
    
		case Game_Lose:
    if(mouseX > 248 && mouseY >360 && mouseX < 392 && mouseY < 420){
      image(restartHovered,248,360);
      if(mousePressed) gameState = Game_Run;
      ghogX = 320;
      ghogY = 80;  
      lifeAmount = 2;
      cabX = 0+ 80 * floor(random(0,7));
      cabY = 160+ 80 * floor(random(0,3));
    }else{
    image(gameover,0,0);
    image(restartNormal,248,360);
    }
    break;
  }
}

//ghog move
void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case LEFT:
      ghogX -= 80;
      if(ghogX < 0)ghogX = 0;
      break;
      case RIGHT:
      ghogX += 80;
      if(ghogX > 640-ghogWidth)ghogX = 640-ghogWidth;
      break;
      case DOWN:
      ghogY += 80;
      if(ghogY > 480-ghogWidth)ghogY = 480-ghogWidth;
      break;
    }
  }
}
