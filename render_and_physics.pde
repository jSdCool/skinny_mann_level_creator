//===================================================================================
          int xangle=25+180,yangle=15,dist=700;//camera presets
         float DY=sin(radians(yangle))*dist,hd=cos(radians(yangle))*dist,DX=sin(radians(xangle))*hd,DZ=cos(radians(xangle))*hd;//camera rotation
         
void stageLevelDraw(){
  Stage stage=level.stages.get(currentStageIndex);
  if(stage.type.equals("stage")){
    e3DMode=false;
      camera();
         for(int i=0;stageLoopCondishen(i,stage);i++){
           strokeWeight(0);
           noStroke();
          stage.parts.get(i).draw(); 
         }
         
         
         draw_mann(Scale*(player1.getX()-camPos),Scale*(player1.getY()+camPosY),player1.getPose(),Scale*player1.getScale(),player1.getColor());
         //====================================================================================================================================================================================================
         //====================================================================================================================================================================================================
         //====================================================================================================================================================================================================
         //====================================================================================================================================================================================================
         //====================================================================================================================================================================================================
  }else if(stage.type.equals("3Dstage")){
    if(e3DMode){//render the level in 3D
    camera(player1.x+DX,player1.y-DY,player1.z-DZ,player1.x,player1.y,player1.z,0,1,0);
        directionalLight(255, 255, 255, 0.8, 1, -0.35);
        ambientLight(102, 102, 102);
        coinRotation+=3;
        if(coinRotation>360)
        coinRotation-=360;
      
      for(int i=0;stageLoopCondishen(i,stage);i++){
        strokeWeight(0);
        noStroke();
          stage.parts.get(i).draw3D(); 
         }
         
         draw_mann_3D(player1.x,player1.y,player1.z,player1.getPose(),Scale*player1.getScale(),player1.getColor());
         
         if(shadow3D){
           float shadowAltitude=player1.y;
           boolean shadowHit=false;
           for(int i=0;i<500&&!shadowHit;i++){//ray cast to find solid ground underneath the player
            if(level_colide(player1.x,shadowAltitude+i,player1.z)){
              shadowAltitude+=i;
              shadowHit=true;
              continue;
            }
           }
           if(shadowHit){//if solid ground was found under the player then draw the shadow
            translate(player1.x,shadowAltitude-1,player1.z);
            fill(0,127);
            rotateX(radians(90));
            ellipse(0,0,40,40);
            rotateX(radians(-90));
            translate(-player1.x,-(shadowAltitude-1),-player1.z);
           }
         }

    }else{//redner the level in 2D
    camera();
      for(int i=0;stageLoopCondishen(i,stage);i++){
          stage.parts.get(i).draw(); 
         }
         draw_mann(Scale*(player1.getX()-camPos),Scale*(player1.getY()+camPosY),player1.getPose(),Scale*player1.getScale(),player1.getColor());
    }
  }
         

         if(level_complete){
          textSize(Scale*100);
         fill(255,255,0);
         text("LEVEL COMPLETE!!!",Scale*200,Scale*400);
         
         fill(255,126,0);
         stroke(255,0,0);
         strokeWeight(Scale*10);
         rect(Scale*550,Scale*450,Scale*200,Scale*40);
         fill(0);
         textSize(Scale*40);
         text("continue",Scale*565,Scale*480);
        }
        
}
//////////////////////////////////////////-----------------------------------------------------



