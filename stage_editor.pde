void stageEditGUI() {

  textAlign(LEFT, BOTTOM);


  int adj;
  if (RC == 0 && GC == 0 && BC > 0) {
    adj=256;
  } else {
    adj=0;
  }

  Color=(int)(RC*Math.pow(16, 4)+GC*Math.pow(16, 2)+BC+adj)-16777215;
  Color=scr2.CC;
  Stage current=null;
  if (editingStage) {
    current=level.stages.get(currentStageIndex);
  }
  if (editingBlueprint) {
    current=workingBlueprint;
  }

  if (current.type.equals("stage")||current.type.equals("blueprint")) {

    if (drawing) {
      fill(Color);
      stroke(Color);
      if (dethPlane) {
        fill(-114431);
        stroke(-114431);
      }

      if (grid_mode) {
        if (sloap||holoTriangle) {
          int X2=0, Y2=0, X1=0, Y1=0;
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
          //YD=(int)(Math.ceil(upY/grid_size)*grid_size)-Y1;
          if (mouseY<downY) {
            Y1=(int)((mouseY-camPosY)/grid_size)*grid_size+camPosY;
            Y2=(int)(Math.ceil((downY-camPosY)/grid_size)*grid_size)+camPosY;
          }
          if (triangleMode==0) {
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
          int XD=0, YD=0, X1=0, Y1=0;
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

          rect(X1, Y1, XD, YD);
        }
      } else {
        if (sloap||holoTriangle) {
          int X2=0, Y2=0, X1=0, Y1=0;
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
          if (triangleMode==0) {
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
          float xdif=mouseX-downX, ydif=mouseY-downY;

          rect(downX, downY, xdif, ydif);
        }
      }
    }

    if (draw&&ground) {

      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }

      current.parts.add(new Ground(X1, Y1, XD, YD, Color));
      draw=false;
    }

    if (draw&&holo_gram) {
      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new Holo(X1, Y1, XD, YD, Color));
      draw=false;
    }

    if (draw&&dethPlane) {
      float xdif=upX-downX, ydif=upY-downY;
      int X1=0, XD=0, Y1=0, YD=0;
      if (grid_mode) {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      } else {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new DethPlane(X1, Y1, XD, YD));
      draw=false;
    }


    if (check_point&&draw) {
      if (grid_mode) {
        current.parts.add(new CheckPoint(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));
      } else {
        current.parts.add(new CheckPoint((int)mouseX+camPos, (int)mouseY-camPosY));
      }
      draw=false;
    }
    if (goal&&draw) {
      if (grid_mode) {
        current.parts.add(new Goal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size));
      } else {
        current.parts.add(new Goal((int)mouseX+camPos, (int)mouseY-camPosY));
      }
      draw=false;
    }

    if (deleteing&&delete) {
      int index=colid_index(mouseX+camPos, mouseY-camPosY, current);
      if (index==-1) {
      } else {
        current.parts.remove(index);
      }
      delete=false;
    }

    if (drawCoins) {
      if (grid_mode) {
        drawCoin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 3);
      } else {
        drawCoin(mouseX, mouseY, 3);
      }
    }

    if (drawingPortal) {
      if (grid_mode) {
        drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
      } else {
        drawPortal(mouseX, mouseY, 1);
      }
    }

    if (drawingPortal3) {
      if (grid_mode) {
        drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
      } else {
        drawPortal(mouseX, mouseY, 1);
      }
    }

    if (sloap&&draw) {
      //float xdif=upX-downX,ydif=upY-downY;
      int X1=0, X2=0, Y1=0, Y2=0;
      if (grid_mode) {


        if (upX>downX) {
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
      } else {

        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }

      current.parts.add(new Sloap(X1, Y1, X2, Y2, triangleMode, Color));
      draw=false;
    }

    if (holoTriangle&&draw) {
      int X1=0, X2=0, Y1=0, Y2=0;
      if (grid_mode) {


        if (upX>downX) {
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
      } else {


        if (upX>downX) {
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
        if (downX==upX) {
          draw=false;
          return ;
        }
        if (downY==upY) {
          draw=false;
          return;
        }
      }
      current.parts.add(new HoloTriangle(X1, Y1, X2, Y2, triangleMode, Color));
      draw=false;
    }
    if (check_point) {
      if (grid_mode) {
        drawCheckPoint(Math.round((mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round((mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
      } else {
        drawCheckPoint(mouseX, mouseY);
      }
    }
    if (drawingSign) {
      if (grid_mode) {
        drawSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, Scale);
      } else {
        drawSign(mouseX, mouseY, Scale);
      }
    }
    if(placingSound){
      if (grid_mode) {
        drawSoundBox(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
      } else {
        drawSoundBox(mouseX, mouseY);
      }
    }


    //the accual gut part
  }

  if (current.type.equals("3Dstage")) {

    if (!e3DMode) {

      if (drawing) {
        fill(Color);
        stroke(Color);
        if (dethPlane) {
          fill(-114431);
          stroke(-114431);
        }

        if (grid_mode||holo_gram) {
          int XD=0, YD=0, X1=0, Y1=0;
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

          rect(X1, Y1, XD, YD);
        } else {//end of grid mode
          strokeWeight(0);
          float xdif=mouseX-downX, ydif=mouseY-downY;
          rect(downX, downY, xdif, ydif);
        }
      }//end of drawing

      if (draw&&ground) {
        float xdif=upX-downX, ydif=upY-downY;
        int X1=0, XD=0, Y1=0, YD=0;
        if (grid_mode) {


          if (upX>downX) {
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
          if (downX==upX) {
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        } else {


          if (upX>downX) {
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
          if (downX==upX) {
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        }
        current.parts.add(new Ground(X1, Y1, startingDepth, XD, YD, totalDepth, Color));
        draw=false;
      }
      if (draw&&holo_gram) {
        float xdif=upX-downX, ydif=upY-downY;
        int X1=0, XD=0, Y1=0, YD=0;
        if (grid_mode) {


          if (upX>downX) {
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
          if (downX==upX) {
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        } else {


          if (upX>downX) {
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
          if (downX==upX) {
            draw=false;
            return ;
          }
          if (downY==upY) {
            draw=false;
            return;
          }
        }
        current.parts.add(new Holo(X1, Y1, startingDepth, XD, YD, totalDepth, Color));
        draw=false;
      }

      if (deleteing&&delete) {
        int index=colid_index(mouseX+camPos, mouseY-camPosY, level.stages.get(currentStageIndex));
        if (index==-1) {
        } else {
          current.parts.remove(index);
        }
        delete=false;
      }
      if (draw3DSwitch1) {
        if (grid_mode) {
          draw3DSwitch1(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          draw3DSwitch1(mouseX, mouseY, 1);
        }
      }
      if (draw3DSwitch2) {
        if (grid_mode) {
          draw3DSwitch2(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          draw3DSwitch2(mouseX, mouseY, 1);
        }
      }
      if (draw3DSwitch1&&draw) {
        if (grid_mode) {
          current.parts.add(new SWon3D(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new SWon3D((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (draw3DSwitch2&&draw) {
        if (grid_mode) {
          current.parts.add(new SWoff3D(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new SWoff3D((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (check_point&&draw) {
        if (grid_mode) {
          current.parts.add(new CheckPoint(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size, startingDepth));
        } else {
          current.parts.add(new CheckPoint((int)mouseX+camPos, (int)mouseY-camPosY, startingDepth));
        }
        draw=false;
      }

      if (drawingPortal) {
        if (grid_mode) {
          drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          drawPortal(mouseX, mouseY, 1);
        }
      }

      if (drawingPortal3) {
        if (grid_mode) {
          drawPortal(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 1);
        } else {
          drawPortal(mouseX, mouseY, 1);
        }
      }
      if (check_point) {
        if (grid_mode) {
          drawCheckPoint(Math.round((mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round((mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY);
        } else {
          drawCheckPoint(mouseX, mouseY);
        }
      }
      if (drawCoins) {
        if (grid_mode) {
          drawCoin(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, 3);
        } else {
          drawCoin(mouseX, mouseY, 3);
        }
      }
      if (drawingSign) {
        if (grid_mode) {
          drawSign(Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size-camPos, Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size+camPosY, Scale);
        } else {
          drawSign(mouseX, mouseY, Scale);
        }
      }
    }//end of is 3d mode off if statment
    else {//if 3dmode is on
      engageHUDPosition();//move the draw position to align with the camera


      disEngageHUDPosition();//move the draw position back to 0 0 0
    }//end of 3d mode on
  }
}

void GUImouseClicked() {
  if (editingStage||editingBlueprint) {



    Stage current=null;
    if (editingStage) {
      current=level.stages.get(currentStageIndex);
    }
    if (editingBlueprint) {
      current=workingBlueprint;
    }


    if (check_point) {
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        draw=true;
      }
    }
    if (goal) {
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        draw=true;
      }
    }
    if (deleteing) {
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
        delete=true;
      }
    }
    if (moving_player) {
      if (mouseX >=buttonMin && mouseX <= buttonMax && mouseY >= 40 && mouseY <= 90) {
      } else {
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
    if (drawCoins) {
      println("peepee poopoo");
      String tpe = current.type;
      //Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size , Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size
      if (grid_mode) {
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
      if (editingStage) {
        level.numOfCoins++;
        level.reloadCoins();
      }
    }
    if (drawingPortal) {

      portalStage1=new JSONObject();
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
      if (stageType.equals("3Dstage")) {
        portalStage1.setInt("z", startingDepth);
        portalStage2.setInt("linkZ", startingDepth);
      }
      portalStage2.setInt("link Index", currentStageIndex+1);
      drawingPortal=false;
      drawingPortal2=true;
      editingStage=false;
      preSI=currentStageIndex;
    }
    if (drawingPortal3) {

      if (grid_mode) {
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
      if (stageType.equals("3Dstage")) {
        portalStage2.setInt("z", startingDepth);
        portalStage1.setInt("linkZ", startingDepth);
      }
      level.stages.get(currentStageIndex).parts.add(new Interdimentional_Portal(portalStage2, level.stages.get(currentStageIndex).is3D));
      level.stages.get(preSI).parts.add(new Interdimentional_Portal(portalStage1, level.stages.get(preSI).is3D));
      portalStage2=null;
      portalStage1=null;
      drawingPortal3=false;
    }
    if (draw3DSwitch1) {

      draw=true;
    }
    if (draw3DSwitch2) {

      draw=true;
    }
    if (drawingSign&&!e3DMode) {
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

    if (selecting) {
      selectedIndex=colid_index(mouseX+camPos, mouseY-camPosY, current);
    }
    if (selectingBlueprint&&blueprints.length!=0) {
      StageComponent tmp;
      int ix, iy;
      if (grid_mode) {
        ix=Math.round(((int)mouseX+camPos)*1.0/grid_size)*grid_size;
        iy=Math.round(((int)mouseY-camPosY)*1.0/grid_size)*grid_size;
      } else {
        ix=mouseX+camPos;
        iy=mouseY-camPosY;
      }
      for (int i=0; i<blueprints[currentBluieprintIndex].parts.size(); i++) {
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
    if(placingSound){
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
  //translate(player1.x+DX,player1.y-DY,player1.z-DZ);
  //rotateY(radians(-(xangle-180)));
  //rotateX(radians(yangle));
  //translate(-640,-360,-623);
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
}

void disEngageHUDPosition() {
  //translate(640,360,623);
  //rotateX(radians(-yangle));
  //rotateY(radians((xangle-180)));
  //translate(-1*(player1.x+DX),-1*(player1.y-DY),-1*(player1.z-DZ));
  hint(ENABLE_DEPTH_TEST);
}

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

void renderBlueprint() {
  for (int i=0; i<displayBlueprint.parts.size(); i++) {
    displayBlueprint.parts.get(i).draw();
  }
}
