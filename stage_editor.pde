void stageEditGUI() {

  textAlign(LEFT, BOTTOM);


  int adj;//color adjustment stuff that may be useless
  if (RC == 0 && GC == 0 && BC > 0) {
    adj=256;
  } else {
    adj=0;
  }
  Color=(int)(RC*Math.pow(16, 4)+GC*Math.pow(16, 2)+BC+adj)-16777215;
  Color=scr2.CC;

  Stage current=null;//setup a varable that can be used for the current stage or blueprint
  if (editingStage) {
    current=level.stages.get(currentStageIndex);
  }
  if (editingBlueprint) {
    current=workingBlueprint;
  }

  if (current.type.equals("stage")||current.type.equals("blueprint")) {//if current is a steg or blueprint

    if (drawing) {//if drawing a dragable shape
      fill(Color);
      stroke(Color);
      if (dethPlane) {//overide coustome color if the current tool is deathplane
        fill(-114431);
        stroke(-114431);
      }

      if (grid_mode) {//if gridmode is on
        if (sloap||holoTriangle) {//if your currenly drawing a triangle type
          int X2=0, Y2=0, X1=0, Y1=0;//calcaute the location of the mouese press and unpress location
          if (mouseX>downX) {
            X1=(int)((downX+camPos)/grid_size)*grid_size-camPos;
            X2=(int)(Math.ceil((mouseX*1.0+camPos)/grid_size)*grid_size)-camPos;
          }
          if (mouseX<downX) {
            X1=(int)((mouseX+camPos)/grid_size)*grid_size-camPos;
            X2=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-camPos;
          }
          if (mouseY>downY) {
            Y1=(int)((downY-camPosY)/grid_size)*grid_size+camPosY;
            Y2=(int)(Math.ceil((mouseY-camPosY)*1.0/grid_size)*grid_size)+camPosY;
          }
          if (mouseY<downY) {
            Y1=(int)((mouseY-camPosY)/grid_size)*grid_size+camPosY;
            Y2=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)+camPosY;
          }
          if (triangleMode==0) {//display the triangle that will be created
            triangle(X1, Y1, X2, Y2, X2, Y1);
          }
          if (triangleMode==1) {
            triangle(X1, Y1, X1, Y2, X2, Y1);
          }
          if (triangleMode==2) {
            triangle(X1, Y1, X2, Y2, X1, Y2);
          }
          if (triangleMode==3) {
            triangle(X1, Y2, X2, Y2, X2, Y1);
          }
        } else {//if the type is not a triangle
          int XD=0, YD=0, X1=0, Y1=0;//calcaute the location of the mouese press and unpress location
          if (mouseX>downX) {
            X1=(int)((downX+camPos)/grid_size)*grid_size-camPos;
            XD=(int)(Math.ceil((mouseX*1.0+camPos)/grid_size)*grid_size)-X1-camPos;
          }
          if (mouseX<downX) {
            X1=(int)((mouseX+camPos)/grid_size)*grid_size-camPos;
            XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1-camPos;
          }
          if (mouseY>downY) {
            Y1=(int)((downY-camPosY)/grid_size)*grid_size+camPosY;
            YD=(int)(Math.ceil((mouseY-camPosY)*1.0/grid_size)*grid_size)-Y1+camPosY;
          }
          //YD=(int)(Math.ceil(upY/grid_size)*grid_size)-Y1;
          if (mouseY<downY) {
            Y1=(int)((mouseY-camPosY)/grid_size)*grid_size+camPosY;
            YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1+camPosY;
          }
          strokeWeight(0);

          rect(X1, Y1, XD, YD);//display the rectangle that is being drawn
        }
      } else {//if grid mode is off
        if (sloap||holoTriangle) {
          int X2=0, Y2=0, X1=0, Y1=0;//calcaute the location of the mouese press and unpress location
          if (mouseX>downX) {
            X1=(int)((downX));
            X2=(int)(Math.ceil((mouseX)));
          }
          if (mouseX<downX) {
            X1=(int)((mouseX));
            X2=(int)(Math.ceil((downX)));
          }
          if (mouseY>downY) {
            Y1=(int)(downY);
            Y2=(int)(Math.ceil(mouseY));
          }
          if (mouseY<downY) {
            Y1=(int)(mouseY);
            Y2=(int)(Math.ceil(downY));
          }
          if (triangleMode==0) {//display the triangle that will be created
            triangle(X1, Y1, X2, Y2, X2, Y1);
          }
          if (triangleMode==1) {
            triangle(X1, Y1, X1, Y2, X2, Y1);
          }
          if (triangleMode==2) {
            triangle(X1, Y1, X2, Y2, X1, Y2);
          }
          if (triangleMode==3) {
            triangle(X1, Y2, X2, Y2, X2, Y1);
          }
        } else {
          strokeWeight(0);
          float xdif=mouseX-downX, ydif=mouseY-downY;//calcaute the location of the mouese press and unpress location

          rect(downX, downY, xdif, ydif);//display the rectangle that is being drawn
        }
      }
    }

    if (draw&&ground) {//add new ground element to the level

      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {//if grid mode is on


        if (upX>downX) {//calcualte corner position
          X1=(int)((downX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upX<downX) {
          X1=(int)((upX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upY>downY) {
          Y1=(int)((downY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (upY<downY) {
          Y1=(int)((upY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {//if grid mode is off


        if (upX>downX) {//calculate corder position
          X1 = (int)downX+camPos;
          XD = (int)abs(xdif);
        }
        if (upX<downX) {
          X1 = (int)upX+camPos;
          XD = (int)abs(downX-upX);
        }
        if (upY>downY) {
          Y1 = (int)downY-camPosY;
          YD =  (int)abs(ydif);
        }
        if (upY<downY) {
          Y1 = (int)upY-camPosY;
          YD = (int)abs(downY-upY);
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }

      current.parts.add(new Ground(X1, Y1, XD, YD, Color));//add the new element to the stage
      draw=false;
    }//end of add ground

    if (draw&&holo_gram) {//add new holo element to the level
      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {


        if (upX>downX) {//calculate corder position
          X1=(int)((downX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upX<downX) {
          X1=(int)((upX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upY>downY) {
          Y1=(int)((downY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (upY<downY) {
          Y1=(int)((upY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {


        if (upX>downX) {//calculate corder position
          X1 = (int)downX+camPos;
          XD = (int)abs(xdif);
        }
        if (upX<downX) {
          X1 = (int)upX+camPos;
          XD = (int)abs(downX-upX);
        }
        if (upY>downY) {
          Y1 = (int)downY-camPosY;
          YD =  (int)abs(ydif);
        }
        if (upY<downY) {
          Y1 = (int)upY-camPosY;
          YD = (int)abs(downY-upY);
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new Holo(X1, Y1, XD, YD, Color));//add the new element to the stage
      draw=false;
    }//end of add holo

    if (draw&&dethPlane) {//add new deathplane element to the level
      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {


        if (upX>downX) {//calculate corder position
          X1=(int)((downX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upX<downX) {
          X1=(int)((upX+camPos)/grid_size)*grid_size;
          XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1;
        }
        if (upY>downY) {
          Y1=(int)((downY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (upY<downY) {
          Y1=(int)((upY-camPosY)/grid_size)*grid_size;
          YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1;
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {


        if (upX>downX) {//calculate corder position
          X1 = (int)downX+camPos;
          XD = (int)xdif;
        }
        if (upX<downX) {
          X1 = (int)upX+camPos;
          XD = (int)(downX-upX);
        }
        if (upY>downY) {
          Y1 = (int)downY-camPosY;
          YD =  (int)ydif;
        }
        if (upY<downY) {
          Y1 = (int)upY;
          YD = (int)(downY-upY-camPosY);
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new DethPlane(X1, Y1, XD, YD));//add new death plane elemtn to the stage
      draw=false;
    }//end of new deathplane


    if (check_point&&draw) {//creating new checkpoint
      if (grid_mode) {//if grid mode is on
        current.parts.add(new CheckPoint(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));//add new checkpoint to the stage
      } else {
        current.parts.add(new CheckPoint((int)mouseX+camPos, (int)mouseY-camPosY));//add new checkpoint to the stage
      }
      draw=false;
    }//end of create new checkpoint
    if (goal&&draw) {//create new finishline
      if (grid_mode) {//if grid mode is on
        current.parts.add(new Goal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));//add new finishline to the stage
      } else {
        current.parts.add(new Goal((int)mouseX+camPos, (int)mouseY-camPosY));//add new finishline to the stage
      }
      draw=false;
    }//end of new finishline

    if (deleteing&&delete) {//if attempting to delete something
      int index=colid_index(mouseX+camPos, mouseY-camPosY, current);//get the index of the elemtn the mouse is currently over
      if (index==-1) {//if the mouse was over nothing then do nothing
      } else {
        current.parts.remove(index);//remove the object the mosue was over
      }
      delete=false;
    }//end of delete

    if (drawCoins) {//if adding coins
      if (grid_mode) {//if grid mode is on
        drawCoin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 3);//draw gid aligmed coin
      } else {
        drawCoin(mouseX, mouseY, 3);//draw coin
      }
    }

    if (drawingPortal) {//if adding portal part 1
      if (grid_mode) {//if gridmode is on
        drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);//draw a grid aligned portal
      } else {
        drawPortal(mouseX, mouseY, 1);//draw a portal
      }
    }

    if (drawingPortal3) {//if drawing portal part 3
      if (grid_mode) {//if gridmode is on
        drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);//draw a grid aligned portal
      } else {
        drawPortal(mouseX, mouseY, 1);//draw a portal
      }
    }

    if (sloap&&draw) {//if drawing a triangle
      int X1=0, X2=0, Y1=0, Y2=0;
      if (grid_mode) {//if gridmode is on


        if (upX>downX) {//calcualte corner positions
          X1=(int)((downX+camPos)/grid_size)*grid_size;
          X2=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size);
        }
        if (upX<downX) {
          X1=(int)((upX+camPos)/grid_size)*grid_size;
          X2=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size);
        }
        if (upY>downY) {
          Y1=(int)((downY-camPosY)/grid_size)*grid_size;
          Y2=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size);
        }
        if (upY<downY) {
          Y1=(int)((upY-camPosY)/grid_size)*grid_size;
          Y2=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size);
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {//if gridmode is off

        if (upX>downX) {
          X1 = (int)downX+camPos;//calculate corder position
          X2 = (int)upX+camPos;
        }
        if (upX<downX) {
          X1 = (int)upX+camPos;
          X2 = (int)(downX+camPos);
        }
        if (upY>downY) {
          Y1 = (int)downY-camPosY;
          Y2 = (int)upY-camPosY;
        }
        if (upY<downY) {
          Y1 = (int)upY-camPosY;
          Y2 = (int)(downY)-camPosY;
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }

      current.parts.add(new Sloap(X1, Y1, X2, Y2, triangleMode, Color));//add new sloap to the stage
      draw=false;
    }

    if (holoTriangle&&draw) {//if drawing a holo triangle
      int X1=0, X2=0, Y1=0, Y2=0;
      if (grid_mode) {//if gridmode is on


        if (upX>downX) {//calculate corder position
          X1=(int)((downX+camPos)/grid_size)*grid_size;
          X2=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size);
        }
        if (upX<downX) {
          X1=(int)((upX+camPos)/grid_size)*grid_size;
          X2=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size);
        }
        if (upY>downY) {
          Y1=(int)((downY-camPosY)/grid_size)*grid_size;
          Y2=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size);
        }
        if (upY<downY) {
          Y1=(int)((upY-camPosY)/grid_size)*grid_size;
          Y2=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size);
        }
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {//if grid mode is off


        if (upX>downX) {//calculate corder position
          X1 = (int)downX+camPos;
          X2 = (int)upX+camPos;
        }
        if (upX<downX) {
          X1 = (int)upX+camPos;
          X2 = (int)(downX+camPos);
        }
        if (upY>downY) {
          Y1 = (int)downY-camPosY;
          Y2 = (int)upY-camPosY;
        }
        if (upY<downY) {
          Y1 = (int)upY-camPosY;
          Y2 = (int)(downY)-camPosY;
        }
        if (downX==upX) {//if there was no change is mouse position then don't create a new segment
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new HoloTriangle(X1, Y1, X2, Y2, triangleMode, Color));//add new holor triangle to the stage
      draw=false;
    }
    if (check_point) {//if  checkpoint
      if (grid_mode) {//draw checkoint
        drawCheckPoint(Math.round((mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round((mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
      } else {
        drawCheckPoint(mouseX, mouseY);
      }
    }
    if (drawingSign) {//if sign
      if (grid_mode) {//draw a sign
        drawSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, Scale);
      } else {
        drawSign(mouseX, mouseY, Scale);
      }
    }
    if (placingSound) {//if placing soundboxes
      if (grid_mode) {//draw a sound box
        drawSoundBox(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
      } else {
        drawSoundBox(mouseX, mouseY);
      }
    }
    if (placingLogicButton) {//if placing a logic button
      if (grid_mode) {//draw the switch
        drawLogicButton(primaryWindow, Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1, false);
      } else {
        drawLogicButton(primaryWindow, mouseX, mouseY, 1, false);
      }
    }
    if (placingLogicButton&&draw) {//if attempting to add a logic button
      if (grid_mode) {//add the button to the stage
        current.parts.add(new LogicButton(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));
      } else {
        current.parts.add(new LogicButton((int)mouseX+camPos, (int)mouseY-camPosY));
      }
      draw=false;
    }


    //the accual gut part
  }

  if (current.type.equals("3Dstage")) {//if in a 3D stage

    if (!e3DMode) {//if 3D mode is off

      if (drawing) {//if drawing something
        fill(Color);
        stroke(Color);
        if (dethPlane) {
          fill(-114431);
          stroke(-114431);
        }

        if (grid_mode||holo_gram) {//if drawing something that is a rectangle
          int XD=0, YD=0, X1=0, Y1=0;//calc the corner positions
          if (mouseX>downX) {
            X1=(int)((downX+camPos)/grid_size)*grid_size-camPos;
            XD=(int)(Math.ceil((mouseX*1.0+camPos)/grid_size)*grid_size)-X1-camPos;
          }
          if (mouseX<downX) {
            X1=(int)((mouseX+camPos)/grid_size)*grid_size-camPos;
            XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1-camPos;
          }
          if (mouseY>downY) {
            Y1=(int)((downY-camPosY)/grid_size)*grid_size+camPosY;
            YD=(int)(Math.ceil((mouseY-camPosY)*1.0/grid_size)*grid_size)-Y1+camPosY;
          }
          //YD=(int)(Math.ceil(upY/grid_size)*grid_size)-Y1;
          if (mouseY<downY) {
            Y1=(int)((mouseY-camPosY)/grid_size)*grid_size+camPosY;
            YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1+camPosY;
          }
          strokeWeight(0);

          rect(X1, Y1, XD, YD);//draw the rectangle preview
        } else {//end of grid mode
          strokeWeight(0);
          float xdif=mouseX-downX, ydif=mouseY-downY;
          rect(downX, downY, xdif, ydif);//draw the preview
        }
      }//end of drawing

      if (draw&&ground) {//if drawing ground
        float xdif=upX-downX, ydif=upY-downY;
        int X1=0, XD=0, Y1=0, YD=0;
        if (grid_mode) {//if gridmode is on


          if (upX>downX) {//cacl corner posirions
            X1=(int)((downX+camPos)/grid_size)*grid_size;
            XD=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size)-X1;
          }
          if (upX<downX) {
            X1=(int)((upX+camPos)/grid_size)*grid_size;
            XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1;
          }
          if (upY>downY) {
            Y1=(int)((downY-camPosY)/grid_size)*grid_size;
            YD=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size)-Y1;
          }
          if (upY<downY) {
            Y1=(int)((upY-camPosY)/grid_size)*grid_size;
            YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1;
          }
          if (downX==upX) {//if there was no change is mouse position then don't create a new segment
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        } else {


          if (upX>downX) {//calc corner positions
            X1 = (int)downX+camPos;
            XD = (int)xdif;
          }
          if (upX<downX) {
            X1 = (int)upX+camPos;
            XD = (int)(downX-upX);
          }
          if (upY>downY) {
            Y1 = (int)downY-camPosY;
            YD =  (int)ydif;
          }
          if (upY<downY) {
            Y1 = (int)upY;
            YD = (int)(downY-upY-camPosY);
          }
          if (downX==upX) {//if there was no change is mouse position then don't create a new segment
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        }
        current.parts.add(new Ground(X1, Y1, startingDepth, XD, YD, totalDepth, Color));//add new ground to the stage
        draw=false;
      }
      if (draw&&holo_gram) {//if drawing holo
        float xdif=upX-downX, ydif=upY-downY;
        int X1=0, XD=0, Y1=0, YD=0;
        if (grid_mode) {//if grid mode is on


          if (upX>downX) {//calc corner position
            X1=(int)((downX+camPos)/grid_size)*grid_size;
            XD=(int)(Math.ceil((upX+camPos)/grid_size)*grid_size)-X1;
          }
          if (upX<downX) {
            X1=(int)((upX+camPos)/grid_size)*grid_size;
            XD=(int)(Math.ceil((downX+camPos)/grid_size)*grid_size)-X1;
          }
          if (upY>downY) {
            Y1=(int)((downY-camPosY)/grid_size)*grid_size;
            YD=(int)(Math.ceil((upY-camPosY)/grid_size)*grid_size)-Y1;
          }
          if (upY<downY) {
            Y1=(int)((upY-camPosY)/grid_size)*grid_size;
            YD=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)-Y1;
          }
          if (downX==upX) {//if there was no change is mouse position then don't create a new segment
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        } else {


          if (upX>downX) {//calc corner position
            X1 = (int)downX+camPos;
            XD = (int)xdif;
          }
          if (upX<downX) {
            X1 = (int)upX+camPos;
            XD = (int)(downX-upX);
          }
          if (upY>downY) {
            Y1 = (int)downY-camPosY;
            YD =  (int)ydif;
          }
          if (upY<downY) {
            Y1 = (int)upY;
            YD = (int)(downY-upY-camPosY);
          }
          if (downX==upX) {//if there was no change is mouse position then don't create a new segment
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        }
        current.parts.add(new Holo(X1, Y1, startingDepth, XD, YD, totalDepth, Color));//add new holo to the stage
        draw=false;
      }

      if (deleteing&&delete) {//if deleting things
        int index=colid_index(mouseX+camPos, mouseY-camPosY, level.stages.get(currentStageIndex));//figure out what thing the mouse is over
        if (index==-1) {//if the mouse is over nothing then do nothing
        } else {
          current.parts.remove(index);//remove the thing
        }
        delete=false;
      }
      if (draw3DSwitch1) {//if drawing a 3d switch
        if (grid_mode) {//draw the switch
          draw3DSwitch1(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          draw3DSwitch1(mouseX, mouseY, 1);
        }
      }
      if (draw3DSwitch2) {//if drawing a 3d switch
        if (grid_mode) {//draw the switch
          draw3DSwitch2(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          draw3DSwitch2(mouseX, mouseY, 1);
        }
      }
      if (draw3DSwitch1&&draw) {//if attempting to add a 3D switch
        if (grid_mode) {//add the switch to the stage
          current.parts.add(new SWon3D(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new SWon3D((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (draw3DSwitch2&&draw) {//if attempting to add a 3D switch
        if (grid_mode) {//add the 3D switch to the stage
          current.parts.add(new SWoff3D(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new SWoff3D((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (check_point&&draw) {//if adding a checkpoint
        if (grid_mode) {//add a checkoint to the stage
          current.parts.add(new CheckPoint(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new CheckPoint((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (drawingPortal) {//if placing a portal
        if (grid_mode) {//diaply the portal
          drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          drawPortal(mouseX, mouseY, 1);
        }
      }

      if (drawingPortal3) {//if placing a portal part 3
        if (grid_mode) {//display the portal
          drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          drawPortal(mouseX, mouseY, 1);
        }
      }
      if (check_point) {//if adding checkoint
        if (grid_mode) {//display a checkoint
          drawCheckPoint(Math.round((mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round((mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
        } else {
          drawCheckPoint(mouseX, mouseY);
        }
      }
      if (drawCoins) {//if adding coins
        if (grid_mode) {//display a coin
          drawCoin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 3);
        } else {
          drawCoin(mouseX, mouseY, 3);
        }
      }
      if (drawingSign) {//if adding coins
        if (grid_mode) {//display a coin
          drawSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, Scale);
        } else {
          drawSign(mouseX, mouseY, Scale);
        }
      }
      if (placingLogicButton) {//if placing a logic button
        if (grid_mode) {//draw the switch
          drawLogicButton(primaryWindow, Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1, false);
        } else {
          drawLogicButton(primaryWindow, mouseX, mouseY, 1, false);
        }
      }
      if (placingLogicButton&&draw) {//if attempting to add a logic button
        if (grid_mode) {//add the button to the stage
          current.parts.add(new LogicButton(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new LogicButton((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }
    }//end of is 3d mode off if statment
    else {//if 3dmode is on
      if (selectedIndex!=-1) {
        boolean b1=false, b2=false, r1=false, r2=false, g1=false, g2=false;
        StageComponent ct=current.parts.get(selectedIndex);
        for (int i=0; i<5000; i++) {
          Point3D testPoint=genMousePoint(i);
          if (testPoint.x >= (ct.x+ct.dx/2)-5 && testPoint.x <= (ct.x+ct.dx/2)+5 && testPoint.y >= (ct.y+ct.dy/2)-5 && testPoint.y <= (ct.y+ct.dy/2)+5 && testPoint.z >= ct.z+ct.dz && testPoint.z <= ct.z+ct.dz+60) {
            b1=true;
            break;
          }

          if (testPoint.x >= (ct.x+ct.dx/2)-5 && testPoint.x <= (ct.x+ct.dx/2)+5 && testPoint.y >= (ct.y+ct.dy/2)-5 && testPoint.y <= (ct.y+ct.dy/2)+5 && testPoint.z >= ct.z-60 && testPoint.z <= ct.z) {
            b2=true;
            break;
          }

          if (testPoint.x >= ct.x-60 && testPoint.x <= ct.x && testPoint.y >= (ct.y+ct.dy/2)-5 && testPoint.y <= (ct.y+ct.dy/2)+5 && testPoint.z >= (ct.z+ct.dz/2)-5 && testPoint.z <= (ct.z+ct.dz/2)+5) {
            r1=true;
            break;
          }

          if (testPoint.x >= ct.x+ct.dx && testPoint.x <= ct.x+ct.dx+60 && testPoint.y >= (ct.y+ct.dy/2)-5 && testPoint.y <= (ct.y+ct.dy/2)+5 && testPoint.z >= (ct.z+ct.dz/2)-5 && testPoint.z <= (ct.z+ct.dz/2)+5) {
            r2=true;
            break;
          }

          if (testPoint.x >= (ct.x+ct.dx/2)-5 && testPoint.x <= (ct.x+ct.dx/2)+5 && testPoint.y >= ct.y-60 && testPoint.y <= ct.y && testPoint.z >= (ct.z+ct.dz/2)-5 && testPoint.z <= (ct.z+ct.dz/2)+5) {
            g1=true;
            break;
          }

          if (testPoint.x >= (ct.x+ct.dx/2)-5 && testPoint.x <= (ct.x+ct.dx/2)+5 && testPoint.y >= ct.y+ct.dy && testPoint.y <= ct.y+ct.dy+60 && testPoint.z >= (ct.z+ct.dz/2)-5 && testPoint.z <= (ct.z+ct.dz/2)+5) {
            g2=true;
            break;
          }
        }
        if (current3DTransformMode==1) {
          translate(ct.x+ct.dx/2, ct.y+ct.dy/2, ct.z+ct.dz);
          if (b1)
            shape(yellowArrow);
          else
            shape(blueArrow);

          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy/2), -(ct.z+ct.dz));

          translate(ct.x+ct.dx/2, ct.y+ct.dy/2, ct.z);
          rotateY(radians(180));
          if (b2)
            shape(yellowArrow);
          else
            shape(blueArrow);
          rotateY(-radians(180));
          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy/2), -(ct.z));

          translate(ct.x, ct.y+ct.dy/2, ct.z+ct.dz/2);
          rotateY(-radians(90));
          if (r1)
            shape(yellowArrow);
          else
            shape(redArrow);
          rotateY(radians(90));
          translate(-(ct.x), -(ct.y+ct.dy/2), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx, ct.y+ct.dy/2, ct.z+ct.dz/2);
          rotateY(radians(90));
          if (r2)
            shape(yellowArrow);
          else
            shape(redArrow);
          rotateY(-radians(90));
          translate(-(ct.x+ct.dx), -(ct.y+ct.dy/2), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx/2, ct.y, ct.z+ct.dz/2);
          rotateX(radians(90));
          if (g1)
            shape(yellowArrow);
          else
            shape(greenArrow);
          rotateX(-radians(90));
          translate(-(ct.x+ct.dx/2), -(ct.y), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx/2, ct.y+ct.dy, ct.z+ct.dz/2);
          rotateX(-radians(90));
          if (g2)
            shape(yellowArrow);
          else
            shape(greenArrow);
          rotateX(radians(90));
          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy), -(ct.z+ct.dz/2));

          if (grid_mode) {//Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size
            if (translateZaxis) {
              ct.z=initalObjectPos.z-Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size;
            }
            if (translateXaxis) {
              ct.x=initalObjectPos.x-Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size;
              ;
            }
            if (translateYaxis) {
              ct.y=initalObjectPos.y-Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size;
              ;
            }
          } else {
            if (translateZaxis) {
              ct.z=initalObjectPos.z-(initalMousePoint.z-mousePoint.z);
            }
            if (translateXaxis) {
              ct.x=initalObjectPos.x-(initalMousePoint.x-mousePoint.x);
            }
            if (translateYaxis) {
              ct.y=initalObjectPos.y-(initalMousePoint.y-mousePoint.y);
            }
          }
        }//end of 3d transform mode is move

        if (current3DTransformMode==2&&(ct instanceof Ground || ct instanceof Holo)) {
          translate(ct.x+ct.dx/2, ct.y+ct.dy/2, ct.z+ct.dz);
          if (b1)
            shape(yellowScaler);
          else
            shape(blueScaler);

          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy/2), -(ct.z+ct.dz));

          translate(ct.x+ct.dx/2, ct.y+ct.dy/2, ct.z);
          rotateY(radians(180));
          if (b2)
            shape(yellowScaler);
          else
            shape(blueScaler);
          rotateY(-radians(180));
          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy/2), -(ct.z));

          translate(ct.x, ct.y+ct.dy/2, ct.z+ct.dz/2);
          rotateY(-radians(90));
          if (r1)
            shape(yellowScaler);
          else
            shape(redScaler);
          rotateY(radians(90));
          translate(-(ct.x), -(ct.y+ct.dy/2), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx, ct.y+ct.dy/2, ct.z+ct.dz/2);
          rotateY(radians(90));
          if (r2)
            shape(yellowScaler);
          else
            shape(redScaler);
          rotateY(-radians(90));
          translate(-(ct.x+ct.dx), -(ct.y+ct.dy/2), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx/2, ct.y, ct.z+ct.dz/2);
          rotateX(radians(90));
          if (g1)
            shape(yellowScaler);
          else
            shape(greenScaler);
          rotateX(-radians(90));
          translate(-(ct.x+ct.dx/2), -(ct.y), -(ct.z+ct.dz/2));

          translate(ct.x+ct.dx/2, ct.y+ct.dy, ct.z+ct.dz/2);
          rotateX(-radians(90));
          if (g2)
            shape(yellowScaler);
          else
            shape(greenScaler);
          rotateX(radians(90));
          translate(-(ct.x+ct.dx/2), -(ct.y+ct.dy), -(ct.z+ct.dz/2));

          if (grid_mode) {
            if (transformComponentNumber==1) {
              if (translateZaxis) {
                if (initialObjectDim.z-Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size > 0)
                  ct.dz=initialObjectDim.z-Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size;
              }
              if (translateXaxis) {
                if (initialObjectDim.x-Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size > 0)
                  ct.dx=initialObjectDim.x-Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size;
              }
              if (translateYaxis) {
                if (initialObjectDim.y-Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size > 0)
                  ct.dy=initialObjectDim.y-Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size;
              }
            }
            if (transformComponentNumber==2) {
              if (translateZaxis) {
                if (initialObjectDim.z+Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size > 0){
                  ct.dz=initialObjectDim.z+Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size;
                  ct.z=(initalObjectPos.z-Math.round((initalMousePoint.z-mousePoint.z)*1.0/grid_size)*grid_size);
                }
              }
              if (translateXaxis) {
                if (initialObjectDim.x+Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size > 0){
                  ct.dx=initialObjectDim.x+Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size;
                  ct.x=(initalObjectPos.x-Math.round((initalMousePoint.x-mousePoint.x)*1.0/grid_size)*grid_size);
                }
              }
              if (translateYaxis) {
                if (initialObjectDim.y+Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size > 0){
                  ct.dy=initialObjectDim.y+Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size;
                  ct.y=(initalObjectPos.y-Math.round((initalMousePoint.y-mousePoint.y)*1.0/grid_size)*grid_size);
                }
              }
            }
          } else {
            if (transformComponentNumber==1) {
              if (translateZaxis) {
                if (initialObjectDim.z-(initalMousePoint.z-mousePoint.z) > 0)
                  ct.dz=initialObjectDim.z-(initalMousePoint.z-mousePoint.z);
              }
              if (translateXaxis) {
                if (initialObjectDim.x-(initalMousePoint.x-mousePoint.x) > 0)
                  ct.dx=initialObjectDim.x-(initalMousePoint.x-mousePoint.x);
              }
              if (translateYaxis) {
                if (initialObjectDim.y-(initalMousePoint.y-mousePoint.y) > 0);
                ct.dy=initialObjectDim.y-(initalMousePoint.y-mousePoint.y);
              }
            }
            if (transformComponentNumber==2) {
              if (translateZaxis) {
                if (initialObjectDim.z+(initalMousePoint.z-mousePoint.z) > 0){
                  ct.dz=initialObjectDim.z+(initalMousePoint.z-mousePoint.z);
                  ct.z=initalObjectPos.z-(initalMousePoint.z-mousePoint.z);
                }
              }
              if (translateXaxis) {
                if (initialObjectDim.x+(initalMousePoint.x-mousePoint.x) > 0){
                  ct.dx=initialObjectDim.x+(initalMousePoint.x-mousePoint.x);
                  ct.x=initalObjectPos.x-(initalMousePoint.x-mousePoint.x);
                }
              }
              if (translateYaxis) {
                if (initialObjectDim.y+(initalMousePoint.y-mousePoint.y) > 0){
                ct.dy=initialObjectDim.y+(initalMousePoint.y-mousePoint.y);
                ct.y=initalObjectPos.y-(initalMousePoint.y-mousePoint.y);
                }
              }
            }
          }
        }//end of 3d transform mode is scale
      }//end of 3d tranform is move mode
      engageHUDPosition();//move the draw position to align with the camera


      disEngageHUDPosition();//move the draw position back to 0 0 0
    }//end of 3d mode on
  }
}

void GUImouseClicked() {
  if (editingStage||editingBlueprint) {//if edditing a stage or blueprint



    Stage current=null;//figure out what your edditing
    if (editingStage) {
      current=level.stages.get(currentStageIndex);
    }
    if (editingBlueprint) {
      current=workingBlueprint;
    }


    if (check_point) {//if checkoint
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        draw=true;
      }
    }
    if (goal) {//if placing finishline
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        draw=true;
      }
    }
    if (placingLogicButton) {//if placing logic button
      draw=true;
    }
    if (deleteing) {//if deleteing
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        delete=true;
      }
    }
    if (moving_player) {//if moving the player
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {//set the players new position
        player1.setX(mouseX+camPos);
        player1.setY(mouseY-camPosY);
        if (level.stages.get(currentStageIndex).type.equals("3Dstage")) {
          player1.z=startingDepth;
        }
        tpCords[0]=mouseX+camPos;
        tpCords[1]=mouseY-camPosY;
        tpCords[2]=startingDepth;
      }
      setPlayerPosTo=true;
    }
    if (drawCoins) {//if drawing coin
      String tpe = current.type;
      if (grid_mode) {//add coins with data accorinding to how it needs to be integrated
        if (tpe.equals("stage")) {
          current.parts.add(new Coin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, level.numOfCoins));
        }
        if (tpe.equals("3Dstage")) {
          current.parts.add(new Coin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth, level.numOfCoins));
        }
        if (tpe.equals("blueprint")) {
          current.parts.add(new Coin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, 0));
        }
      } else {
        if (tpe.equals("stage")) {
          current.parts.add(new Coin((int)mouseX+camPos, (int)mouseY-camPosY, level.numOfCoins));
        }
        if (tpe.equals("3Dstage")) {
          current.parts.add(new Coin((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth, level.numOfCoins));
        }
        if (tpe.equals("blueprint")) {
          current.parts.add(new Coin((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth, 0));
        }
      }
      if (editingStage) {//if edditng stage the increwase the coin counter
        level.numOfCoins++;
        level.reloadCoins();
      }
    }
    if (drawingPortal) {//if drawing portal part 1

      portalStage1=new JSONObject();//create and store data needed for the proper function of the portals
      portalStage2=new JSONObject();
      portalStage1.setString("type", "interdimentional Portal");
      portalStage2.setString("type", "interdimentional Portal");
      if (grid_mode) {
        portalStage1.setInt("x", Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size);
        portalStage1.setInt("y", Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size);
        portalStage2.setInt("linkX", Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size);
        portalStage2.setInt("linkY", Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size);
      } else {
        portalStage1.setInt("x", mouseX+camPos);
        portalStage1.setInt("y", mouseY-camPosY);
        portalStage2.setInt("linkX", mouseX+camPos);
        portalStage2.setInt("linkY", mouseY-camPosY);
      }
      if (level.stages.get(currentStageIndex).is3D) {
        portalStage1.setInt("z", startingDepth);
        portalStage2.setInt("linkZ", startingDepth);
      }
      portalStage2.setInt("link Index", currentStageIndex+1);
      drawingPortal=false;
      drawingPortal2=true;
      editingStage=false;
      preSI=currentStageIndex;
    }
    if (drawingPortal3) {//if drawing portal part 3

      if (grid_mode) {//gathe the remaining data required and then add the portal to the correct stages
        portalStage2.setInt("x", Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size);
        portalStage2.setInt("y", Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size);
        portalStage1.setInt("linkX", Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size);
        portalStage1.setInt("linkY", Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size);
      } else {
        portalStage2.setInt("x", mouseX+camPos);
        portalStage2.setInt("y", mouseY-camPosY);
        portalStage1.setInt("linkX", mouseX+camPos);
        portalStage1.setInt("linkY", mouseY-camPosY);
      }
      portalStage1.setInt("link Index", currentStageIndex+1);
      if (level.stages.get(currentStageIndex).is3D) {
        portalStage2.setInt("z", startingDepth);
        portalStage1.setInt("linkZ", startingDepth);
      }
      level.stages.get(currentStageIndex).parts.add(new Interdimentional_Portal(portalStage2, level.stages.get(currentStageIndex).is3D));
      level.stages.get(preSI).parts.add(new Interdimentional_Portal(portalStage1, level.stages.get(preSI).is3D));
      portalStage2=null;
      portalStage1=null;
      drawingPortal3=false;
    }
    //add switches
    if (draw3DSwitch1) {
      draw=true;
    }
    if (draw3DSwitch2) {
      draw=true;
    }
    if (drawingSign&&!e3DMode) {//if drawing sign then add the sign to the stage
      String tpe = level.stages.get(currentStageIndex).type;
      if (tpe.equals("stage")) {
        if (grid_mode) {
          current.parts.add(new WritableSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));
        } else {
          current.parts.add(new WritableSign((int)mouseX+camPos, (int)mouseY-camPosY));
        }
      }
      if (tpe.equals("3Dstage")) {
        if (grid_mode) {
          current.parts.add(new WritableSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new WritableSign((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
      }
    }

    if (selecting) {//if selecting figureout what is being selected
      selectedIndex=colid_index(mouseX+camPos, mouseY-camPosY, current);
    }
    if (selectingBlueprint&&blueprints.length!=0) {//place selectedb bluepring and paste it into the stage
      StageComponent tmp;
      int ix, iy;
      if (grid_mode) {
        ix=Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size;
        iy=Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size;
      } else {
        ix=mouseX+camPos;
        iy=mouseY-camPosY;
      }
      for (int i=0; i<blueprints[currentBluieprintIndex].parts.size(); i++) {//translate the objects from blueprint form into stage readdy form
        tmp=blueprints[currentBluieprintIndex].parts.get(i);
        if (tmp instanceof Ground) {
          Ground g=(Ground)tmp;
          current.parts.add(new Ground(g.x+ix, g.y+iy, g.dx, g.dy, g.ccolor));
        }
        if (tmp instanceof Holo) {
          Holo g=(Holo)tmp;
          current.parts.add(new Holo(g.x+ix, g.y+iy, g.dx, g.dy, g.ccolor));
        }
        if (tmp instanceof CheckPoint) {
          CheckPoint g=(CheckPoint)tmp;
          current.parts.add(new CheckPoint(g.x+iy, g.y+ix, g.z));
        }
        if (tmp instanceof Coin) {
          Coin g=(Coin)tmp;
          current.parts.add(new Coin(g.x+ix, g.y+iy, g.z, level.numOfCoins));
          coins.add(false);
          level.numOfCoins++;
        }
        if (tmp instanceof Sloap) {
          Sloap g=(Sloap)tmp;
          current.parts.add(new Sloap(g.x+ix, g.y+iy, g.dx+ix, g.dy+iy, g.direction, g.ccolor));
        }
        if (tmp instanceof HoloTriangle) {
          HoloTriangle g=(HoloTriangle)tmp;
          current.parts.add(new HoloTriangle(g.x+ix, g.y+iy, g.dx+ix, g.dy+iy, g.direction, g.ccolor));
        }
      }
    }
    if (placingSound) {
      if (grid_mode) {
        current.parts.add(new SoundBox(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));
      } else {
        current.parts.add(new SoundBox((int)mouseX+camPos, (int)mouseY-camPosY));
      }
    }
  }//end of eddit stage
}

void GUImousePressed() {
  if (mouseButton==LEFT) {
    if (ground||holo_gram||sloap||holoTriangle||dethPlane) {

      downX=mouseX;
      downY=mouseY;
      drawing=true;
    }
  }
}

void GUImouseReleased() {
  if (mouseButton==LEFT) {
    if ((ground||holo_gram||sloap||holoTriangle||dethPlane)&&drawing) {

      upX=mouseX;
      upY=mouseY;
      drawing=false;
      draw=true;
    }
  }
}


void mouseClicked3D() {
  if(selecting)
  for (int i=0; i<5000; i++) {
    Point3D testPoint = genMousePoint(i);
    selectedIndex=colid_index(testPoint.x, testPoint.y, testPoint.z, level.stages.get(currentStageIndex));
    if (selectedIndex!=-1)
      break;
  }
  if(ground){
    calcMousePoint();
    Point3D omp=mousePoint;
     for (int i=0; i<5000; i++) {
      Point3D testPoint = genMousePoint(i);
      omp.x=testPoint.x;
      if(colid_index(testPoint.x, testPoint.y, testPoint.z, level.stages.get(currentStageIndex))!=-1){
        level.stages.get(currentStageIndex).parts.add(new Ground(testPoint.x-5, testPoint.y-5, testPoint.z-5,10,10,10,Color));
        break;
      }
      omp.y=testPoint.y;
      if(colid_index(testPoint.x, testPoint.y, testPoint.z, level.stages.get(currentStageIndex))!=-1){
        level.stages.get(currentStageIndex).parts.add(new Ground(testPoint.x-5, testPoint.y-5, testPoint.z-5,10,10,10,Color));
        break;
      }
      omp.z=testPoint.z;
      if(colid_index(testPoint.x, testPoint.y, testPoint.z, level.stages.get(currentStageIndex))!=-1){
        level.stages.get(currentStageIndex).parts.add(new Ground(testPoint.x-5, testPoint.y-5, testPoint.z-5,10,10,10,Color));
        break;
      }
     }
  }
}




void glitchEffect() {
  int n=millis()/100%10;
  //n=9;
  strokeWeight(0);
  if (n==0) {
    fill(0, 255, 0, 120);
    rect(12*Scale, 30*Scale, 200*Scale, 80*Scale);
    rect(800*Scale, 300*Scale, 100*Scale, 300*Scale);
    rect(400*Scale, 240*Scale, 500*Scale, 20*Scale);
    fill(124, 0, 250, 120);
    rect(620*Scale, 530*Scale, 240*Scale, 50*Scale);
    rect(100*Scale, 400*Scale, 300*Scale, 40*Scale);
    rect(50*Scale, 600*Scale, 550*Scale, 20*Scale);
    fill(115, 0, 58, 120);
    rect(720*Scale, 90*Scale, 360*Scale, 112*Scale);
    rect(150*Scale, 619*Scale, 203*Scale, 90*Scale);
    rect(526*Scale, 306*Scale, 266*Scale, 165*Scale);
  }
  if (n==1) {
    fill(0, 255, 0, 120);
    rect(925*Scale, 60*Scale, 89*Scale, 96*Scale);
    rect(305*Scale, 522*Scale, 84*Scale, 140*Scale);
    rect(13*Scale, 332*Scale, 234*Scale, 313*Scale);
    fill(124, 0, 250, 120);
    rect(716*Scale, 527*Scale, 317*Scale, 111*Scale);
    rect(318*Scale, 539*Scale, 233*Scale, 118*Scale);
    rect(902*Scale, 3*Scale, 255*Scale, 42*Scale);
    fill(115, 0, 58, 120);
    rect(163*Scale, 150*Scale, 221*Scale, 127*Scale);
    rect(216*Scale, 142*Scale, 7*Scale, 49*Scale);
    rect(538*Scale, 224*Scale, 41*Scale, 48*Scale);
  }
  if (n==2) {
    fill(0, 255, 0, 120);
    rect(410*Scale, 335*Scale, 94*Scale, 74*Scale);
    rect(45*Scale, 222*Scale, 276*Scale, 90*Scale);
    rect(871*Scale, 287*Scale, 268*Scale, 174*Scale);
    fill(124, 0, 250, 120);
    rect(996*Scale, 535*Scale, 18*Scale, 28*Scale);
    rect(722*Scale, 523*Scale, 82*Scale, 107*Scale);
    rect(263*Scale, 201*Scale, 161*Scale, 88*Scale);
    fill(115, 0, 58, 120);
    rect(697*Scale, 436*Scale, 165*Scale, 44*Scale);
    rect(843*Scale, 486*Scale, 98*Scale, 105*Scale);
    rect(755*Scale, 20*Scale, 151*Scale, 51*Scale);
  }
  if (n==3) {
    fill(0, 255, 0, 120);
    rect(5*Scale, 228*Scale, 226*Scale, 131*Scale);
    rect(813*Scale, 428*Scale, 83*Scale, 60*Scale);
    rect(285*Scale, 452*Scale, 166*Scale, 135*Scale);
    fill(124, 0, 250, 120);
    rect(277*Scale, 514*Scale, 11*Scale, 87*Scale);
    rect(905*Scale, 152*Scale, 8*Scale, 160*Scale);
    rect(369*Scale, 80*Scale, 279*Scale, 153*Scale);
    fill(115, 0, 58, 120);
    rect(179*Scale, 96*Scale, 159*Scale, 65*Scale);
    rect(432*Scale, 296*Scale, 47*Scale, 12*Scale);
    rect(944*Scale, 412*Scale, 22*Scale, 50*Scale);
  }
  if (n==4) {
    fill(0, 255, 0, 120);
    rect(679*Scale, 159*Scale, 76*Scale, 168*Scale);
    rect(144*Scale, 58*Scale, 180*Scale, 61*Scale);
    rect(950*Scale, 89*Scale, 155*Scale, 13*Scale);
    fill(124, 0, 250, 120);
    rect(542*Scale, 463*Scale, 177*Scale, 156*Scale);
    rect(527*Scale, 70*Scale, 115*Scale, 28*Scale);
    rect(211*Scale, 151*Scale, 58*Scale, 164*Scale);
    fill(115, 0, 58, 120);
    rect(88*Scale, 440*Scale, 278*Scale, 23*Scale);
    rect(642*Scale, 440*Scale, 231*Scale, 91*Scale);
    rect(737*Scale, 524*Scale, 69*Scale, 71*Scale);
  }
  if (n==5) {
    fill(0, 255, 0, 120);
    rect(226*Scale, 71*Scale, 291*Scale, 37*Scale);
    rect(91*Scale, 436*Scale, 210*Scale, 8*Scale);
    rect(396*Scale, 72*Scale, 10*Scale, 136*Scale);
    fill(124, 0, 250, 120);
    rect(666*Scale, 274*Scale, 175*Scale, 171*Scale);
    rect(251*Scale, 513*Scale, 280*Scale, 13*Scale);
    rect(663*Scale, 141*Scale, 290*Scale, 33*Scale);
    fill(115, 0, 58, 120);
    rect(900*Scale, 47*Scale, 315*Scale, 125*Scale);
    rect(10*Scale, 156*Scale, 231*Scale, 73*Scale);
    rect(377*Scale, 253*Scale, 175*Scale, 22*Scale);
  }
  if (n==6) {
    fill(0, 255, 0, 120);
    rect(756*Scale, 447*Scale, 205*Scale, 161*Scale);
    rect(304*Scale, 341*Scale, 276*Scale, 144*Scale);
    rect(4*Scale, 141*Scale, 35*Scale, 176*Scale);
    fill(124, 0, 250, 120);
    rect(307*Scale, 98*Scale, 204*Scale, 89*Scale);
    rect(478*Scale, 476*Scale, 44*Scale, 52*Scale);
    rect(620*Scale, 57*Scale, 242*Scale, 144*Scale);
    fill(115, 0, 58, 120);
    rect(495*Scale, 374*Scale, 199*Scale, 62*Scale);
    rect(724*Scale, 71*Scale, 34*Scale, 2*Scale);
    rect(853*Scale, 88*Scale, 199*Scale, 114*Scale);
  }
  if (n==7) {
    fill(0, 255, 0, 120);
    rect(276*Scale, 181*Scale, 220*Scale, 38*Scale);
    rect(955*Scale, 514*Scale, 33*Scale, 51*Scale);
    rect(621*Scale, 135*Scale, 100*Scale, 74*Scale);
    fill(124, 0, 250, 120);
    rect(200*Scale, 333*Scale, 165*Scale, 99*Scale);
    rect(709*Scale, 503*Scale, 84*Scale, 117*Scale);
    rect(212*Scale, 275*Scale, 238*Scale, 27*Scale);
    fill(115, 0, 58, 120);
    rect(787*Scale, 477*Scale, 115*Scale, 9*Scale);
    rect(239*Scale, 443*Scale, 155*Scale, 149*Scale);
    rect(794*Scale, 267*Scale, 185*Scale, 80*Scale);
  }
  if (n==8) {
    fill(0, 255, 0, 120);
    rect(543*Scale, 498*Scale, 22*Scale, 125*Scale);
    rect(749*Scale, 151*Scale, 79*Scale, 174*Scale);
    rect(667*Scale, 380*Scale, 311*Scale, 45*Scale);
    fill(124, 0, 250, 120);
    rect(886*Scale, 193*Scale, 87*Scale, 50*Scale);
    rect(135*Scale, 128*Scale, 151*Scale, 83*Scale);
    rect(651*Scale, 128*Scale, 20*Scale, 85*Scale);
    fill(115, 0, 58, 120);
    rect(862*Scale, 374*Scale, 319*Scale, 136*Scale);
    rect(258*Scale, 149*Scale, 65*Scale, 143*Scale);
    rect(299*Scale, 63*Scale, 297*Scale, 152*Scale);
  }
  if (n==9) {
    fill(0, 255, 0, 120);
    rect(953*Scale, 386*Scale, 11*Scale, 30*Scale);
    rect(453*Scale, 104*Scale, 50*Scale, 95*Scale);
    rect(71*Scale, 157*Scale, 23*Scale, 49*Scale);
    fill(124, 0, 250, 120);
    rect(373*Scale, 447*Scale, 28*Scale, 136*Scale);
    rect(598*Scale, 321*Scale, 227*Scale, 19*Scale);
    rect(500*Scale, 314*Scale, 218*Scale, 113*Scale);
    fill(115, 0, 58, 120);
    rect(423*Scale, 512*Scale, 295*Scale, 30*Scale);
    rect(186*Scale, 489*Scale, 208*Scale, 76*Scale);
    rect(178*Scale, 269*Scale, 117*Scale, 133*Scale);
  }
}


void engageHUDPosition() {
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
}

void disEngageHUDPosition() {
  hint(ENABLE_DEPTH_TEST);
}

/**coppy the blueprint so it can be correctly positoned on top of the stage for viewing
 
 */
void generateDisplayBlueprint() {
  displayBlueprint=new Stage("tmp", "blueprint");
  int ix, iy;
  if (grid_mode) {
    ix=Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size;
    iy=Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size;
  } else {
    ix=mouseX+camPos;
    iy=mouseY-camPosY;
  }


  for (int i=0; i<blueprints[currentBluieprintIndex].parts.size(); i++) {
    displayBlueprint.parts.add(blueprints[currentBluieprintIndex].parts.get(i).copy());
    if (displayBlueprint.parts.get(i).type.equals("sloap")||displayBlueprint.parts.get(i).type.equals("holoTriangle")) {
      displayBlueprint.parts.get(i).dx+=ix;
      displayBlueprint.parts.get(i).dy+=iy;
    }
    displayBlueprint.parts.get(i).x+=ix;
    displayBlueprint.parts.get(i).y+=iy;
    println(displayBlueprint.parts.get(i).x);
  }
}

void renderBlueprint() {//render the blueprint on top of the stage
  for (int i=0; i<displayBlueprint.parts.size(); i++) {
    displayBlueprint.parts.get(i).draw();
  }
}

//dfa=default aspect ratio car=current aspect ratio
float dfa=1280.0/720, car=1.0*width/height;
Point3D mousePoint=new Point3D(0, 0, 0);
void calcMousePoint() {//get a 3d point that is at the same postition as the mouse curser

  car=1.0*width/height;
  float planeDist=622/*700*/;
  float camCentercCalcX, camCentercCalcY, camCentercCalcZ;//get a point that is a certain distance from where the camera eyes are in the center if the screen
  camCentercCalcY=sin(radians(yangle))*planeDist+cam3Dy-DY;//calculate the center point of the camera on the plane that is a distacne from the eye point of the camera
  float hd2=cos(radians(yangle))*-planeDist;//calcualte a new hypotenuse for the x/z axis where the result from the calculation of the Y coord is taken into account
  camCentercCalcX=sin(radians(xangle))*hd2+cam3Dx+DX;//use the new hypotenuse to calculate the x and z points
  camCentercCalcZ=cos(radians(xangle))*-hd2+cam3Dz-DZ;


  float midDistX=-1*(mouseX-width/2)/((width/1280.0)/(car/dfa)), midDistY=(mouseY-height/2)/(height/720.0);//calculate the mouse's distance from the center of the window adjusted to the plane that is a distacne from the camera
  float nz=sin(radians(-xangle))*midDistX, nx=cos(radians(-xangle))*midDistX;//calcuate the new distacne from the cenetr of trhe plane the points are at
  float ny=cos(radians(yangle))*midDistY, nd=sin(radians(yangle))*midDistY;
  nz+=cos(radians(xangle))*nd;//adjust those points for the rotation of the plane
  nx+=sin(radians(xangle))*nd;
  //calculate the final coorinates of the point that is at the cameras pos
  mousePoint=new Point3D(camCentercCalcX+nx, camCentercCalcY+ny, camCentercCalcZ-nz);
}

Point3D genMousePoint(float hyp) {//calcualte the coords of a new point that is in line toth the mouse pointer at a set distance from the camera
  calcMousePoint();//make shure the mouse position is up to date
  float x, y, z, ry_xz, rx_z, xzh;//define variables that will be used
  hyp*=-1;//invert the inputed distance
  xzh=dist(cam3Dx+DX, cam3Dz-DZ, mousePoint.x, mousePoint.z);//calcuate the original displacment distance on the x-z plane
  ry_xz=atan2((cam3Dy-DY)-mousePoint.y, xzh);//find the rotation of the orignal line to the x-z plane
  rx_z=atan2((cam3Dz-DZ)-mousePoint.z, (cam3Dx+DX)-mousePoint.x);//find the rotation of the x-z component of the prevous line
  y=(sin(ry_xz)*hyp)+cam3Dy-DY;//calculate the y component of the new line
  float nh = cos(ry_xz)*hyp;//calculate the total length of the x-z component of the new linw
  z=(sin(rx_z)*nh)+cam3Dz-DZ;//calculate the z component of the new line
  x=(cos(rx_z)*nh)+cam3Dx+DX;//calculate the x component of the new line`

  return new Point3D(x, y, z);
}
class Point3D {
  float x, y, z;
  Point3D(float x, float y, float z) {
    this.x=x;
    this.y=y;
    this.z=z;
  }
}
