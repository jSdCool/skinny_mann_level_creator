class ToolBox extends PApplet {

  public ToolBox(int miliOffset) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    millisOffset=miliOffset;
  }

  public int redVal=0, greenVal=0, blueVal=0, CC=0;
  int rsp=0, gsp=0, bsp=0, selectedColor=0, millisOffset;
  String page="colors";
  Button colorPage, toolsPage, draw_coin, draw_portal, draw_sloap, draw_holoTriangle, draw_dethPlane, toggle3DMode, switch3D1, switch3D2, saveLevel, exitStageEdit, sign, select, selectionPage, stageSettings, skyColorB1, setSkyColor, resetSkyColor, placeBlueprint, nexBlueprint, prevBlueprint, playSound, nextSound, prevSound,checkpointButton,playPauseButton,groundButton,goalButton,deleteButton,movePlayerButton,gridModeButton,holoButton;
  boolean typingSign=false, settingSkyColor=false;

  public void settings() {
    size(1280, 720,P2D);//mac os requires a render to be specified
    smooth();
  }
  void setup() {
    textSize(50);
    colorPage=new Button(this,50, 50, 100, 50, "colors/depth");
    toolsPage=new Button(this,155, 50, 100, 50, "tools");
    selectionPage=new Button(this,260, 50, 100, 50, "selection");
    stageSettings=new Button(this,365, 50, 100, 50, "stage settings");
    
    toggle3DMode=new Button(this,820, 40+100, 50, 50, "  3D  ", 255, 203).setStrokeWeight(5).setHoverText("toggle 3D mode");
    switch3D1=new Button(this,880, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("turn 3D on switch");
    switch3D2=new Button(this,940, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("turn 3D off switch");
    saveLevel=new Button(this,1000, 40+100, 50, 50, "save", 255, 203).setStrokeWeight(5).setHoverText("save level");
    draw_sloap=new Button(this,700, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("sloap");
    draw_holoTriangle=new Button(this,760, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("holographic sloap(no colision)");
    draw_dethPlane=new Button(this,820, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("death plane");
    draw_coin=new Button(this,580, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("coin");
    draw_portal=new Button(this,640, 40+100, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("interdimentional portal");
    exitStageEdit= new Button(this,520, 40+100, 50, 50, " < ", 255, 203).setStrokeWeight(5).setHoverText("exit to overview");
    sign=new Button(this,1060, 140, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("sign");
    select=new Button(this,1120, 140, 50, 50, "select", 255, 203).setStrokeWeight(5).setHoverText("select");
    skyColorB1=new Button(this,150, 165, 40, 40, 255, 203).setStrokeWeight(0);
    setSkyColor=new Button(this,300, 580, 100, 30, "set sky color").setStrokeWeight(2);
    resetSkyColor=new Button(this,200, 165, 40, 40, "reset", 255, 203).setStrokeWeight(0);
    placeBlueprint=new Button(this,1180, 140, 50, 50, #0F1AD3, 203).setStrokeWeight(5).setHoverText("place blurprint");
    nexBlueprint=new Button(this,width/2+200, height*0.7-25, 50, 50, ">", 255, 203).setStrokeWeight(5);
    prevBlueprint=new Button(this,width/2-200, height*0.7-25, 50, 50, "<", 255, 203).setStrokeWeight(5);
    playSound=new Button(this,40, 200, 50, 50, 255, 203).setStrokeWeight(5).setHoverText("place sound");
    nextSound=new Button(this,width/2+300, height*0.4-25, 50, 50, ">", 255, 203).setStrokeWeight(5);
    prevSound=new Button(this,width/2-300, height*0.4-25, 50, 50, "<", 255, 203).setStrokeWeight(5);
    checkpointButton=new Button(this,160, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("check point");
    playPauseButton=new Button(this,40, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("play/pause the simulation");
    groundButton=new Button(this,100, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("solid ground");
    goalButton=new Button(this,220, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("finish line");
    deleteButton=new Button(this,280, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("delete");
    movePlayerButton=new Button(this,340, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("move player");
    gridModeButton=new Button(this,400, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("grid mode");
    holoButton=new Button(this,460, 40+100, 50, 50,255,203).setStrokeWeight(5).setHoverText("hologram (no collision)");
  }


  public void draw() {
    redVal=(int)((rsp/1080.0)*255);
    greenVal=(int)((gsp/1080.0)*255);
    blueVal=(int)((bsp/1080.0)*255);


    if (blueVal==255) {
      blueVal=254;
    }
    CC=(int)(Math.pow(16, 4)*redVal+Math.pow(16, 2)*greenVal+blueVal);
    CC=CC-16777215;

    if (page.equals("colors")) {
      stroke(0);
      background(CC);
      fill(255);
      strokeWeight(10);
      rect(100, 150, 1080, 50);
      rect(100, 300, 1080, 50);
      rect(100, 450, 1080, 50);
      fill(255, 0, 0);
      rect(rsp+75, 125, 50, 100);
      fill(0, 255, 0);
      rect(gsp+75, 275, 50, 100);
      fill(0, 0, 255);
      rect(bsp+75, 425, 50, 100);
      fill(255);
      strokeWeight(0);
      rect(440, 550, 400, 150);
      fill(0);
      textSize(30);
      textAlign(CENTER, CENTER);
      text(redVal, 640, 100);
      text(greenVal, 640, 250);
      text(blueVal, 640, 400);
      JSONObject colo=colors.getJSONObject(selectedColor);
      fill((int)(colo.getInt("red")*Math.pow(16, 4)+colo.getInt("green")*Math.pow(16, 2)+colo.getInt("blue"))-16777215);
      rect(600, 600, 80, 80);
      fill(180);
      rect(500, 600, 50, 80);
      rect(730, 600, 50, 80);
      rect(600, 560, 80, 30);
      fill(0);
      triangle(510, 640, 540, 625, 540, 655);
      triangle(770, 640, 740, 625, 740, 655);
      fill(0);
      textSize(15);
      text("save color", 640, 570);
      if (level!=null&&level.stages.size()>0&&currentStageIndex!=-1&&level.stages.get(currentStageIndex).type.equals("3Dstage")) {

        fill(255);
        rect(100, 550, 200, 150);
        rect(950, 550, 200, 150);
        fill(0);
        textSize(25);
        text("starting depth", 200, 570);
        text("total depth", 1050, 570);
        text(startingDepth, 200, 650);
        text(totalDepth, 1050, 650);
      }
      colorPage.draw();
      toolsPage.draw();
      selectionPage.draw();
      stageSettings.draw();
      if (settingSkyColor)
        setSkyColor.draw();
    }//end of if page is colors
    if (page.equals("tools")) {
      background(255*0.5);
      colorPage.draw();
      toolsPage.draw();
      selectionPage.draw();
      stageSettings.draw();

      if (editingStage) {


        playPauseButton.draw();
        fill(0);
        stroke(0);
        strokeWeight(0);
        if (simulating) {
          rect(50, 50+100, 8, 30);
          rect(70, 50+100, 8, 30);
        } else {
          triangle(50, 50+100, 75, 65+100, 50, 80+100);
        }

        if (!e3DMode) {
          strokeWeight(0);
          if (ground) {
            groundButton.setColor(255,#F2F258);
          } else {
            groundButton.setColor(255,203);
          }
          groundButton.draw();
          fill(-7254783);
          stroke(-7254783);
          rect(100, 70+100, 50, 20);
          fill(-16732415);
          stroke(-16732415);
          rect(100, 60+100, 50, 10);
          
          strokeWeight(0);
          if (check_point) {
            checkpointButton.setColor(255,#F2F258);
          } else {
            checkpointButton.setColor(255,203);
          }
          checkpointButton.draw();
          fill(#B9B9B9);
          strokeWeight(0);
          rect(168, 45+100, 5, 40);
          fill(#EA0202);
          stroke(#EA0202);
          strokeWeight(0);
          triangle(170, 85-60+20+100, 170, 85-40+20+100, 170+30, 85-50+20+100);
          strokeWeight(0);
          
          if (!level.stages.get(currentStageIndex).type.equals("3Dstage")) {
            if (goal) {
              goalButton.setColor(255,#F2F258);
            } else {
              goalButton.setColor(255,203);
            }
            goalButton.draw();
            fill(0);
            stroke(0);
            strokeWeight(0);
            rect(223, 43+100, 15, 15);
            rect(253, 43+100, 15, 15);
            rect(238, 58+100, 15, 15);
            rect(223, 73+100, 15, 15);
            rect(253, 73+100, 15, 15);
          }
          if (deleteing) {
            deleteButton.setColor(255,#F2F258);
          } else {
            deleteButton.setColor(255,203);
          }
          deleteButton.draw();
          fill(203);
          stroke(203);
          strokeWeight(0);
          rect(285, 55+100, 40, 5);
          rect(300, 50+100, 10, 5);
          rect(290, 60+100, 5, 20);
          rect(290, 80+100, 30, 5);
          rect(315, 60+100, 5, 20);
          rect(298, 60+100, 5, 20);
          rect(307, 60+100, 5, 20);

          if (moving_player) {
            movePlayerButton.setColor(255,#F2F258);
          } else {
            movePlayerButton.setColor(255,203);
          }
          movePlayerButton.draw();
          strokeWeight(0);
          draw_mann(365, 88+100, 1, 0.6, "red");

          if (grid_mode) {
            gridModeButton.setColor(255,#F2F258);
          } else {
            gridModeButton.setColor(255,203);
          }
          gridModeButton.draw();
          textSize(20);
          fill(0);
          stroke(0);
          strokeWeight(1);
          line(410, 42+100, 410, 87+100);
          line(420, 42+100, 420, 87+100);
          line(430, 42+100, 430, 87+100);
          line(440, 42+100, 440, 87+100);
          line(402, 50+100, 448, 50+100);
          line(402, 60+100, 448, 60+100);
          line(402, 70+100, 448, 70+100);
          line(402, 80+100, 448, 80+100);
          text(grid_size, 410, 80+100);
          strokeWeight(0);
          if (holo_gram) {
            holoButton.setColor(255,#F2F258);
          } else {
            holoButton.setColor(255,203);
          }
          holoButton.draw();
          exitStageEdit.draw();

          if (drawCoins) {
            draw_coin.setColor(255, #F2F258);
          } else {
            draw_coin.setColor(255, 203);
          }
          draw_coin.draw();
          drawCoin(605, 65+100, 4);
          if (drawingPortal) {
            draw_portal.setColor(255, #F2F258);
          } else {
            draw_portal.setColor(255, 203);
          }
          draw_portal.draw();
          drawPortal(665, 65+100, 0.45);

          if (!level.stages.get(currentStageIndex).type.equals("3Dstage")) {
            if (sloap) {
              draw_sloap.setColor(255, #F2F258);
            } else {
              draw_sloap.setColor(255, 203);
            }//draw_holoTriangle
            draw_sloap.draw();
            fill(-7254783);
            stroke(-7254783);
            strokeWeight(0);
            triangle(705, 85+100, 745, 85+100, 745, 45+100);
            if (holoTriangle) {
              draw_holoTriangle.setColor(255, #F2F258);
            } else {
              draw_holoTriangle.setColor(255, 203);
            }//draw_holoTriangle
            draw_holoTriangle.draw();
            fill(-4623063);
            stroke(-4623063);
            strokeWeight(0);
            triangle(765, 85+100, 805, 85+100, 805, 45+100);


            if (dethPlane) {
              draw_dethPlane.setColor(255, #F2F258);
            } else {
              draw_dethPlane.setColor(255, 203);
            }//draw_holoTriangle
            draw_dethPlane.draw();
            fill(-114431);
            stroke(-114431);
            rect(825, 65+100, 40, 20);

            if (selectingBlueprint) {
              placeBlueprint.setColor(#0F1AD3, #F2F258);
            } else {
              placeBlueprint.setColor(#0F1AD3, 203);
            }
            placeBlueprint.draw();

            if (placingSound) {
              playSound.setColor(255, #F2F258);
            } else {
              playSound.setColor(255, 203);
            }
            playSound.draw();
            drawSpeakericon(this, playSound.x+playSound.lengthX/2, playSound.y+playSound.lengthY/2, 0.5);
          }//end of level is not 3D

          if (drawingSign) {
            sign.setColor(255, #F2F258);
          } else {
            sign.setColor(255, 203);
          }
          sign.draw();
          drawSign(sign.x+sign.lengthX/2, sign.y+sign.lengthY, 0.6);

          if (selecting) {
            select.setColor(255, #F2F258);
          } else {
            select.setColor(255, 203);
          }
          select.draw();
        }//end of not in 3D mode


        saveLevel.draw();


        //button hover text
        textAlign(LEFT, BOTTOM);
        playPauseButton.drawHoverText();
        if (!e3DMode) {
          groundButton.drawHoverText();
          checkpointButton.drawHoverText();
          if (!level.stages.get(currentStageIndex).type.equals("3Dstage")) {
            goalButton.drawHoverText();
          }

          deleteButton.drawHoverText();
          movePlayerButton.drawHoverText();
          gridModeButton.drawHoverText();
          holoButton.drawHoverText();
          exitStageEdit.drawHoverText();
          draw_coin.drawHoverText();
          draw_portal.drawHoverText();
          if (!level.stages.get(currentStageIndex).type.equals("3Dstage")) {
            draw_sloap.drawHoverText();
            draw_holoTriangle.drawHoverText();
            draw_dethPlane.drawHoverText();
            placeBlueprint.drawHoverText();
          }//end of level is not 3D
          playSound.drawHoverText();

          sign.drawHoverText();
          select.drawHoverText();
        }//end of not 3d mode
        saveLevel.drawHoverText();


        if (level.stages.get(currentStageIndex).type.equals("3Dstage")) {

          if (!e3DMode) {
            toggle3DMode.setColor(255, 203);
            toggle3DMode.draw();

            playPauseButton.draw();
            fill(0);
            stroke(0);
            strokeWeight(0);
            if (simulating) {
              rect(50, 50+100, 8, 30);
              rect(70, 50+100, 8, 30);
            } else {
              triangle(50, 50+100, 75, 65+100, 50, 80+100);
            }

            strokeWeight(0);
            if (ground) {
              groundButton.setColor(255,#F2F258);
            } else {
              groundButton.setColor(255,203);
            }
            groundButton.draw();
            fill(-7254783);
            stroke(-7254783);
            rect(100, 70+100, 50, 20);
            fill(-16732415);
            stroke(-16732415);
            rect(100, 60+100, 50, 10);
            exitStageEdit.draw();
            textAlign(LEFT, BOTTOM);

            if (grid_mode) {
              gridModeButton.setColor(255,#F2F258);
            } else {
              gridModeButton.setColor(255,203);
            }
            gridModeButton.draw();
            textSize(20);
            fill(0);
            stroke(0);
            strokeWeight(1);
            line(410, 42+100, 410, 87+100);
            line(420, 42+100, 420, 87+100);
            line(430, 42+100, 430, 87+100);
            line(440, 42+100, 440, 87+100);
            line(402, 50+100, 448, 50+100);
            line(402, 60+100, 448, 60+100);
            line(402, 70+100, 448, 70+100);
            line(402, 80+100, 448, 80+100);
            text(grid_size, 410, 80+100);
            strokeWeight(0);
            if (deleteing) {
              deleteButton.setColor(255,#F2F258);
            } else {
              deleteButton.setColor(255,203);
            }
            deleteButton.draw();
            fill(203);
            stroke(203);
            strokeWeight(0);
            rect(285, 55+100, 40, 5);
            rect(300, 50+100, 10, 5);
            rect(290, 60+100, 5, 20);
            rect(290, 80+100, 30, 5);
            rect(315, 60+100, 5, 20);
            rect(298, 60+100, 5, 20);
            rect(307, 60+100, 5, 20);

            if (moving_player) {
              movePlayerButton.setColor(255,#F2F258);
            } else {
              movePlayerButton.setColor(255,203);
            }
            movePlayerButton.draw();
            strokeWeight(0);
            draw_mann(365, 88+100, 1, 0.6, "red");






            if (check_point) {
              checkpointButton.setColor(255,#F2F258);
            } else {
              checkpointButton.setColor(255,203);
            }
            checkpointButton.draw();
            fill(#B9B9B9);
            strokeWeight(0);
            rect(168, 45+100, 5, 40);
            fill(#EA0202);
            stroke(#EA0202);
            strokeWeight(0);
            triangle(170, 85-60+20+100, 170, 85-40+20+100, 170+30, 85-50+20+100);



            if (holo_gram) {
              holoButton.setColor(255,#F2F258);
            } else {
              holoButton.setColor(255,203);
            }
            holoButton.draw();

            if (draw3DSwitch1) {
              switch3D1.setColor(255, #F2F258);
            } else {
              switch3D1.setColor(255, 203);
            }
            switch3D1.draw();
            draw3DSwitch1(905, 80+100, 1);

            if (draw3DSwitch2) {
              switch3D2.setColor(255, #F2F258);
            } else {
              switch3D2.setColor(255, 203);
            }
            switch3D2.draw();
            draw3DSwitch2(965, 80+100, 1);

            if (drawingPortal) {
              draw_portal.setColor(255, #F2F258);
            } else {
              draw_portal.setColor(255, 203);
            }
            draw_portal.draw();
            drawPortal(665, 65+100, 0.45);

            if (drawCoins) {
              draw_coin.setColor(255, #F2F258);
            } else {
              draw_coin.setColor(255, 203);
            }
            draw_coin.draw();
            drawCoin(605, 65+100, 4);

            saveLevel.draw();
            textAlign(LEFT, BOTTOM);
            toggle3DMode.drawHoverText();
            switch3D1.drawHoverText();
            switch3D2.drawHoverText();
            checkpointButton.drawHoverText();
            draw_portal.drawHoverText();
            if (holoButton.isMouseOver()) {//this one has to stay
              stroke(0);
              fill(200);
              strokeWeight(2);
              rect(mouseX-4, mouseY-13, 165, 16);
              fill(0);
              textSize(15);
              text("hologram (solid in 3D)", mouseX, mouseY+5);
            }
            draw_coin.drawHoverText();
            saveLevel.drawHoverText();
            textAlign(LEFT, BOTTOM);
            playPauseButton.drawHoverText();
            groundButton.drawHoverText();
            exitStageEdit.drawHoverText();
            gridModeButton.drawHoverText();
            deleteButton.drawHoverText();
          }//end of if not in 3D mode
          else {
            toggle3DMode.setColor(255, #F2F258);
            toggle3DMode.draw();
            textAlign(LEFT, BOTTOM);
            toggle3DMode.drawHoverText();
          }
        }//end of if stage is 3D

        if (selectingBlueprint) {
          textAlign(CENTER, CENTER);
          if (blueprints.length==0) {
            fill(0);
            textSize(25);
            text("you have no blueprints", width/2, height*0.7);
          } else {
            fill(0);
            textSize(25);
            text(blueprints[currentBluieprintIndex].name, width/2, height*0.7);
            if (currentBluieprintIndex>0)
              prevBlueprint.draw();
            if (currentBluieprintIndex<blueprints.length-1)
              nexBlueprint.draw();
          }
        }
      }//end of if edditing
      else if (editingBlueprint) {
        if (workingBlueprint.type.equals("blueprint")) {
          strokeWeight(0);
          if (ground) {
            groundButton.setColor(255,#F2F258);
          } else {
            groundButton.setColor(255,203);
          }
          groundButton.draw();
          fill(-7254783);
          stroke(-7254783);
          rect(100, 70+100, 50, 20);
          fill(-16732415);
          stroke(-16732415);
          rect(100, 60+100, 50, 10);

          strokeWeight(0);
          if (check_point) {
            checkpointButton.setColor(255,#F2F258);
          } else {
            checkpointButton.setColor(255,203);
          }
          checkpointButton.draw();
          fill(#B9B9B9);
          strokeWeight(0);
          rect(168, 45+100, 5, 40);
          fill(#EA0202);
          stroke(#EA0202);
          strokeWeight(0);
          triangle(170, 85-60+20+100, 170, 85-40+20+100, 170+30, 85-50+20+100);
          strokeWeight(0);

          textAlign(LEFT, BOTTOM);

          if (grid_mode) {
            gridModeButton.setColor(255,#F2F258);
          } else {
            gridModeButton.setColor(255,203);
          }
          gridModeButton.draw();
          textSize(20);
          fill(0);
          stroke(0);
          strokeWeight(1);
          line(410, 42+100, 410, 87+100);
          line(420, 42+100, 420, 87+100);
          line(430, 42+100, 430, 87+100);
          line(440, 42+100, 440, 87+100);
          line(402, 50+100, 448, 50+100);
          line(402, 60+100, 448, 60+100);
          line(402, 70+100, 448, 70+100);
          line(402, 80+100, 448, 80+100);
          text(grid_size, 410, 80+100);
          strokeWeight(0);
          if (deleteing) {
            deleteButton.setColor(255,#F2F258);
          } else {
            deleteButton.setColor(255,203);
          }
          deleteButton.draw();
          fill(203);
          stroke(203);
          strokeWeight(0);
          rect(285, 55+100, 40, 5);
          rect(300, 50+100, 10, 5);
          rect(290, 60+100, 5, 20);
          rect(290, 80+100, 30, 5);
          rect(315, 60+100, 5, 20);
          rect(298, 60+100, 5, 20);
          rect(307, 60+100, 5, 20);

          if (drawCoins) {
            draw_coin.setColor(255, #F2F258);
          } else {
            draw_coin.setColor(255, 203);
          }
          draw_coin.draw();
          drawCoin(605, 65+100, 4);

          if (sloap) {
            draw_sloap.setColor(255, #F2F258);
          } else {
            draw_sloap.setColor(255, 203);
          }//draw_holoTriangle
          draw_sloap.draw();
          fill(-7254783);
          stroke(-7254783);
          strokeWeight(0);
          triangle(705, 85+100, 745, 85+100, 745, 45+100);
          if (holoTriangle) {
            draw_holoTriangle.setColor(255, #F2F258);
          } else {
            draw_holoTriangle.setColor(255, 203);
          }//draw_holoTriangle
          draw_holoTriangle.draw();
          fill(-4623063);
          stroke(-4623063);
          strokeWeight(0);
          triangle(765, 85+100, 805, 85+100, 805, 45+100);
          if (holo_gram) {
            holoButton.setColor(255,#F2F258);
          } else {
            holoButton.setColor(255,203);
          }
          holoButton.draw();
          saveLevel.draw();

          textAlign(LEFT, BOTTOM);
          groundButton.drawHoverText();
          gridModeButton.drawHoverText();
          deleteButton.drawHoverText();
          holoButton.drawHoverText();
          draw_coin.drawHoverText();
          saveLevel.drawHoverText();
          checkpointButton.drawHoverText();
          draw_sloap.drawHoverText();
          draw_holoTriangle.drawHoverText();
        }//end of type is blueprint
      } else {
        fill(0);
        textSize(20);
        text("you are not currently editing a stage", 300, 300);
      }
    }//end of if page is tools
    if (page.equals("selection")) {
      background(#790101);
      colorPage.draw();
      toolsPage.draw();
      selectionPage.draw();
      stageSettings.draw();

      if (selectedIndex==-1) {//if nothing is selected
        fill(0);
        textSize(20);
        textAlign(CENTER, CENTER);
        text("nothing is selected", width/2, height/2);
      } else {
        StageComponent thing = level.stages.get(currentStageIndex).parts.get(selectedIndex);
        String type=thing.type;
        if (type.equals("WritableSign")) {//if the current selected object is a sign
          fill(0);
          textSize(25);
          textAlign(CENTER, CENTER);
          text("sign contents", width/2, height*0.2);
          textAlign(CENTER, TOP);
          String contents=thing.getData();
          if (typingSign) {
            contents+=coursorr;
          }
          text(contents, width/2, height*0.25);
          rect(width*0.05, height*0.29, width*0.9, 2);
        } else if (type.equals("sound box")) {
          if (level.sounds.size()==0) {
            fill(0);
            textSize(20);
            textAlign(CENTER, CENTER);
            text("this level does not have any sounds currently", width/2, height/2);
          } else {
            int fileind=0;
            String[] keys=new String[0];
            keys=level.sounds.keySet().toArray(keys);
            String current=thing.getData();
            for (int i=0; i<keys.length; i++) {
              if (keys[i].equals(current)) {
                fileind=i;
                break;
              }
            }
            fill(0);
            textSize(25);
            text("current sound: "+keys[fileind], width/2, height*0.4);
            thing.setData(keys[fileind]);
            if (fileind>0)
              prevSound.draw();
            if (fileind<keys.length-1)
              nextSound.draw();
          }
        } else {
          fill(0);
          textSize(20);
          textAlign(CENTER, CENTER);
          text("this object does not have any\nproperties that can be changed", width/2, height/2);
        }
      }//end of thing is selected
    }//end of selection page
    if (page.equals("stage settings")) {
      background(#92CED8);
      colorPage.draw();
      toolsPage.draw();
      selectionPage.draw();
      stageSettings.draw();
      if (editingStage) {
        fill(0);
        textSize(25);
        textAlign(LEFT, CENTER);
        text("stage name: "+level.stages.get(currentStageIndex).name, 50, 150);
        text("sky color: ", 50, 180);
        skyColorB1.setColor(level.stages.get(currentStageIndex).skyColor, 0);
        skyColorB1.draw();
        resetSkyColor.draw();
      } else {//end of editing stage
        fill(0);
        textSize(30);
        textAlign(CENTER, CENTER);
        text("you are not currently editing a stage", width/2, height/2);
      }//end of not editing stage
    }//end of stage settings page
  }//end of draw

  public void mouseClicked() {
    if (page.equals("colors")) {
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 150 && mouseY <= 200) {
        rsp=mouseX-75;
      }
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 300 && mouseY <= 350) {
        gsp=mouseX-75;
      }
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 450 && mouseY <= 500) {
        bsp=mouseX-75;
      }
      if (mouseX >= 600 && mouseX <=680 && mouseY >= 600 && mouseY <=680) {
        JSONObject colo=colors.getJSONObject(selectedColor);
        rsp=(int)Math.ceil(colo.getInt("red")/255.0*1080);
        gsp=(int)Math.ceil(colo.getInt("green")/255.0*1080);
        bsp=(int)Math.ceil(colo.getInt("blue")/255.0*1080);
      }
      if (mouseX >= 500 && mouseX <= 550 && mouseY >= 600 && mouseY <=680&&selectedColor>0) {
        selectedColor--;
      }

      if (mouseX >= 730 && mouseX <= 780 && mouseY >= 600 && mouseY <=680&&selectedColor<colors.size()-1) {
        selectedColor++;
      }
      if (mouseX >= 600 && mouseX <=680  && mouseY >= 560 && mouseY <=590) {
        JSONObject colo=new JSONObject();
        colo.setInt("red", redVal);
        colo.setInt("green", greenVal);
        colo.setInt("blue", blueVal);
        colors.setJSONObject(colors.size(), colo);
        saveColors=true;
      }
      if (settingSkyColor) {
        if (setSkyColor.isMouseOver()) {
          settingSkyColor=false;
          page="stage settings";
          level.stages.get(currentStageIndex).skyColor=CC;
        }
      }
    }//end of if pages is colors

    if (colorPage.isMouseOver()) {
      page="colors";
    }
    if (toolsPage.isMouseOver()) {
      page="tools";
    }
    if (selectionPage.isMouseOver()) {
      page="selection";
    }
    if (stageSettings.isMouseOver()) {
      page="stage settings";
    }

    if (page.equals("tools")) {
      if (editingStage) {
        if (level.stages.get(currentStageIndex).type.equals("stage")) {
          if (draw_coin.isMouseOver()) {
            turnThingsOff();
            drawCoins=true;
          }
          if (draw_portal.isMouseOver()) {
            turnThingsOff();
            drawingPortal=true;
          }
          if (draw_sloap.isMouseOver()) {
            turnThingsOff();
            sloap=true;
          }
          if (draw_holoTriangle.isMouseOver()) {
            turnThingsOff();
            holoTriangle=true;
          }
          if (draw_dethPlane.isMouseOver()) {
            turnThingsOff();
            dethPlane=true;
          }

            if (playPauseButton.isMouseOver()) {
              extra=true;
              if (extra&&simulating) {
                simulating=false;
                extra=false;
              }
              if (extra&&!simulating) {
                simulating=true;
                extra=false;
              }
            }
          

          if (groundButton.isMouseOver()) {
            turnThingsOff();
            ground=true;
          }
          if (checkpointButton.isMouseOver()) {
            turnThingsOff();
            check_point=true;
          }
          if (goalButton.isMouseOver()) {
            turnThingsOff();
            goal=true;
          }
          if (deleteButton.isMouseOver()) {
            turnThingsOff();
            deleteing=true;
          }
          if (movePlayerButton.isMouseOver()) {
            turnThingsOff();
            moving_player=true;
          }
          if (gridModeButton.isMouseOver()) {
            extra=true;
            if (extra&&grid_mode) {
              grid_mode=false;
              extra=false;
            }
            if (extra&&!grid_mode) {
              grid_mode=true;
              extra=false;
            }
          }

          if (holoButton.isMouseOver()) {
            turnThingsOff();
            holo_gram=true;
          }

          if (exitStageEdit.isMouseOver()) {
            turnThingsOff();
            levelOverview=true;
            editingStage=false;
          }
          if (sign.isMouseOver()) {
            turnThingsOff();
            drawingSign=true;
          }

          if (select.isMouseOver()) {
            turnThingsOff();
            selecting=true;
          }
          if (placeBlueprint.isMouseOver()) {
            turnThingsOff();

            String[] files=new File(System.getenv("AppData")+"/CBi-games/skinny mann level creator/blueprints").list();
            int numofjsons=0;
            for (int i=0; i<files.length; i++) {
              if (files[i].contains(".json")) {
                numofjsons++;
              }
            }
            blueprints=new Stage[numofjsons];
            int pointer=0;
            for (int i=0; i<files.length; i++) {
              if (files[i].contains(".json")) {
                blueprints[pointer]=new Stage(loadJSONArray(System.getenv("AppData")+"/CBi-games/skinny mann level creator/blueprints/"+files[i]));
                pointer++;
              }
            }
            println(blueprints.length);
            selectingBlueprint=true;
            currentBluieprintIndex=0;
          }
          if (selectingBlueprint) {
            if (currentBluieprintIndex>0&&prevBlueprint.isMouseOver())
              currentBluieprintIndex--;
            if (currentBluieprintIndex<blueprints.length-1&&nexBlueprint.isMouseOver())
              currentBluieprintIndex++;
          }
          if (playSound.isMouseOver()) {
            turnThingsOff();
            placingSound=true;
          }
        }

        if (level.stages.get(currentStageIndex).type.equals("3Dstage")) {

          if (!e3DMode) {

              if (playPauseButton.isMouseOver()) {
                extra=true;
                if (extra&&simulating) {
                  simulating=false;
                  extra=false;
                }
                if (extra&&!simulating) {
                  simulating=true;
                  extra=false;
                }
              }
            

            if (groundButton.isMouseOver()) {
              turnThingsOff();
              ground=true;
            }

            if (deleteButton.isMouseOver()) {
              turnThingsOff();
              deleteing=true;
            }

            if (gridModeButton.isMouseOver()) {
              extra=true;
              if (extra&&grid_mode) {
                grid_mode=false;
                extra=false;
              }
              if (extra&&!grid_mode) {
                grid_mode=true;
                extra=false;
              }
            }

            if (movePlayerButton.isMouseOver()) {
              turnThingsOff();
              moving_player=true;
            }

            if (exitStageEdit.isMouseOver()) {
              turnThingsOff();
              levelOverview=true;
              editingStage=false;
            }



            if (checkpointButton.isMouseOver()) {
              turnThingsOff();
              check_point=true;
            }

            if (toggle3DMode.isMouseOver()) {
              e3DMode=true;
              return;
            }
            if (switch3D1.isMouseOver()) {
              turnThingsOff();
              draw3DSwitch1=true;
            }
            if (switch3D2.isMouseOver()) {
              turnThingsOff();
              draw3DSwitch2=true;
            }
            if (draw_portal.isMouseOver()) {
              turnThingsOff();
              drawingPortal=true;
            }
            if (holoButton.isMouseOver()) {
              turnThingsOff();
              holo_gram=true;
            }
            if (draw_coin.isMouseOver()) {
              turnThingsOff();
              drawCoins=true;
            }
            if (sign.isMouseOver()) {
              turnThingsOff();
              drawingSign=true;
            }
            if (select.isMouseOver()) {
              turnThingsOff();
              selecting=true;
            }
          } else {
            if (toggle3DMode.isMouseOver()) {
              e3DMode=false;
            }

              if (playPauseButton.isMouseOver()) {
                extra=true;
                if (extra&&simulating) {
                  simulating=false;
                  extra=false;
                }
                if (extra&&!simulating) {
                  simulating=true;
                  extra=false;
                }
              }
            
            if (sign.isMouseOver()) {
              turnThingsOff();
              drawingSign=true;
            }
            if (select.isMouseOver()) {
              turnThingsOff();
              selecting=true;
            }
          }//end of 3D mode is on
        }

        if (saveLevel.isMouseOver()) {
          println("saving level");
          level.save();
          gmillis=millis()+400+millisOffset;
          println("save complete"+gmillis);
        }
      }//end of edditing stage
      else if (editingBlueprint) {
        if (workingBlueprint.type.equals("blueprint")) {
          if (groundButton.isMouseOver()) {
            turnThingsOff();
            ground=true;
          }

          if (deleteButton.isMouseOver()) {
            turnThingsOff();
            deleteing=true;
          }

          if (gridModeButton.isMouseOver()) {
            extra=true;
            if (extra&&grid_mode) {
              grid_mode=false;
              extra=false;
            }
            if (extra&&!grid_mode) {
              grid_mode=true;
              extra=false;
            }
          }
          if (holoButton.isMouseOver()) {
            turnThingsOff();
            holo_gram=true;
          }
          if (draw_coin.isMouseOver()) {
            turnThingsOff();
            drawCoins=true;
          }
          if (checkpointButton.isMouseOver()) {
            turnThingsOff();
            check_point=true;
          }
          if (draw_sloap.isMouseOver()) {
            turnThingsOff();
            sloap=true;
          }
          if (draw_holoTriangle.isMouseOver()) {
            turnThingsOff();
            holoTriangle=true;
          }
          if (saveLevel.isMouseOver()) {
            println("saving blueprint");
            workingBlueprint.save();
            gmillis=millis()+400+millisOffset;
            println("save complete"+gmillis);
          }
        }//end of type is blueprint
      }//end of editing blueprint
    }//end of tools

    if (page.equals("selection")) {
      if (selectedIndex!=-1) {
        StageComponent thing = level.stages.get(currentStageIndex).parts.get(selectedIndex);
        String type=thing.type;
        if (type.equals("WritableSign")) {//if the current selected object is a sign
          if (mouseX>=width*0.05&&mouseX<=width*0.9&&mouseY>=height*0.21&&mouseY<=height*0.29) {//place to click to start typing
            typingSign=true;
          } else {
            typingSign=false;
          }
        } else if (type.equals("sound box")) {
          if (level.sounds.size()==0) {
          } else {
            int fileind=0;
            String[] keys=new String[0];
            keys=level.sounds.keySet().toArray(keys);
            String current=thing.getData();
            for (int i=0; i<keys.length; i++) {
              if (keys[i].equals(current)) {
                fileind=i;
                break;
              }
            }

            if (fileind>0&&prevSound.isMouseOver())
              thing.setData(keys[fileind-1]);
            if (fileind<keys.length-1&&nextSound.isMouseOver())
              thing.setData(keys[fileind+1]);
          }
        }
      }//if something is elected
    }//end of page is selection
    if (page.equals("stage settings")) {
      if (editingStage) {
        if (skyColorB1.isMouseOver()) {
          settingSkyColor=true;
          page="colors";
        }//end of clicked on skyColorB1
        if (resetSkyColor.isMouseOver()) {
          level.stages.get(currentStageIndex).skyColor=#74ABFF;
        }//end of clicked on reset sky color
      }//end of editing stage
    }//end of page is stage settings
  }

  public void mouseDragged() {
    if (page.equals("colors")) {
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 150 && mouseY <= 200) {
        rsp=mouseX-75;
      }
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 300 && mouseY <= 350) {
        gsp=mouseX-75;
      }
      if (mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 450 && mouseY <= 500) {
        bsp=mouseX-75;
      }
    }//end of if pages is colors
  }

  void mouseWheel(MouseEvent event) {
    if (page.equals("colors")) {
      float wheel_direction = event.getCount()*-1;

      if (level!=null&&level.stages.size()>0&&level.stages.get(currentStageIndex).type.equals("3Dstage")) {
        if (mouseX>=100&&mouseX<=300&&mouseY>=550&&mouseY<=700) {
          startingDepth+=wheel_direction*5;
          if (startingDepth<0) {
            startingDepth=0;
          }
        }
        if (mouseX>=950&&mouseX<=1150&&mouseY>=550&&mouseY<=700) {
          totalDepth+=wheel_direction*5;
          if (totalDepth<5) {
            totalDepth=5;
          }
        }
      }
    }//end of if page is colors
  }


  void keyPressed() {

    if (page.equals("selection")) {
      if (selectedIndex!=-1) {
        StageComponent thing = level.stages.get(currentStageIndex).parts.get(selectedIndex);
        String type=thing.type;
        if (type.equals("WritableSign")) {//if the current selected object is a sign
          if (typingSign) {

            thing.setData(getInput(thing.getData(), 3, keyCode, key));
          }
        }
      }
    }//end of page is selection
  }//end of keypressed


  void drawCoin(float x, float y, float Scale) {
    strokeWeight(0);
    fill(#FCC703);
    circle(x, y, 12*Scale);
    fill(255, 255, 0);
    circle(x, y, 10*Scale);
    fill(#FCC703);
    rect(x-2*Scale, y-3*Scale, 4*Scale, 6*Scale);
  }

  void drawPortal(float x, float y, float scale) {
    fill(0);
    strokeWeight(0);
    ellipse(x, y, 50*scale, 100*scale);
    fill(#AE00FA);
    ellipse(x, y, 35*scale, 80*scale);
    fill(0);
    ellipse(x, y, 20*scale, 60*scale);
    fill(#AE00FA);
    ellipse(x, y, 5*scale, 40*scale);
  }

  void draw3DSwitch1(float x, float y, float Scale) {
    fill(196);
    strokeWeight(0);
    rect((x-20)*Scale, (y-5)*Scale, 40*Scale, 5*Scale);
    fill(#FAB800);
    rect((x-10)*Scale, (y-10)*Scale, 20*Scale, 5*Scale);
  }

  void draw3DSwitch2(float x, float y, float Scale) {
    fill(196);
    strokeWeight(0);
    rect((x-20)*Scale, (y-5)*Scale, 40*Scale, 5*Scale);
  }

  void drawCheckPoint(float x, float y) {
    fill(#B9B9B9);
    strokeWeight(0);
    rect((x-3)*Scale, (y-60)*Scale, 5*Scale, 60*Scale);
    fill(#EA0202);
    stroke(#EA0202);
    strokeWeight(0);
    triangle(x*Scale, (y-60)*Scale, x*Scale, (y-40)*Scale, (x+30)*Scale, (y-50)*Scale);
  }

  void drawSign(float x, float y, float Scale) {
    fill(#A54A00);
    rect(x-5*Scale, y-30*Scale, 10*Scale, 30*Scale);
    rect(x-35*Scale, y-65*Scale, 70*Scale, 40*Scale);
    fill(#C4C4C4);
    rect(x-33*Scale, y-63*Scale, 66*Scale, 36*Scale);
    fill(#767675);
    rect(x-30*Scale, y-58*Scale, 60*Scale, 2*Scale);
    rect(x-30*Scale, y-52*Scale, 60*Scale, 2*Scale);
    rect(x-30*Scale, y-46*Scale, 60*Scale, 2*Scale);
    rect(x-30*Scale, y-40*Scale, 60*Scale, 2*Scale);
    rect(x-30*Scale, y-34*Scale, 60*Scale, 2*Scale);
  }

  void draw_mann(float x, float y, int pose, float scale, String shirt_color) {
    strokeWeight(0);
    if (shirt_color.equals("red")) {
      fill(255, 0, 0);
      stroke(255, 0, 0);
    }
    if (shirt_color.equals("green")) {
      fill(0, 181, 0);
      stroke(0, 181, 0);
    }

    if (pose==1) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-10*scale, y-20*scale, scale*6, scale*10);
      rect(x+4*scale, y-20*scale, scale*6, scale*10);
      rect(x-10*scale, y-10*scale, scale*6, scale*10);
      rect(x+4*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==2) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-12*scale, y-20*scale, scale*6, scale*10);
      rect(x+6*scale, y-20*scale, scale*6, scale*10);
      rect(x-14*scale, y-10*scale, scale*6, scale*10);
      rect(x+8*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==3) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-13*scale, y-20*scale, scale*6, scale*10);
      rect(x+7*scale, y-20*scale, scale*6, scale*10);
      rect(x-18*scale, y-10*scale, scale*6, scale*10);
      rect(x+12*scale, y-10*scale, scale*6, scale*10);
    }
    if (pose==4) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-12*scale, y-30*scale, scale*6, scale*10);
      rect(x+6*scale, y-30*scale, scale*6, scale*10);
      rect(x-16*scale, y-20*scale, scale*6, scale*10);
      rect(x+10*scale, y-20*scale, scale*6, scale*10);
      rect(x-19*scale, y-10*scale, scale*6, scale*10);
      rect(x+15*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==5) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-13*scale, y-20*scale, scale*6, scale*10);
      rect(x+7*scale, y-20*scale, scale*6, scale*10);
      rect(x-18*scale, y-10*scale, scale*6, scale*10);
      rect(x+12*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==6) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-12*scale, y-20*scale, scale*6, scale*10);
      rect(x+6*scale, y-20*scale, scale*6, scale*10);
      rect(x-14*scale, y-10*scale, scale*6, scale*10);
      rect(x+8*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==7) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-10*scale, y-20*scale, scale*6, scale*10);
      rect(x+4*scale, y-20*scale, scale*6, scale*10);
      rect(x-10*scale, y-10*scale, scale*6, scale*10);
      rect(x+4*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==8) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-8*scale, y-20*scale, scale*6, scale*10);
      rect(x+2*scale, y-20*scale, scale*6, scale*10);
      rect(x-6*scale, y-10*scale, scale*6, scale*10);
      rect(x+1*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==9) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-7*scale, y-20*scale, scale*6, scale*10);
      rect(x+1*scale, y-20*scale, scale*6, scale*10);
      rect(x-2*scale, y-10*scale, scale*6, scale*10);
      rect(x-4*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==10) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-8*scale, y-30*scale, scale*6, scale*10);
      rect(x+2*scale, y-30*scale, scale*6, scale*10);
      rect(x-4*scale, y-20*scale, scale*6, scale*10);
      rect(x-4*scale, y-20*scale, scale*6, scale*10);
      rect(x+2*scale, y-10*scale, scale*6, scale*10);
      rect(x-7*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==11) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-7*scale, y-20*scale, scale*6, scale*10);
      rect(x+1*scale, y-20*scale, scale*6, scale*10);
      rect(x-2*scale, y-10*scale, scale*6, scale*10);
      rect(x-4*scale, y-10*scale, scale*6, scale*10);
    }

    if (pose==12) {
      rect(x-10*scale, y-55*scale, scale*20, scale*25);
      fill(-17813);
      stroke(-17813);
      rect(x-15*scale, y-75*scale, scale*30, scale*20);
      fill(-16763137);
      stroke(-16763137);
      rect(x-10*scale, y-30*scale, scale*6, scale*10);
      rect(x+4*scale, y-30*scale, scale*6, scale*10);
      rect(x-8*scale, y-20*scale, scale*6, scale*10);
      rect(x+2*scale, y-20*scale, scale*6, scale*10);
      rect(x-6*scale, y-10*scale, scale*6, scale*10);
      rect(x+1*scale, y-10*scale, scale*6, scale*10);
    }
  }
}//end of ColorSelectorScreen class