void playerPhysics(){


if(!e3DMode){         
         if(player1_moving_right){//move the player right
          float newpos=player1.getX()+mspc*0.2;
          
          if(!level_colide(newpos+10,player1.getY())){
            if(!level_colide(newpos+10,player1.getY()-25)){
              if(!level_colide(newpos+10,player1.getY()-50)){
                if(!level_colide(newpos+10,player1.getY()-75)){
                  player1.setX(newpos);
                }
              }
            }
          }else if((!level_colide(newpos+10,player1.getY()-10)&&!level_colide(newpos+10,player1.getY()-50)&&!level_colide(newpos+10,player1.getY()-75))&&player1.getAirTime()==0){
           if(!level_colide(newpos+10,player1.getY()-1)){//autojump
             player1.setX(newpos);
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(newpos-10,player1.getY()-2)){
             player1.setX(newpos);
             player1.setY(player1.getY()-2);
           }else if(!level_colide(newpos-10,player1.getY()-3)){
             player1.setX(newpos);
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(newpos-10,player1.getY()-4)){
             player1.setX(newpos);
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(newpos-10,player1.getY()-5)){
             player1.setX(newpos);
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(newpos-10,player1.getY()-6)){
             player1.setX(newpos);
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(newpos-10,player1.getY()-7)){
             player1.setX(newpos);
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(newpos-10,player1.getY()-8)){
             player1.setX(newpos);
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(newpos-10,player1.getY()-9)){
             player1.setX(newpos);
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(newpos-10,player1.getY()-10)){
             player1.setX(newpos);
             player1.setY(player1.getY()-10);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//chmage the player pose to make them look like there waljking
            player1.setPose(player1.getPose()+1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==13){
             player1.setPose(1); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(player1_moving_left){//player moving left
          float newpos=player1.getX()-mspc*0.2;
          if(!level_colide(newpos-10,player1.getY())){
            if(!level_colide(newpos-10,player1.getY()-25)){
              if(!level_colide(newpos-10,player1.getY()-50)){
                if(!level_colide(newpos-10,player1.getY()-75)){
                  player1.setX(newpos);
                }
              }
            }
          }else if((!level_colide(newpos-10,player1.getY()-10)&&!level_colide(newpos-10,player1.getY()-50)&&!level_colide(newpos-10,player1.getY()-75))&&player1.getAirTime()==0){
           if(!level_colide(newpos+10,player1.getY()-1)){//auto jump
             player1.setX(newpos);
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(newpos-10,player1.getY()-2)){
             player1.setX(newpos);
             player1.setY(player1.getY()-2);
           }else if(!level_colide(newpos-10,player1.getY()-3)){
             player1.setX(newpos);
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(newpos-10,player1.getY()-4)){
             player1.setX(newpos);
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(newpos-10,player1.getY()-5)){
             player1.setX(newpos);
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(newpos-10,player1.getY()-6)){
             player1.setX(newpos);
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(newpos-10,player1.getY()-7)){
             player1.setX(newpos);
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(newpos-10,player1.getY()-8)){
             player1.setX(newpos);
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(newpos-10,player1.getY()-9)){
             player1.setX(newpos);
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(newpos-10,player1.getY()-10)){
             player1.setX(newpos);
             player1.setY(player1.getY()-10);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//change the playerb pose to make them look lie there walking
            player1.setPose(player1.getPose()-1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==0){
             player1.setPose(12); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(!player1_moving_right&&!player1_moving_left){//reset the player pose if the player is not moving
           player1.setPose(1);
           player1.setAnimationCooldown(4);
         }
         
         
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(!player1_jumping||!player1.isJumping()){//gravity
           float pd=1;
            if(!level_colide(player1.getX()-10,player1.getY()+pd)&&!level_colide(player1.getX()-5,player1.getY()+pd)&&!level_colide(player1.getX(),player1.getY()+pd)&&!level_colide(player1.getX()+5,player1.getY()+pd)&&!level_colide(player1.getX()+10,player1.getY()+pd)){
              pd=mspc*0.2;//gravity movement
              //wasDP=false;
              if(!level_colide(player1.getX()-10,player1.getY()+pd)&&!level_colide(player1.getX()-5,player1.getY()+pd)&&!level_colide(player1.getX(),player1.getY()+pd)&&!level_colide(player1.getX()+5,player1.getY()+pd)&&!level_colide(player1.getX()+10,player1.getY()+pd)){
              player1.setY(player1.getY()+pd);
              player1.setAirTime(60);
              }else{
               while((!level_colide(player1.getX()-10,player1.getY()+pd)&&!level_colide(player1.getX()-5,player1.getY()+pd)&&!level_colide(player1.getX(),player1.getY()+pd)&&!level_colide(player1.getX()+5,player1.getY()+pd)&&!level_colide(player1.getX()+10,player1.getY()+pd))&&pd>0){
                pd--; 
               }
               if(pd>0){
                 player1.setY(player1.getY()+pd);
               }
              }
            }else{
               player1.setAirTime(0);
               
            }
         }
         
         if(player_kill(player1.getX()-10,player1.getY()+1)||player_kill(player1.getX()-5,player1.getY()+1)||player_kill(player1.getX(),player1.getY()+1)||player_kill(player1.getX()+5,player1.getY()+1)||player_kill(player1.getX()+10,player1.getY()+1)){
           dead=true;    
           death_cool_down=0;
         }
         
         
         if(!(!level_colide(player1.getX()-10,player1.getY())&&!level_colide(player1.getX()-5,player1.getY())&&!level_colide(player1.getX(),player1.getY())&&!level_colide(player1.getX()+5,player1.getY())&&!level_colide(player1.getX()+10,player1.getY()))){
           player1.setY(player1.getY()-1);
         }
         
         
         if(player1_jumping){//jumping
          if(player1.getAirTime()==0){
            player1.setJumping(true);
          }
          if(player1.getAirTime()<14&&player1.isJumping()){//jumping
            float pp=(0.1953333*mspc);
            if(!level_colide(player1.getX()-10,player1.getY()-75-pp)&&!level_colide(player1.getX()-5,player1.getY()-75-pp)&&!level_colide(player1.getX(),player1.getY()-75-pp)&&!level_colide(player1.getX()+5,player1.getY()-75-pp)&&!level_colide(player1.getX()+10,player1.getY()-75-pp)){
              player1.setY(player1.getY()-pp);
              player1.setAirTime(player1.getAirTime()+mspc*0.010);
              player1.jumpDist+=pp;
            }else{
              player1.setJumping(false);
              player1.jumpDist=0;
            }
          }else{
            if(player1.getAirTime()<16&&player1.isJumping()){
              player1.setAirTime(player1.getAirTime()+mspc*0.010);
              //player1.setY(player1.getY()+(player1.jumpDist-293));
              player1.jumpDist=293;//in the futchre use this varible to judge wether the jump is at the max height
            }else{
            player1.setJumping(false);
            player1.jumpDist=0;
            }
          }
         }else{
           player1.setJumping(false);
           player1.jumpDist=0;
         }
         
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(player1.getX()-camPos>(1280-eadgeScroleDist)){
           camPos=(int)(player1.getX()-(1280-eadgeScroleDist));
         }
         
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(player1.getX()-camPos<eadgeScroleDist&&camPos>0){
           camPos=(int)(player1.getX()-eadgeScroleDist);
         }
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(player1.getY()+camPosY>720-eadgeScroleDistV&&camPosY>0){
           camPosY-=player1.getY()+camPosY-(720-eadgeScroleDistV);
         }  
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(player1.getY()+camPosY<eadgeScroleDistV+75){
           camPosY-=player1.getY()+camPosY-(eadgeScroleDistV+75);
           
         }
         if(camPos<0)
         camPos=0;
         if(camPosY<0)
         camPosY=0;
         
         
    }else{//end of not 3D mode


         if(player1_moving_right){//move the player right
          float newpos=player1.getX()+mspc*0.2;
          
          if(!level_colide(newpos+10,player1.getY(),player1.z-7)&&!level_colide(newpos+10,player1.getY(),player1.z+7)){
            if(!level_colide(newpos+10,player1.getY()-25,player1.z-7)&&!level_colide(newpos+10,player1.getY()-25,player1.z+7)){
              if(!level_colide(newpos+10,player1.getY()-50,player1.z-7)&&!level_colide(newpos+10,player1.getY()-50,player1.z+7)){
                if(!level_colide(newpos+10,player1.getY()-75,player1.z-7)&&!level_colide(newpos+10,player1.getY()-75,player1.z+7)){
                  player1.setX(newpos);
                }
              }
            }
          }else if((!level_colide(newpos+10,player1.getY()-10,player1.z)&&!level_colide(newpos+10,player1.getY()-50,player1.z)&&!level_colide(newpos+10,player1.getY()-75,player1.z))&&player1.getAirTime()==0){
           if(!level_colide(newpos+10,player1.getY()-1,player1.z)){//autojump
             player1.setX(newpos);
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(newpos-10,player1.getY()-2,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-2);
           }else if(!level_colide(newpos-10,player1.getY()-3,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(newpos-10,player1.getY()-4,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(newpos-10,player1.getY()-5,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(newpos-10,player1.getY()-6,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(newpos-10,player1.getY()-7,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(newpos-10,player1.getY()-8,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(newpos-10,player1.getY()-9,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(newpos-10,player1.getY()-10,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-10);
           }
           else if(!level_colide(newpos-10,player1.getY()-11,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-11);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//chmage the player pose to make them look like there waljking
            player1.setPose(player1.getPose()+1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==13){
             player1.setPose(1); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(player1_moving_left){//player moving left
          float newpos=player1.getX()-mspc*0.2;
          if(!level_colide(newpos-10,player1.getY(),player1.z-7)&&!level_colide(newpos-10,player1.getY(),player1.z+7)){
            if(!level_colide(newpos-10,player1.getY()-25,player1.z-7)&&!level_colide(newpos-10,player1.getY()-25,player1.z+7)){
              if(!level_colide(newpos-10,player1.getY()-50,player1.z-7)&&!level_colide(newpos-10,player1.getY()-50,player1.z+7)){
                if(!level_colide(newpos-10,player1.getY()-75,player1.z-7)&&!level_colide(newpos-10,player1.getY()-75,player1.z+7)){
                  player1.setX(newpos);
                }
              }
            }
          }else if((!level_colide(newpos-10,player1.getY()-10,player1.z)&&!level_colide(newpos-10,player1.getY()-50,player1.z)&&!level_colide(newpos-10,player1.getY()-75,player1.z))&&player1.getAirTime()==0){
           if(!level_colide(newpos+10,player1.getY()-1,player1.z)){//auto jump
             player1.setX(newpos);
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(newpos-10,player1.getY()-2,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-2);
           }else if(!level_colide(newpos-10,player1.getY()-3,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(newpos-10,player1.getY()-4,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(newpos-10,player1.getY()-5,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(newpos-10,player1.getY()-6,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(newpos-10,player1.getY()-7,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(newpos-10,player1.getY()-8,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(newpos-10,player1.getY()-9,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(newpos-10,player1.getY()-10,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-10);
           }
           else if(!level_colide(newpos-10,player1.getY()-11,player1.z)){
             player1.setX(newpos);
             player1.setY(player1.getY()-11);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//change the playerb pose to make them look lie there walking
            player1.setPose(player1.getPose()-1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==0){
             player1.setPose(12); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(WPressed){
           float newpos=player1.z-mspc*0.2;
          if(!level_colide(player1.x,player1.getY(),newpos-10)){
            if(!level_colide(player1.x,player1.getY()-25,newpos-10)){
              if(!level_colide(player1.x,player1.getY()-50,newpos-10)){
                if(!level_colide(player1.x,player1.getY()-75,newpos-10)){
                  player1.z=newpos;
                }
              }
            }
          }else if((!level_colide(player1.x,player1.getY()-10,newpos-10)&&!level_colide(player1.x,player1.getY()-50,newpos-10)&&!level_colide(player1.x,player1.getY()-75,newpos-10))&&player1.getAirTime()==0){
           if(!level_colide(player1.x,player1.getY()-1,newpos-10)){//auto jump
             player1.z=newpos;
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(player1.x,player1.getY()-2,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-2);
           }else if(!level_colide(player1.x,player1.getY()-3,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(player1.x,player1.getY()-4,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(player1.x,player1.getY()-5,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(player1.x,player1.getY()-6,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(player1.x,player1.getY()-7,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(player1.x,player1.getY()-8,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(player1.x,player1.getY()-9,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(player1.x,player1.getY()-10,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-10);
           }
           else if(!level_colide(player1.x,player1.getY()-11,newpos-10)){
             player1.z=newpos;
             player1.setY(player1.getY()-11);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//change the playerb pose to make them look lie there walking
            player1.setPose(player1.getPose()-1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==0){
             player1.setPose(12); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(SPressed){
           float newpos=player1.z+mspc*0.2;
          if(!level_colide(player1.x,player1.getY(),newpos+10)){
            if(!level_colide(player1.x,player1.getY()-25,newpos+10)){
              if(!level_colide(player1.x,player1.getY()-50,newpos+10)){
                if(!level_colide(player1.x,player1.getY()-75,newpos+10)){
                  player1.z=newpos;
                }
              }
            }
          }else if((!level_colide(player1.x,player1.getY()-10,newpos+10)&&!level_colide(player1.x,player1.getY()-50,newpos+10)&&!level_colide(player1.x,player1.getY()-75,newpos+10))&&player1.getAirTime()==0){
           if(!level_colide(player1.x,player1.getY()-1,newpos-10)){//auto jump
             player1.z=newpos;
             player1.setY(player1.getY()-1);
           }
           else if(!level_colide(player1.x,player1.getY()-2,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-2);
           }else if(!level_colide(player1.x,player1.getY()-3,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-3);
           }
           else if(!level_colide(player1.x,player1.getY()-4,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-4);
           }
           else if(!level_colide(player1.x,player1.getY()-5,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-5);
           }
           else if(!level_colide(player1.x,player1.getY()-6,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-6);
           }
           else if(!level_colide(player1.x,player1.getY()-7,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-7);
           }
           else if(!level_colide(player1.x,player1.getY()-8,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-8);
           }
           else if(!level_colide(player1.x,player1.getY()-9,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-9);
           }
           else if(!level_colide(player1.x,player1.getY()-10,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-10);
           }
           else if(!level_colide(player1.x,player1.getY()-11,newpos+10)){
             player1.z=newpos;
             player1.setY(player1.getY()-11);
           }
          }
          
          if(player1.getAnimationCooldown()<=0){//change the playerb pose to make them look lie there walking
            player1.setPose(player1.getPose()-1);
             player1.setAnimationCooldown(4);
            if(player1.getPose()==0){
             player1.setPose(12); 
            }
          }else{
            player1.setAnimationCooldown(player1.getAnimationCooldown()-0.05*mspc);
          }
         }
         
         if(!player1_moving_right&&!player1_moving_left&&!WPressed&&!SPressed){//reset the player pose if the player is not moving
           player1.setPose(1);
           player1.setAnimationCooldown(4);
         }
         
         
         if(simulating)//--------------------------------------------------------------------------------------------------remove this line in the final game
         if(!player1_jumping||!player1.isJumping()){//gravity
           float pd=1;
            if(!level_colide(player1.getX(),player1.getY()+pd,player1.z+7)&&!level_colide(player1.getX(),player1.getY()+pd,player1.z-7)){
              pd=mspc*0.2;//gravity movement
              //wasDP=false;
              if(!level_colide(player1.getX(),player1.getY()+pd,player1.z+7)&&!level_colide(player1.getX(),player1.getY()+pd,player1.z-7)){
              player1.setY(player1.getY()+pd);
              player1.setAirTime(60);
              }else{
               while((!level_colide(player1.getX(),player1.getY()+pd,player1.z+7)&&!level_colide(player1.getX(),player1.getY()+pd,player1.z-7))&&pd>0){
                pd--; 
               }
               if(pd>0){
                 player1.setY(player1.getY()+pd);
               }
              }
            }else{
               player1.setAirTime(0);
               
            }
         }
         
         //if(player_kill(player1.getX()-10,player1.getY()+1)||player_kill(player1.getX()-5,player1.getY()+1)||player_kill(player1.getX(),player1.getY()+1)||player_kill(player1.getX()+5,player1.getY()+1)||player_kill(player1.getX()+10,player1.getY()+1)){
         //  dead=true;          
         //}
         
         
         if(!(!level_colide(player1.getX(),player1.getY(),player1.z+7)&&!level_colide(player1.getX(),player1.getY(),player1.z-7))){
           player1.setY(player1.getY()-1);
         }
         
         
         if(player1_jumping){//jumping
          if(player1.getAirTime()==0){
            player1.setJumping(true);
          }
          if(player1.getAirTime()<14&&player1.isJumping()){//jumping
            float pp=(0.1953333*mspc);
            if(!level_colide(player1.getX()-10,player1.getY()-75-pp,player1.z)&&!level_colide(player1.getX()-5,player1.getY()-75-pp,player1.z)&&!level_colide(player1.getX(),player1.getY()-75-pp,player1.z)&&!level_colide(player1.getX()+5,player1.getY()-75-pp,player1.z)&&!level_colide(player1.getX()+10,player1.getY()-75-pp,player1.z)){
              player1.setY(player1.getY()-pp);
              player1.setAirTime(player1.getAirTime()+mspc*0.010);
              player1.jumpDist+=pp;
            }else{
              player1.setJumping(false);
              player1.jumpDist=0;
            }
          }else{
            if(player1.getAirTime()<16&&player1.isJumping()){
              player1.setAirTime(player1.getAirTime()+mspc*0.010);
              //player1.setY(player1.getY()+(player1.jumpDist-293));
              player1.jumpDist=293;//in the futchre use this varible to judge wether the jump is at the max height
            }else{
            player1.setJumping(false);
            player1.jumpDist=0;
            }
          }
         }else{
           player1.setJumping(false);
           player1.jumpDist=0;
         }
         
         
         
         
         
}//end of 3D mode
         if(player1.getY()>720){
          dead=true; 
          death_cool_down=0;
         }
         
         if(dead){
           //file_path=rootPath+mainIndex.getJSONObject(respawnStage).getString("location");
              //level_terain=loadJSONArray(file_path);
              currentStageIndex=respawnStage;
              stageIndex=respawnStage;
              
          player1.setX(respawnX);
          player1.setY(respawnY);
          if(checkpointIn3DStage){
           player1.z=respawnZ; 
          }
          
         }
         if(setPlayerPosTo){
              player1.setX(setPlayerPosX).setY(setPlayerPosY);
              player1.z=setPlayerPosZ;
           setPlayerPosTo=false;
         }
         //////////////////////////////
         
         
          
}

boolean level_colide(float x,float y){
  Stage stage=level.stages.get(currentStageIndex);
  for(int i=0;stageLoopCondishen(i,stage);i++){
    if(stage.parts.get(i).colide(x,y,false)){
      return true; 
    }
  }
         
  
  
  return false;
}

boolean level_colide(float x,float y,float z){//3d collions 
Stage stage=level.stages.get(currentStageIndex);
  for(int i=0;stageLoopCondishen(i,stage);i++){
    if(stage.parts.get(i).colide(x,y,z)){
      
      return true; 
    }
  }
         return false;
  
}

boolean player_kill(float x,float y){
  Stage stage=level.stages.get(currentStageIndex);
  for(int i=0;stageLoopCondishen(i,stage);i++){
    if(stage.parts.get(i).colideDethPlane(x,y)){
      return true; 
    }
  }
  
  return false;
}

int colid_index(float x,float y){
 Stage stage=level.stages.get(currentStageIndex);
  for(int i=stage.parts.size()-1;i>=0;i++){
    if(stage.parts.get(i).colide(x,y,true)){
      return i; 
    }
  }
 return -1;
}

boolean stageLoopCondishen(int i,Stage stage){
  if(!tutorialMode){
    return i<stage.parts.size();
  }else{
    if(tutorialDrawLimit<stage.parts.size()){
      return i<tutorialDrawLimit;
    }else{
      return i<stage.parts.size();
    }
  }
}
