#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
//Pink Tile=+1
//Red Tile=+2
//Blue Tile=+3
//Teal Tile = +5    
volatile int pixel_buffer_start; // global variable


void plot_pixel(int x, int y, short int line_color);
void clear_screen();
void updateValue_Player1();
void updateValue_Player2();
void draw_line(int x0, int y0, int x1, int y1, short int line_color);
void swap(int *x, int *y);
void v_sync_wait();
void player1win();
void player2win();

//Global Players
    int Player1_X=300;
    int Player1_Y=212;
	int Money1=0;

    
    int Player2_X=300;
    int Player2_Y=225;
	int Money2=0;

   
    
    
bool player1=false;
bool player2=false;
int main(void)
{
    srand(time(NULL));
    //Flags
    
 	
    //Rotations for player 1
    bool left=true;
    bool up=false;
    bool right=false;
    bool down=false;
    bool gameover=false;
    
    //Rotations for player 2
    bool left2=true;
    bool up2=false;
    bool right2=false;
    bool down2=false;
    bool Player2_done=false;
    int turn=0; 
    int dice=0;
    
    int increment=1;
        
    volatile int*HEX5_6_ptr=0xFF20020;
    
    
volatile int *pixel_ctrl_ptr = (int *)0xFF203020;
    /* Read location of the pixel buffer from the pixel buffer controller */
    pixel_buffer_start = *pixel_ctrl_ptr;
	
	//Drawing the board
    
    clear_screen();
    
     
    
    //Outer Borders
   draw_line(0, 0, 319,0 , 0xFFFF);  
      draw_line(0, 0, 0,239 , 0xFFFF);
      draw_line(0, 239, 319,239 , 0xFFFF);
      draw_line(319, 0, 319,239 , 0xFFFF);
     
   
    
    //Top Line Border
    for (int i=30 ; i <33 ; i++){
    draw_line(30, i, 289, i, 0xFFFF);   
    }
    //Left Side Border
    for (int j=30 ; j <33 ; j++) {
     draw_line(j, 30, j, 209, 0xFFFF);     
    }
    
    //Bottom Line Border
    for (int j=207 ; j <210 ; j++) {
     draw_line(30, j, 289, j, 0xFFFF);     
    }
    //Right Side Border
    for (int j=287 ; j <290 ; j++) {
     draw_line(j, 30, j, 209, 0xFFFF);     
    }
    
   
    // Drawing the Squares for bottom half
    for (int i=289 ; i <320 ; i++){
    draw_line(i, 209, i, 239, 0xF500);   // this line is Orange
    }
    
    for (int i=259 ; i <289 ; i++){
    draw_line(i, 209, i, 239, 0x001F);   // this line is blue
    }
    for (int i=229 ; i <259 ; i++){
    draw_line(i, 209, i, 239, 0xF800);   // this line is Red
    }
    for (int i=199 ; i <229 ; i++){
    draw_line(i, 209, i, 239, 0x07FF);   // this line is Teal
    }
     for (int i=169 ; i <199 ; i++){
    draw_line(i, 209, i, 239, 0x001F);   // this line is blue
    }
     for (int i=139 ; i <169 ; i++){
    draw_line(i, 209, i, 239, 0xF800);   // this line is Red
    }
     for (int i=109 ; i <139 ; i++){
    draw_line(i, 209, i, 239, 0xF81F);   // this line is Pink
    }
     for (int i=79; i <109 ; i++){
    draw_line(i, 209, i, 239, 0x001F);   // this line is Blue
    }
     for (int i=49 ; i <79 ; i++){
    draw_line(i, 209, i, 239, 0xF800);   // this line is Red
    }
     for (int i=20 ; i <49 ; i++){
    draw_line(i, 209, i, 239, 0xFFE0);   // this line is Yellow
    }
     for (int i=1 ; i <31 ; i++){
    draw_line(i, 209, i, 239, 0xF800);   // this line is Red
    }
    
   //Left Side Squares
    for (int j=1 ; j <30 ; j++) {
     draw_line(1, j, 30, j, 0x07FF);     
    }
    for (int j=30 ; j <60 ; j++) {
     draw_line(1, j, 30, j, 0xF81F);     
    }
     for (int j=60 ; j <90 ; j++) {
     draw_line(1, j, 30, j, 0xF800);     
    }
    for (int j=90 ; j <120 ; j++) {
     draw_line(1, j, 30, j, 0x001F);     
    }
    for (int j=120 ; j <150 ; j++) {
     draw_line(1, j, 30, j, 0xF800);     
    }
    for (int j=150 ; j <180 ; j++) {
     draw_line(1, j, 30, j, 0xF81F);     
    }
    for (int j=180 ; j <210 ; j++) {
     draw_line(1, j, 30, j, 0x001F);     
    }
   
    
    //Top Line Squares
    for (int i=30 ; i <60 ; i++){
    draw_line(i, 1, i, 30, 0xF800);   
    }
    for (int i=60 ; i <90 ; i++){
    draw_line(i, 1, i, 30, 0x001F);   
    }
    for (int i=90 ; i <120 ; i++){
    draw_line(i, 1, i, 30, 0xF800);  
    }
    for (int i=120 ; i <150 ; i++){
    draw_line(i, 1, i, 30, 0xF81F);   
    }
    for (int i=150 ; i <180 ; i++){
    draw_line(i, 1, i, 30, 0xF800);  
    }
    for (int i=180 ; i <210 ; i++){
    draw_line(i, 1, i, 30, 0xF81F);   
    }
    for (int i=210 ; i <240 ; i++){
    draw_line(i, 1, i, 30, 0xF800);   
    }
    for (int i=240 ; i <270 ; i++){
    draw_line(i, 1, i, 30, 0x001F);   
    }
    
    for (int i=270 ; i <290 ; i++){
    draw_line(i, 1, i, 30, 0xFFE0);   
    }
    for (int i=290 ; i <320 ; i++){
    draw_line(i, 1, i, 30, 0x001F);   
    }
    
    //Right Side Squares
    
    for (int j=30 ; j <60 ; j++) {
     draw_line(290, j, 319, j, 0x07FF);     
    }
    for (int j=60 ; j <90 ; j++) {
     draw_line(290, j, 319, j,  0x001F);     
    }
    for (int j=90 ; j <120 ; j++) {
     draw_line(290, j, 319, j, 0xF800);     
    }
    for (int j=120 ; j <150 ; j++) {
     draw_line(290, j, 319, j, 0xF81F);     
    }
    for (int j=150 ; j <180 ; j++) {
     draw_line(290, j, 319, j, 0x07FF);     
    }
    for (int j=180 ; j <210 ; j++) {
     draw_line(290, j, 319, j, 0x001F);     
    }
    
    
    
   
    
    
   // Start Arrow
    draw_line(60, 195, 260, 195, 0xFFFF); 
     for (int i=60 ; i <62 ; i ++){
         for (int j=195 ; j < 197; j ++){
              for (int k=75; k < 77; k ++) {
         		for (int l=205 ; l <207 ; l ++) {
    draw_line(i, j, k, l, 0xFFFF); 
                }
              }
         }
     }
    for (int i=60 ; i <62 ; i ++){
         for (int j=195 ; j < 197; j ++){
              for (int k=75; k < 77; k ++) {
         		for (int l=185 ; l <207 ; l ++) {
    draw_line(i, j, k, l, 0xFFFF); 
                }
              }
         }
     }
    
    //Finish Arrow
   	draw_line(270, 45, 270, 180, 0xFFFF); 
    for (int i=270 ; i <272 ; i ++){
         for (int j=180 ; j < 182; j ++){
              for (int k=260; k < 262; k ++) {
         		for (int l=170 ; l <172 ; l ++) {
     draw_line (i,j,k,l, 0xFFFF); 
                }
              }
         }
    }
    for (int i=270 ; i <272 ; i ++){
         for (int j=180 ; j < 182; j ++){
              for (int k=260; k < 282; k ++) {
         		for (int l=170 ; l <172 ; l ++) {
     draw_line (i,j,k,l, 0xFFFF); 
                }
              }
         }
    }
     for (int i=270 ; i <272 ; i ++){
         for (int j=180 ; j < 182; j ++){
              for (int k=280; k < 282; k ++) {
         		for (int l=170 ; l <172 ; l ++) {
     draw_line (i,j,k,l, 0xFFFF); 
                }
              }
         }
    }
    
    // Start
    //S
   draw_line(140, 175, 150, 175, 0xFFFF);
   draw_line(140, 182, 150, 182, 0xFFFF);
   draw_line(140, 189, 150, 189, 0xFFFF);
   draw_line(140, 175, 140, 182, 0xFFFF);
   draw_line(150, 182, 150, 190, 0xFFFF);
   //T
   draw_line(155, 175, 165, 175, 0xFFFF);
   draw_line(160, 175, 160, 190, 0xFFFF);
   //A
   draw_line(166, 190, 175, 175, 0xFFFF);
   draw_line(175, 175, 184, 190, 0xFFFF);
   draw_line(170, 183, 180, 183, 0xFFFF); 
    
    //R
    draw_line(188, 175, 188, 190, 0xFFFF);
    draw_line(188, 175, 198, 175, 0xFFFF);
    draw_line(198, 175, 198, 183, 0xFFFF);
    draw_line(188, 183, 199, 183, 0xFFFF);
  	draw_line(188, 183, 199, 190, 0xFFFF);
    //T
    draw_line(205, 175, 215, 175, 0xFFFF);
   	draw_line(210, 175, 210, 190, 0xFFFF);
    
    
    //End
    //E
     draw_line(250, 80, 260, 80, 0xFFFF);
     draw_line(250, 90, 260, 90, 0xFFFF);
     draw_line(250, 100, 260, 100, 0xFFFF);
     draw_line(250, 80, 250, 100, 0xFFFF);
    //N
     draw_line(250, 105, 250, 125, 0xFFFF);
     draw_line(250, 105, 260, 125, 0xFFFF);
     draw_line(260, 105, 260, 125, 0xFFFF);
    //D
    draw_line(250, 130, 250, 150, 0xFFFF);
   	draw_line(250, 130, 260, 134, 0xFFFF);
    draw_line(260, 134, 260, 146, 0xFFFF);
    draw_line(250, 150, 260, 146, 0xFFFF);
    
    //NOPOLY
    //N
    draw_line(80, 40, 80, 70, 0xF800);
    draw_line(90, 40, 90, 70, 0xF800);
    draw_line(80, 40, 90, 70, 0xF800);
    //O
    draw_line(95, 40, 105, 40, 0x001F);
    draw_line(95, 40, 95, 70, 0x001F);
    draw_line(105, 40, 105, 70, 0x001F);
    draw_line(95, 70, 106, 70, 0x001F);
    //P
    
    draw_line(110, 40, 110, 70, 0xF81F);
    draw_line(110, 40, 125, 40, 0xF81F);
    draw_line(125, 40, 125, 55, 0xF81F);
    draw_line(110, 55, 125, 55, 0xF81F);
    //O
    draw_line(130, 40, 140, 40, 0x001F);
    draw_line(130, 40, 130, 70, 0x001F);
    draw_line(140, 40, 140, 70, 0x001F);
    draw_line(130, 70, 141, 70, 0x001F);
    //L
    draw_line(145, 40, 145, 70, 0x07FF);
    draw_line(145, 70, 155, 70, 0x07FF);
    //Y
    draw_line(165, 50, 165, 70, 0xFFE0);
    draw_line(155, 40, 165, 50, 0xFFE0);
    draw_line(165, 50, 175, 40, 0xFFE0);
   
    
    
    
   
  
    
   
        
        
    //Conditions for dice Roll
    
    

     
    
   
    
   
   
    //draw_line(319, 0, 0, 239, 0xF81F);   // this line is a pink color
    while (true){
      
    dice= ((rand()% 3) +1);
      //Boundaries for Player 1  
       if ((Player1_X<=15) && (Player1_Y==212)){
            up=true; 
        	left=false;
       }
       if ((Player1_Y<=20) && (Player1_X<=15)){
        up=false;
        right=true;
          
       }
         if ((Player1_X>=290) && (Player1_Y<=20)){
           right=false;
            down=true;
        }
        
        if ((Player1_X>=290) && (Player1_Y>=203)){
        down=false;
        }
        
        //Boundaries for Player 2
        if ((Player2_X<=3) && (Player2_Y==225)){
            up2=true; 
        	left2=false;
       }
        
       if ((Player2_X<=15) && (Player2_Y<=20)){
           right2=true;
           up2=false;
       }
       if ((Player2_X>=300) && (Player2_Y<=15)){
           right2=false;
           down2=true;
       }
        if ((Player2_X>=305) && (Player2_Y>=203)) {
            down2=false;
       }
        
        
      
	//Player 1
         if (turn%2==0){
        if (left){
            if (dice==1){
           if (((Player1_X <=1) && (Player1_X>31)) && (Player1_Y>209)){ //At the last red tile
                  Player1_Y=Player1_Y-30;
        			for (int i=Player1_X; i < Player1_X+10; i ++)
        			for (int j=Player1_Y; j < Player1_Y+10; j ++)
        			plot_pixel(i,j, 0x07E0); 
                 updateValue_Player1();   
                 left=false;
                    up=true;
                }
          else {
              Player1_X=Player1_X-30;  
    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
              updateValue_Player1();
          }
            }
            if (dice==2){
                if (((Player1_X <=1) && (Player1_X>31)) && (Player1_Y>209)){ //At the last red tile
                  Player1_Y=Player1_Y-60;
        			for (int i=Player1_X; i < Player1_X+10; i ++)
        			for (int j=Player1_Y; j < Player1_Y+10; j ++)
        			plot_pixel(i,j, 0x07E0); 
                 updateValue_Player1();   
                 left=false;
                    up=true;
                }
                else if ((Player1_X >=20)&& (Player1_X<49) && (Player1_Y>209)){ //At the Yellow Tile
                	Player1_X=Player1_X-25;
                 Player1_Y=Player1_Y-30;    
    	for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);    
                  updateValue_Player1();  
                    left=false;
                    up=true;
                } 
                
                
            else { Player1_X=Player1_X-60;  
    	for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                updateValue_Player1();
                 }
            }
            if (dice==3){
                if (((Player1_X <=1) && (Player1_X>31)) && (Player1_Y>209)){ //At the last red tile
                  Player1_Y=Player1_Y-90;
        			for (int i=Player1_X; i < Player1_X+10; i ++)
        			for (int j=Player1_Y; j < Player1_Y+10; j ++)
        			plot_pixel(i,j, 0x07E0); 
                 updateValue_Player1();   
                 left=false;
                    up=true;
                }
                
                else if ((Player1_X >=20)&& (Player1_X<49) && (Player1_Y>209)){ //At the Yellow Tile
                	Player1_X=Player1_X-20;
                 Player1_Y=Player1_Y-60;    
    	for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);    
                  updateValue_Player1();  
                    left=false;
                    up=true;
                }
                else if ((Player1_X>=49) && (Player1_X<79) && (Player1_Y>209)){  //At the Red Tile
                 Player1_X=Player1_X-50;
                    Player1_Y=Player1_Y-30; 
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);    
                  updateValue_Player1();  
                    left=false;
                    up=true;
                }
                
             else { 
                 Player1_X=Player1_X-90;  
    	for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
               updateValue_Player1();
             }
              
            }  
            
        }
             
        if (up){
            if (dice==1){
                if ((Player1_Y>1) && (Player1_Y<30) && (Player1_X <30)){ //At the teal tile
                     Player1_X=Player1_X+30;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true;
                  }  
                
                
                else {
                Player1_Y=Player1_Y-30;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                 updateValue_Player1();
                }
            }
              if (dice==2){
                if ((Player1_Y>1) && (Player1_Y<30) && (Player1_X <30)){ //At the teal tile
                     Player1_X=Player1_X+60;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true;
                  }  
                   else if ((Player1_Y>30) && (Player1_Y<60) && (Player1_X<30)){ //At the pink tile
                   Player1_Y=Player1_Y-30;
                   Player1_X=Player1_X+30;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true; 
                 }
                 else {
                     
                     Player1_Y=Player1_Y-60;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                 }
            }
              if (dice==3){
                	 
                  if ((Player1_Y>1) && (Player1_Y<30) && (Player1_X <30)){ //At the teal tile
                     Player1_X=Player1_X+90;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true;
                  }
                 else if ((Player1_Y>30) && (Player1_Y<60) && (Player1_X<30)){ //At the pink tile
                   Player1_Y=Player1_Y-30;
                   Player1_X=Player1_X+60;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true; 
                 }
               else if ((Player1_Y>60) && (Player1_Y<90) && (Player1_X<30)) {  //Red Tile
                   Player1_Y=Player1_Y-60;
                   Player1_X=Player1_X+30;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
                      up=false;
                      right=true; 
       
               }
               else {   
                  Player1_Y=Player1_Y-90;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                   updateValue_Player1();
               }
            }
        }
            
        if (right){
            if (dice==1){
                if ((Player1_X >=290) && (Player1_X <320) && (Player1_Y <30)) { //At the blue tile
                 Player1_Y=Player1_Y+30;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                
                
                else {
                Player1_X=Player1_X+30;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0); 
                 updateValue_Player1();
                }
            }
            if (dice==2){
                if ((Player1_X >=290) && (Player1_X <320) && (Player1_Y <30)) { //At the blue tile
                 Player1_Y=Player1_Y+60;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                else if ((Player1_X >=270) && (Player1_X <290) && (Player1_Y <30)) { //At the Yellow tile 
                 Player1_X=Player1_X+25;
                  Player1_Y=Player1_Y+30;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                   
                
                else {
                Player1_X=Player1_X+60;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                }
            }
            if (dice==3){
                if ((Player1_X >=290) && (Player1_X <320) && (Player1_Y <30)) { //At the blue tile
                 Player1_Y=Player1_Y+90;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                else if ((Player1_X >=270) && (Player1_X <290) && (Player1_Y <30)) { //At the Yellow tile 
                 Player1_X=Player1_X+25;
                  Player1_Y=Player1_Y+60;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                else if ((Player1_X >=240) && (Player1_X <270) && (Player1_Y <30)) { //At the Blue tile 
                 Player1_X=Player1_X+55;
                  Player1_Y=Player1_Y+30;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                    right=false;
                    down=true;
                }
                
                else {
                Player1_X=Player1_X+90;
        for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                }
            }
            
            
            
        }
        if (down){
            if (dice==1) {
                if ((Player1_Y>=180) && (Player1_Y<210) && (Player1_X>290)){ //At the blue tile
                  down=false; 
                    player1=true;
                }
                else {
                Player1_Y=Player1_Y+30;  
         for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player1();
                }
            }
             if (dice==2) {
                 if ((Player1_Y>=180) && (Player1_Y<210) && (Player1_X>290)){ //At the blue tile
                  down=false;
                     player1=true;
                 }
                 else if ((Player1_Y>=150) && (Player1_Y<180) && (Player1_X>290)){ //At the teal tile
                  down=false;
                     player1=true;
                 }
                 
                 else {
                Player1_Y=Player1_Y+60;  
         for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                  updateValue_Player1();
                 }
            }
             if (dice==3) {
                 if ((Player1_Y>=180) && (Player1_Y<210) && (Player1_X>290)){ //At the blue tile
                  down=false;   
                     player1=true;
                 }
                 else if ((Player1_Y>=150) && (Player1_Y<180) && (Player1_X>290)){ //At the teal tile
                  down=false; 
                     player1=true;
                 }
                else if ((Player1_Y>=120) && (Player1_Y<150) && (Player1_X>290)){ //At the pink tile
                  down=false; 
                    player1=true;
                 }
                 
                else { 
                    Player1_Y=Player1_Y+90;  
         for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player1_Y; j < Player1_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                  updateValue_Player1();
                }
            }
            
        }
       
         }
        if (turn%2!=0){
        //Player2
        if (left2){
            if (dice==1) {
                 if ((Player2_X<=1) && (Player2_X>31) && (Player2_Y>209)){ //Red Tile
                 Player2_Y=Player2_Y-30;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                    
                }
                
                
                
                else {
                 Player2_X=Player2_X-30; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                }
                 
            }
             if (dice==2) {
                  if ((Player2_X<=1) && (Player2_X>31) && (Player2_Y>209)){ //Red Tile
                 Player2_Y=Player2_Y-55;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                    
                }
                 else if ((Player2_X>=20) && (Player2_X<49) && (Player2_Y>209)){ //Yellow Tile
                 Player2_X=Player2_X-25;
                    Player2_Y=Player2_Y-30;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                }
               
                 else {
                 Player2_X=Player2_X-55; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                  updateValue_Player2();
                 }
                     
                
            }
            if (dice==3) {
               
                if ((Player2_X<=1) && (Player2_X>31) && (Player2_Y>209)){ //Red Tile
                 Player2_Y=Player2_Y-90;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                    
                }
              
                  else if ((Player2_X>=20) && (Player2_X<49) && (Player2_Y>209)){ //Yellow Tile
                                       

                 Player2_X=Player2_X-25;
                    Player2_Y=Player2_Y-60;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                }
                
                else if ((Player2_X>=49) && (Player2_X<79) && (Player2_Y>209)){ //Red Tile
                 Player2_X=Player2_X-55;
                    Player2_Y=Player2_Y-30;
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        		for (int j=Player2_Y; j < Player2_Y+10; j ++)
        		plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                 left2=false;
                    up2=true;
                }
                
                
                else{
                 Player2_X=Player2_X-90; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                   
                }
            }
        }
        if (up2){
            if (dice==1){
                  if ((Player2_Y>1) && (Player2_Y<30) && (Player2_X <30)){ //At the teal tile
                     Player2_Y=Player2_X+30;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true;
                  }
                      
                else {
                Player2_Y=Player2_Y-30;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                }
            }
             if (dice==2){
                 if ((Player2_Y>1) && (Player2_Y<30) && (Player2_X <30)){ //At the teal tile
                     Player2_X=Player2_X+30;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true;
                 }
                 else if ((Player2_Y>30) && (Player2_Y<60) && (Player2_X<30)){ //At the pink tile
                   Player2_Y=Player2_Y-35;
                   Player2_X=Player2_X+30;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true; 
                 }
                 
                 else {
                Player2_Y=Player2_Y-60;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                  updateValue_Player2();
                 }
            }
             if (dice==3){
                 if ((Player2_Y>1) && (Player2_Y<30) && (Player2_X <30)){ //At the teal tile
                     Player2_X=Player2_X+90;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true;
                  }
                 else if ((Player2_Y>30) && (Player2_Y<60) && (Player2_X<30)){ //At the pink tile
                   Player2_Y=Player2_Y-30;
                   Player2_X=Player2_X+60;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true; 
                 }
               else if ((Player2_Y>60) && (Player2_Y<90) && (Player2_X<30)) {  //Red Tile
                   Player2_Y=Player2_Y-60;
                   Player2_X=Player2_X+30;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                   updateValue_Player2();
                      up2=false;
                      right2=true; 
       
               } 
           else {      
                Player2_Y=Player2_Y-90;
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                  updateValue_Player2();
           }
            }
            
            
        }
        if (right2){
            if (dice==1){
                if ((Player2_X >=290) && (Player2_X <320) && (Player2_Y <30)) { //At the blue tile
                 Player2_Y=Player2_Y+90;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                
                else {
                 Player2_X=Player2_X+30; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                }
            }
             if (dice==2){
                 if ((Player2_X >=290) && (Player2_X <320) && (Player2_Y <30)) { //At the blue tile
                 Player2_Y=Player2_Y+60;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                 else if ((Player2_X >=270) && (Player2_X <290) && (Player2_Y <30)) { //At the Yellow tile 
                 Player2_X=Player2_X+25;
                  Player2_Y=Player2_Y+30;    
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                 
                 else {
                 Player2_X=Player2_X+60; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                  updateValue_Player2();
                 }
            }
             if (dice==3){
                 if ((Player2_X >=290) && (Player2_X <320) && (Player2_Y <30)) { //At the blue tile
                 Player2_Y=Player2_Y+90;    
                    for (int i=Player1_X; i < Player1_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                else if ((Player2_X >=270) && (Player2_X <290) && (Player2_Y <30)) { //At the Yellow tile 
                 Player2_X=Player2_X+25;
                  Player2_Y=Player2_Y+60;    
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                else if ((Player2_X >=240) && (Player2_X <270) && (Player2_Y <30)) { //At the Blue tile 
                 Player2_X=Player2_X+55;
                  Player2_Y=Player2_Y+30;    
                    for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0x07E0);
                 updateValue_Player2();
                    right2=false;
                    down2=true;
                }
                 Player2_X=Player2_X+90; 
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                  updateValue_Player2();
            }
            
        }
        if (down2){
            if (dice==1){
                if ((Player2_Y>=180) && (Player2_Y<210) && (Player2_X>290)){ //At the blue tile
                  down2=false; 
                    player2=true;
                 }
                else {
                 Player2_Y=Player2_Y+30;  
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                 updateValue_Player2();
                }
            }
            if (dice==2){
                if ((Player2_Y>=180) && (Player2_Y<210) && (Player2_X>290)){ //At the blue tile
                  down2=false;
                    player2=true;
                 }
                else if ((Player2_Y>=150) && (Player2_Y<180) && (Player2_X>290)){ //At the teal tile
                  down2=false; 
                    player2=true;
                 }
                else {
                 Player2_Y=Player2_Y+60;  
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64); 
                 updateValue_Player2();
                }
                
            }
            if (dice==3){
                 if ((Player2_Y>=180) && (Player2_Y<210) && (Player2_X>290)){ //At the blue tile
                  down2=false; 
                     player2=true;
                     
                 }
                 else if ((Player2_Y>=150) && (Player2_Y<180) && (Player2_X>290)){ //At the teal tile
                  down2=false; 
                     player2=true;
                 }
                else if ((Player2_Y>=120) && (Player2_Y<150) && (Player2_X>290)){ //At the pink tile
                  down2=false; 
                    player2=true;
                 }
                
                else {
                 Player2_Y=Player2_Y+90;  
        for (int i=Player2_X; i < Player2_X+10; i ++)
        for (int j=Player2_Y; j < Player2_Y+10; j ++)
        plot_pixel(i,j, 0xEC64);
                }
                 updateValue_Player2();
            }
            
        }
        }
        turn++;
        
//       if ((player1==true) && (player2==true)){
//       if (Money1>Money2){
//        player1win();
//           break;
//        }
//        else  if (Money2>Money1){
//           player2win();   
//            break;
//          }
//       }
      	
       v_sync_wait();
        
    }  
}




void v_sync_wait() {
    volatile int *pixel_ctrl_ptr = (int *)0xFF203020;   
    *pixel_ctrl_ptr = 1;
    volatile int *status = pixel_ctrl_ptr + 3;
    while(1) {
        if((*status & 1) == 0) break;
    } 
}

// code not shown for clear_screen() and draw_line() subroutines
void clear_screen() {
    int i=0, j=0;
    for(i = 0; i < 320; i++) {
        for(j = 0; j < 240; j++) {
            plot_pixel(i, j, 0x0000);
        }
    }
    return;
}

void draw_line(int x0, int y0, int x1, int y1, short int line_color) {
    bool is_steep = abs(y1 - y0) > abs (x1 - x0);
    if(is_steep) {
        swap(&x0, &y0);
        swap(&x1, &y1);
    }
    if(x0 > x1) {
        swap(&x0, &x1);
        swap(&y0, &y1);
    }

    int deltax = x1 - x0;
    int deltay = abs(y1 - y0);
    int error = -(deltax / 2);
    int y = y0;
    int y_step;

    if(y0 < y1) {
        y_step = 1;
    }
    else {
        y_step = -1;
    }

    int x;
    for(x = x0; x <= x1; x++) {
        if(is_steep)
            plot_pixel(y, x, line_color);
        else
            plot_pixel(x, y, line_color);
        error += deltay;
        if(error >= 0) {
            y += y_step;
            error -= deltax;
        }
    }
    return;
}

void plot_pixel(int x, int y, short int line_color){
    *(short int *)(pixel_buffer_start + (y << 10) + (x << 1)) = line_color;
    return;
}

void swap(int *x, int *y) {
    int temp = *x;
    *x = *y;
    *y = temp;
    return;
}

void updateValue_Player1(){
//For Player 1 Bottom 
    if (((Player1_X<289) && (Player1_X>=259)) && (Player1_Y==212)) //Blue Tile
        Money1=Money1 +3;
    else if (((Player1_X<259) && (Player1_X>=229)) && (Player1_Y==212)) //Red Tile
        Money1=Money1+2;
    else if (((Player1_X<229) && (Player1_X>=199)) && (Player1_Y==212)) //Teal Tile
    	Money1=Money1 +5;
	else if (((Player1_X<199)  && (Player1_X>=169)) && (Player1_Y==212)) //Blue Tile
        Money1=Money1+3;
    else if (((Player1_X<169) && (Player1_X>=139)) && (Player1_Y==212)) //Red Tile
        Money1=Money1+2;
      else if (((Player1_X<139) && (Player1_X>=109)) && (Player1_Y==212)) //Pink Tile
        Money1=Money1+1;
    else if (((Player1_X<109)  && (Player1_X>=79)) && (Player1_Y==212)) //Blue Tile
        Money1=Money1+3;
    else if (((Player1_X<79) && (Player1_X>=49)) && (Player1_Y==212)) //Red Tile
        Money1=Money1+2;
    else if (((Player1_X<31)&& (Player1_X>=1)) && (Player1_Y==212)) // Red Tile
        Money1=Money1+2;
    
    //For Player 1 Left Side
    
    if (((Player1_Y>=1) && (Player1_Y<30)) && (Player1_X==15)) //Teal Tile
        Money1=Money1+5;
     else if (((Player1_Y>=30) && (Player1_Y<60)) && (Player1_X==15))  //Pink Tile
        Money1=Money1+1;
     else if (((Player1_Y>=60) && (Player1_Y<90)) && (Player1_X==15))  //Red Tile
        Money1=Money1+2; 
      else if (((Player1_Y>=90) && (Player1_Y<120)) && (Player1_X==15))  //Blue Tile
        Money1=Money1+3; 
      else if (((Player1_Y>=120) && (Player1_Y<150)) && (Player1_X==15))  //Red Tile
        Money1=Money1+2;  
       else if (((Player1_Y>=150) && (Player1_Y<180)) && (Player1_X==15))  //Pink Tile
        Money1=Money1+1;
      else if (((Player1_Y>=180) && (Player1_Y<210)) && (Player1_X==15))  //Blue Tile
        Money1=Money1+3;  
    
    //For Player 1 Top Side
    if (((Player1_X>=30) && (Player1_X<60)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Red Tile 
        Money1=Money1+2;
    else  if (((Player1_X>=60) && (Player1_X<90)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Blue Tile 
        Money1=Money1+3;
     else  if (((Player1_X>=90) && (Player1_X<120)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Red Tile 
        Money1=Money1+2;
     else  if (((Player1_X>=120) && (Player1_X<150)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Pink Tile 
        Money1=Money1+1;
    else  if (((Player1_X>=150) && (Player1_X<180)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Red Tile 
        Money1=Money1+2;
    else  if (((Player1_X>=180) && (Player1_X<210)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Pink Tile 
        Money1=Money1+1;
    else  if (((Player1_X>=210) && (Player1_X<240)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Red Tile 
        Money1=Money1+2;
    else  if (((Player1_X>=240) && (Player1_X<270)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Blue Tile 
        Money1=Money1+3;
    else  if (((Player1_X>=290) && (Player1_X<320)) && ((Player1_Y>=1) && (Player1_Y<=30))) //Pink Tile 
        Money1=Money1+1;
    
    //For Player 1 Right Side 
   
    	if (((Player1_Y>=30) && (Player1_Y<60)) && ((Player1_X>=290) && (Player1_X<=319))) //Teal Tile
            Money1=Money1+5;
        else if (((Player1_Y>=60) && (Player1_Y<90)) && ((Player1_X>=290) && (Player1_X<=319))) //Blue Tile
            Money1=Money1+3;
     	else if (((Player1_Y>=90) && (Player1_Y<120)) && ((Player1_X>=290) && (Player1_X<=319))) //Red Tile
            Money1=Money1+2; 
    	 else if (((Player1_Y>=120) && (Player1_Y<150)) && ((Player1_X>=290) && (Player1_X<=319))) //Pink Tile
            Money1=Money1+1;    
     	else if (((Player1_Y>=150) && (Player1_Y<180)) && ((Player1_X>=290) && (Player1_X<=319))) //Teal Tile
            Money1=Money1+5;
     	else if (((Player1_Y>=180) && (Player1_Y<210)) && ((Player1_X>=290) && (Player1_X<=319))) //Blue Tile
            Money1=Money1+3;       
}

void updateValue_Player2(){
 //For Player 2 Bottom 
    if (((Player2_X<289) && (Player2_X>=259)) && (Player2_Y==225)) //Blue Tile
        Money2=Money2 +3;
    else if (((Player2_X<259) && (Player2_X>=229)) && (Player2_Y==225)) //Red Tile
        Money2=Money2+2;
    else if (((Player2_X<229) && (Player2_X>=199)) && (Player2_Y==225)) //Teal Tile
    	Money2=Money2 +5;
	else if (((Player2_X<199)  && (Player2_X>=169)) && (Player2_Y==225)) //Blue Tile
        Money2=Money2+3;
    else if (((Player2_X<169) && (Player2_X>=139)) && (Player2_Y==225)) //Red Tile
        Money2=Money2+2;
      else if (((Player2_X<139) && (Player2_X>=109)) && (Player2_Y==225)) //Pink Tile
        Money2=Money2+1;
    else if (((Player2_X<109)  && (Player2_X>=79)) && (Player2_Y==225)) //Blue Tile
        Money2=Money2+3;
    else if (((Player2_X<79) && (Player2_X>=49)) && (Player2_Y==225)) //Red Tile
        Money2=Money2+2;
    else if (((Player2_X<31)&& (Player2_X>=1)) && (Player2_Y==225)) // Red Tile
        Money2=Money2+2;
    
    //For Player 2 Left Side
    
    if (((Player2_Y>=1) && (Player2_Y<30)) && (Player2_X==15)) //Teal Tile
        Money2=Money2+5;
     else if (((Player2_Y>=30) && (Player2_Y<60)) && (Player2_X==15))  //Pink Tile
        Money2=Money2+1;
     else if (((Player2_Y>=60) && (Player2_Y<90)) && (Player2_X==15))  //Red Tile
        Money2=Money2+2; 
      else if (((Player2_Y>=90) && (Player2_Y<120)) && (Player2_X==15))  //Blue Tile
        Money2=Money2+3; 
      else if (((Player2_Y>=120) && (Player2_Y<150)) && (Player2_X==15))  //Red Tile
        Money2=Money2+2;  
       else if (((Player2_Y>=150) && (Player2_Y<180)) && (Player2_X==15))  //Pink Tile
        Money2=Money2+1;
      else if (((Player2_Y>=180) && (Player2_Y<210)) && (Player2_X==15))  //Blue Tile
        Money2=Money2+3;   
    
    //For Player 2 Top Side
    if (((Player2_X>=30) && (Player2_X<60)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Red Tile 
        Money2=Money2+2;
    else  if (((Player2_X>=60) && (Player2_X<90)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Blue Tile 
        Money2=Money2+3;
     else  if (((Player2_X>=90) && (Player2_X<120)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Red Tile 
        Money2=Money2+2;
     else  if (((Player2_X>=120) && (Player2_X<150)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Pink Tile 
        Money2=Money2+1;
    else  if (((Player2_X>=150) && (Player2_X<180)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Red Tile 
        Money2=Money2+2;
    else  if (((Player2_X>=180) && (Player2_X<210)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Pink Tile 
        Money2=Money2+1;
    else  if (((Player2_X>=210) && (Player2_X<240)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Red Tile 
        Money2=Money2+2;
    else  if (((Player2_X>=240) && (Player2_X<270)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Blue Tile 
        Money2=Money2+3;
    else  if (((Player2_X>=290) && (Player2_X<320)) && ((Player2_Y>=1) && (Player2_Y<=30))) //Pink Tile 
        Money2=Money2+1;
     
    //For Player 2 Right Side 
   
    	if (((Player2_Y>=30) && (Player2_Y<60)) && ((Player2_X>=290) && (Player2_X<=319))) //Teal Tile
            Money2=Money2+5;
        else if (((Player2_Y>=60) && (Player2_Y<90)) && ((Player2_X>=290) && (Player2_X<=319))) //Blue Tile
            Money2=Money2+3;
     	else if (((Player2_Y>=90) && (Player2_Y<120)) && ((Player2_X>=290) && (Player2_X<=319))) //Red Tile
            Money2=Money2+2; 
    	 else if (((Player2_Y>=120) && (Player2_Y<150)) && ((Player2_X>=290) && (Player2_X<=319))) //Pink Tile
            Money2=Money2+1;    
     	else if (((Player2_Y>=150) && (Player2_Y<180)) && ((Player2_X>=290) && (Player2_X<=319))) //Teal Tile
            Money2=Money2+5;
     	else if (((Player2_Y>=180) && (Player2_Y<210)) && ((Player2_X>=290) && (Player2_X<=319))) //Blue Tile
            Money2=Money2+3;    
}
void player1win(){
    clear_screen();
     for (int i=0; i <320 ; i++ )
        for (int j=0; j <240 ; j++)
            plot_pixel (i,j, 0xEC64);
    
         for (int i=135; i <210 ; i++ )
        for (int j=75; j <150 ; j++)
            plot_pixel (i,j, 0x07E0);
        
             for (int i=95 ; i <98 ; i++ )
                 for (int j=155; j <158; j++)
                     for (int k=125; k<128; k++) 
                         for (int l=195; l <198; l++)
             draw_line(i,j,k,l,0x07E0);

               for (int i=125 ; i <128 ; i++ )
                 for (int j=195; j <198; j++)
                     for (int k=135; k<138; k++) 
                         for (int l=185; l <188; l++)
             draw_line(i,j,k,l,0x07E0);
             
          
             
            for (int i=135 ; i <138 ; i++ )
                 for (int j=185; j <188; j++)
                     for (int k=145; k<148; k++) 
                         for (int l=195; l <198; l++)
             draw_line(i,j,k,l,0x07E0);

             for (int i=145 ; i <148 ; i++ )
                 for (int j=195; j <198; j++)
                     for (int k=175; k<178; k++) 
                         for (int l=155; l <158; l++)
             draw_line(i,j,k,l,0x07E0);

             for (int i=185 ; i <188 ; i++ )
             draw_line(i,155,i,198,0x07E0);
             
    	for (int i=185 ; i <188 ; i++ )
             draw_line(i,155,i,198,0x07E0);

        for (int i=193 ; i < 196; i++)
             draw_line(i,155,i,198,0x07E0);
    
      for (int i=233 ; i < 236; i++)
             draw_line(i,155,i,198,0x07E0);
    
    	for (int i=193 ; i <196 ; i++ )
                 for (int j=155; j <158; j++)
                     for (int k=233; k<236; k++) 
                         for (int l=198; l <201; l++)
             draw_line(i,j,k,l,0x07E0);
    
    for (int i=150 ; i < 153; i++)
             draw_line(i,85,i,105,0xFFFF);
    
    
    for (int i=195 ; i < 198; i++)
             draw_line(i,85,i,105,0xFFFF);
    
        for (int i=195 ; i < 198; i++)
             draw_line(i,125,i,135,0xFFFF);
     for (int i=135 ; i < 138; i++)
             draw_line(150,i,196,i,0xFFFF);
    for (int i=150 ; i < 153; i++)
             draw_line(i,125,i,135,0xFFFF);
     for (int i=173 ; i < 176; i++)
             draw_line(i,105,i,115,0xFFFF);
   
    return;
    
}

void player2win(){
     clear_screen();
     for (int i=0; i <320 ; i++ )
        for (int j=0; j <240 ; j++)
            plot_pixel (i,j, 0x07FF);
    
         for (int i=135; i <210 ; i++ )
        for (int j=75; j <150 ; j++)
            plot_pixel (i,j, 0xEC64);
        
             for (int i=95 ; i <98 ; i++ )
                 for (int j=155; j <158; j++)
                     for (int k=125; k<128; k++) 
                         for (int l=195; l <198; l++)
             draw_line(i,j,k,l,0xEC64);

               for (int i=125 ; i <128 ; i++ )
                 for (int j=195; j <198; j++)
                     for (int k=135; k<138; k++) 
                         for (int l=185; l <188; l++)
             draw_line(i,j,k,l,0xEC64);
             
          
             
            for (int i=135 ; i <138 ; i++ )
                 for (int j=185; j <188; j++)
                     for (int k=145; k<148; k++) 
                         for (int l=195; l <198; l++)
             draw_line(i,j,k,l,0xEC64);

             for (int i=145 ; i <148 ; i++ )
                 for (int j=195; j <198; j++)
                     for (int k=175; k<178; k++) 
                         for (int l=155; l <158; l++)
             draw_line(i,j,k,l,0xEC64);

             for (int i=185 ; i <188 ; i++ )
             draw_line(i,155,i,198,0xEC64);
             
    	for (int i=185 ; i <188 ; i++ )
             draw_line(i,155,i,198,0xEC64);

        for (int i=193 ; i < 196; i++)
             draw_line(i,155,i,198,0xEC64);
    
      for (int i=233 ; i < 236; i++)
             draw_line(i,155,i,198,0xEC64);
    
    	for (int i=193 ; i <196 ; i++ )
                 for (int j=155; j <158; j++)
                     for (int k=233; k<236; k++) 
                         for (int l=198; l <201; l++)
             draw_line(i,j,k,l,0xEC64);
    
    for (int i=150 ; i < 153; i++)
             draw_line(i,85,i,105,0xFFFF);
    
    
    for (int i=195 ; i < 198; i++)
             draw_line(i,85,i,105,0xFFFF);
    
        for (int i=195 ; i < 198; i++)
             draw_line(i,125,i,135,0xFFFF);
     for (int i=135 ; i < 138; i++)
             draw_line(150,i,196,i,0xFFFF);
    for (int i=150 ; i < 153; i++)
             draw_line(i,125,i,135,0xFFFF);
     for (int i=173 ; i < 176; i++)
             draw_line(i,105,i,115,0xFFFF);
    
    
    return;
 }
