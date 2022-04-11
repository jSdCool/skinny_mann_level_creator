import processing.sound.*;

void settings() {
  size(1280, 720, P3D);
}

void setup() {
  textSize(80);//make text not fuzzy
  loadJSONArray("data/colors.json");
  frameRate(60);
  surface.setTitle("skinny mann level creator");
  scr2 =new ToolBox(millis());
  colors=loadJSONArray("data/colors.json");
  thread("thrdCalc2");
  coin3D=loadShape("data/modles/coin/tinker.obj");
  coin3D.scale(3);
  initlizeButtons();
}
boolean startup=true, editing_level=true, player1_moving_right=false, player1_moving_left=false, dev_mode=false, player1_jumping=false, loading=false, newLevel=false, simulating=false, entering_file_path=false, coursor=false, level_complete=false, dead=false, entering_name=false, cam_left=false, cam_right=false, drawing=false, draw=false, extra=false, ground=false, check_point=false, goal=false, deleteing=false, delete=false, moving_player=false, grid_mode=false, holo_gram=false, editingStage=false, levelOverview=false, newFile=false, drawCoins=false, drawingPortal=false, drawingPortal2=false, drawingPortal3=false, E_pressed=false, saveColors=false, sloap=false, loopThread2=true, cam_up=false, cam_down=false, holoTriangle=false, dethPlane=false, setPlayerPosTo=false, e3DMode=false, WPressed=false, SPressed=false, draw3DSwitch1=false, draw3DSwitch2=false, checkpointIn3DStage=false, shadow3D=true, tutorialMode=false, drawingSign=false, selecting=false, viewingItemContents=false, loadingBlueprint=false, creatingNewBlueprint=false, editingBlueprint=false, selectingBlueprint=false, placingSound=false;
String file_path, new_name="my_level", GAME_version="0.5.0_Early_Access", EDITOR_version="0.0.1.8_EAc", rootPath="", coursorr="", newFileName="", newFileType="2D", stageType="", author="your name here", displayText="", fileToCoppyPath="";
//int player1 []={20,700,1,0,1,0};
Player player1 =new Player(20, 699, 1, "red");
int camPos=0, camPosY=0, death_cool_down, start_down, eadgeScroleDist=300, respawnX=20, respawnY=700, spdelay=0, Color=0, RedPos=0, BluePos=0, GreenPos=0, RC=0, GC=0, BC=0, grid_size=10, filesScrole=0, overviewSelection=-1, portalIndex1, stageIndex, preSI, respawnStage, setPlayerPosX, setPlayerPosY, setPlayerPosZ, startingDepth=0, totalDepth=300, respawnZ=50, coinRotation=0, coinCount=0, gmillis=0, eadgeScroleDistV=250, currentStageIndex, tutorialDrawLimit=0, displayTextUntill=0, drawCamPosX=0, drawCamPosY;
int buttonMin=0, buttonMax=0, coinsIndex, triangleMode=0, selectedIndex=-1, viewingItemIndex=-1, currentBluieprintIndex=0;
float[]tpCords=new float[3];
JSONArray mainIndex/*,coins*/, colors;
JSONObject portalStage1, portalStage2;
float downX, downY, upX, upY, Scale=1, gravity=0.001;
ToolBox scr2 ;
PShape coin3D;
Level level;
ArrayList<Boolean> coins = new ArrayList<Boolean>();
Stage workingBlueprint, blueprints[], displayBlueprint;
PApplet primaryWindow=this;
void draw() {

  if (frameCount%20==0) {
    coursor=false;
    coursorr="";
  }
  if (frameCount%40==0) {
    coursor=true;
    coursorr="|";
  }

  if (saveColors) {
    saveJSONArray(colors, "/data/colors.json");
    saveColors=false;
  }

  if (startup) {
    background(#48EDD8);
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(200, 300, 200, 80);
    rect(800, 300, 200, 80);
    fill(0);
    textSize(80);
    textAlign(LEFT, BOTTOM);
    text("new", 210, 370+15);
    text("load", 810, 370+15);
    fill(0);
    textSize(15);
    text("game ver: "+GAME_version+ "  editor ver: "+EDITOR_version, 0, 718);
    fill(0);
    textSize(15);
    text("author: "+author+coursorr, 10, 30);
    strokeWeight(0);
    rect(60, 31, textWidth(author), 1);
    newBlueprint.draw();
    loadBlueprint.draw();
  }
  if (loading) {
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name", 40, 100);
    if (rootPath!=null) {
      if (entering_file_path&&coursor) {
        text(rootPath+"|", 40, 150);
      } else {
        text(rootPath, 40, 150);
      }
    } else if (entering_file_path&&coursor) {
      text("|", 40, 150);
    }
    stroke(0);
    strokeWeight(1);
    line(40, 152, 1200, 152);
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(40, 400, 200, 40);
    fill(0);
    textSize(40);
    text("load", 50, 435+10);
  }
  if (newLevel) {
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name", 40, 100);
    if (new_name!=null) {
      if (entering_name&&coursor) {
        text(new_name+"|", 40, 150);
      } else {
        text(new_name, 40, 150);
      }
    } else if (entering_name&&coursor) {
      text("|", 40, 150);
    }
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(40, 400, 200, 40);
    fill(0);
    textSize(40);
    text("start", 50, 435+10);
    stroke(0);
    strokeWeight(1);
    line(40, 152, 800, 152);
  }


  if (editingStage) {
    //background(7646207);
    if (!simulating) {
      if (cam_left&&camPos>0) {
        camPos-=4;
      }
      if (cam_right) {
        camPos+=4;
      }
      if (cam_down&&camPosY>0) {
        camPosY-=4;
      }
      if (cam_up) {
        camPosY+=4;
      }
    }

    stageLevelDraw();
    stageEditGUI();

    if (selectingBlueprint&&blueprints.length!=0) {
      generateDisplayBlueprint();
      renderBlueprint();
    }
  }

  if (levelOverview) {
    background(#0092FF);
    fill(#7CC7FF);
    stroke(#7CC7FF);
    strokeWeight(0);
    if (overviewSelection!=-1) {
      rect(0, (overviewSelection- filesScrole)*60+80, 1280, 60);
      if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
        if (level.stages.get(overviewSelection).type.equals("stage")) {
          edditStage.draw();
          fill(255, 255, 0);
          strokeWeight(1);
          quad(1155, 37, 1129, 54, 1114, 39, 1140, 22);
          fill(#E5B178);
          triangle(1129, 54, 1114, 39, 1109, 53);
          setMainStage.draw();
          fill(255, 0, 0);
          quad(1030, 16, 1010, 40, 1030, 66, 1050, 40);
          if (setMainStage.isMouseOver()) {
            fill(200);
            rect(mouseX-4, mouseY-18, 135, 20);
            fill(0);
            textSize(15);
            textAlign(LEFT, BOTTOM);
            text("set as main stage", mouseX, mouseY);
          }
        }
        if (level.stages.get(overviewSelection).type.equals("3Dstage")) {
          edditStage.draw();
          fill(255, 255, 0);
          strokeWeight(1);
          quad(1155, 37, 1129, 54, 1114, 39, 1140, 22);
          fill(#E5B178);
          triangle(1129, 54, 1114, 39, 1109, 53);
        }
      }//end of thing slected is in stage range
    }//end of if something is selected
    textAlign(LEFT, BOTTOM);
    stroke(0);
    strokeWeight(2);
    line(0, 80, 1280, 80);
    fill(0);
    textSize(30);

    String[] keys=new String[0];//create a string array that can be used to place the sound keys in
    keys=level.sounds.keySet().toArray(keys);//place the sound keys into the array
    for (int i=0; i < 11 && i + filesScrole < level.stages.size()+level.sounds.size(); i++) {//loop through all the stages and sounds and display 11 of them on screen
      if (i+ filesScrole<level.stages.size()) {//if the current thing attemping to diaply is in the range of stages
        fill(0);
        String displayName=level.stages.get(i+ filesScrole).name, type=level.stages.get(i+ filesScrole).type;//get the name and type of the stages
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("stage")) {//if it is a stage then display the stage icon
          drawWorldSymbol(20, 90+60*(i));
        }
      } else {//if the thing is not a stage type
        fill(0);
        String displayName=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).name, type=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).type;//get the name and type of a sound in the level
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("sound")) {//if the thing is a sound then display the sound icon
          drawSpeakericon(this, 40, 110+60*(i), 0.5);
        }
      }
    }
    textAlign(CENTER, CENTER);
    newStage.draw();
    fill(0);
    textSize(90);
    text("+", 1230, 25);
    textAlign(LEFT, BOTTOM);
    respawnX=(int)level.SpawnX;
    respawnY=(int)level.SpawnY;
    respawnStage=level.mainStage;

    overview_saveLevel.draw();
    help.draw();
    if (filesScrole>0)
      overviewUp.draw();
    if (filesScrole+11<level.stages.size()+level.sounds.size())
      overviewDown.draw();
  }//end of level over view



  if (newFile) {
    background(#0092FF);
    stroke(0);
    strokeWeight(2);
    line(100, 450, 1200, 450);
    if (newFileType.equals("2D")) {
      new2DStage.setColor(#BB48ED, #51DFFA);
      new3DStage.setColor(#BB48ED, #4857ED);
      addSound.setColor(#BB48ED, #4857ED);
    } else if (newFileType.equals("3D")) {
      new3DStage.setColor(#BB48ED, #51DFFA);
      new2DStage.setColor(#BB48ED, #4857ED);
      addSound.setColor(#BB48ED, #4857ED);
    } else if (newFileType.equals("sound")) {
      new3DStage.setColor(#BB48ED, #4857ED);
      new2DStage.setColor(#BB48ED, #4857ED);
      addSound.setColor(#BB48ED, #51DFFA);
    }
    //println(newFileType);
    new2DStage.draw();
    new3DStage.draw();
    addSound.draw();
    newFileCreate.draw();
    newFileBack.draw();
    drawSpeakericon(this, addSound.x+addSound.lengthX/2, addSound.y+addSound.lengthY/2, 1);
    fill(0);
    textSize(70);
    textAlign(LEFT, BOTTOM);
    if (newFileType.equals("sound")) {
      text("name: "+newFileName+coursorr, 100, 445);
      String pathSegments[]=fileToCoppyPath.split("/|\\\\");
      textSize(30);
      text(pathSegments[pathSegments.length-1], 655, 585);
      chooseFileButton.draw();
    } else {
      text(newFileName+coursorr, 100, 445);
    }
  }

  if (drawingPortal2) {
    background(#0092FF);
    fill(#7CC7FF);
    stroke(#7CC7FF);
    strokeWeight(0);
    if (overviewSelection!=-1) {
      rect(0, overviewSelection*60+80, 1280, 60);
      if (level.stages.get(overviewSelection).type.equals("stage")||level.stages.get(overviewSelection).type.equals("3Dstage")) {
        selectStage.draw();
        textAlign(LEFT, BOTTOM);
        stroke(0, 255, 0);
        strokeWeight(7);
        line(1212, 44, 1224, 55);
        line(1224, 55, 1253, 29);
      }
    }
    textAlign(LEFT, BOTTOM);
    stroke(0);
    strokeWeight(2);
    line(0, 80, 1280, 80);
    fill(0);
    textSize(30);
    String[] keys=new String[0];//create a string array that can be used to place the sound keys in
    keys=level.sounds.keySet().toArray(keys);//place the sound keys into the array
    for (int i=0; i < 11 && i + filesScrole < level.stages.size()+level.sounds.size(); i++) {//loop through all the stages and sounds and display 11 of them on screen
      if (i+ filesScrole<level.stages.size()) {//if the current thing attemping to diaply is in the range of stages
        fill(0);
        String displayName=level.stages.get(i+ filesScrole).name, type=level.stages.get(i+ filesScrole).type;//get the name and type of the stages
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("stage")) {//if it is a stage then display the stage icon
          drawWorldSymbol(20, 90+60*(i));
        }
      } else {//if the thing is not a stage type
        fill(0);
        String displayName=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).name, type=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).type;//get the name and type of a sound in the level
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("sound")) {//if the thing is a sound then display the sound icon
          drawSpeakericon(this, 40, 110+60*(i), 0.5);
        }
      }
    }
    textAlign(CENTER, CENTER);

    fill(0);
    textSize(90);
    text("select destenation stage", 640, 30);
    if (filesScrole>0)
      overviewUp.draw();
    if (filesScrole+11<level.stages.size()+level.sounds.size())
      overviewDown.draw();
    textAlign(LEFT, BOTTOM);
  }//end of drawing portal2

  if (creatingNewBlueprint) {
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter blueprint name", 40, 100);
    if (new_name!=null) {
      text(new_name+coursorr, 40, 150);
    } else if (coursor) {
      text("|", 40, 150);
    }
    createBlueprintGo.draw();
    stroke(0);
    strokeWeight(1);
    line(40, 152, 800, 152);
  }//end of creating new blueprint
  if (loadingBlueprint) {
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter blueprint name", 40, 100);
    if (new_name!=null) {
      text(new_name+coursorr, 40, 150);
    } else if (coursor) {
      text("|", 40, 150);
    }
    stroke(0);
    strokeWeight(1);
    line(40, 152, 1200, 152);
    createBlueprintGo.setText("load");
    createBlueprintGo.draw();
  }//end of loading blueprint
  if (editingBlueprint) {
    background(7646207);
    fill(0);
    strokeWeight(0);
    rect(width/2-0.5, 0, 1, height);
    rect(0, height/2-0.5, width, 1);
    blueprintEditDraw();
    stageEditGUI();//overlays when placing things
  }


  engageHUDPosition();
  fill(255);
  textSize(200*Scale);
  textAlign(CENTER, CENTER);
  if (displayTextUntill>=millis()) {
    text(displayText, width/2, height*0.2);
  }

  textAlign(LEFT, BOTTOM);
  textSize(10);
  text("fps: "+ frameRate, 1200, 10);
  text("mspc: "+mspc, 1200, 25);
  if (millis()<gmillis) {
    glitchEffect();
  }

  disEngageHUDPosition();
}//end of draw


void mouseClicked() {

  if (mouseButton==LEFT) {
    println(mouseX+" "+mouseY);
    if (startup) {
      if (mouseX >=200 && mouseX <= 400 && mouseY >= 300 && mouseY <= 380) {
        startup=false;
        newLevel=true;
      }
      if (mouseX >=800 && mouseX <= 1000 && mouseY >= 300 && mouseY <= 380) {
        startup=false;
        loading=true;
      }
      if (newBlueprint.isMouseOver()) {
        startup=false;
        creatingNewBlueprint=true;
        new_name="my blueprint";
        entering_name=true;
      }
      if (loadBlueprint.isMouseOver()) {
        startup=false;
        loadingBlueprint=true;
        new_name="";
        entering_name=true;
      }
    }
    if (loading) {
      if (mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150) {
        entering_file_path=true;
      }
      if (mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440) {
        try {
          mainIndex=loadJSONArray(rootPath+"/index.json");
          entering_file_path=false;
          loading=false;
          levelOverview=true;
        }
        catch(Throwable e) {
        }
        level=new Level(mainIndex);
        return;
      }
    }
    if (newLevel) {
      if (mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150) {
        entering_name=true;
      }//rect(40,400,200,40);
      if (mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440) {
        entering_name=false;
        newLevel=false;
        rootPath=new_name;
        JSONArray mainIndex=new JSONArray();
        JSONObject terain = new JSONObject();
        terain.setInt("level_id", (int)(Math.random()*1000000000%999999999));
        terain.setString("name", new_name);
        terain.setString("game version", GAME_version);
        terain.setFloat("spawnX", 20);
        terain.setFloat("spawnY", 700);
        terain.setFloat("spawn pointX", 20);
        terain.setFloat("spawn pointY", 700);
        terain.setInt("mainStage", -1);
        terain.setInt("coins", 0);
        mainIndex.setJSONObject(0, terain);
        levelOverview=true;
        level=new Level(mainIndex);
        level.save();
        return;
      }
    }

    GUImouseClicked();


    if (levelOverview) {
      if (newStage.isMouseOver()) {
        levelOverview=false;
        newFile=true;
        newFileName="";
      }
      if (mouseY>80) {
        overviewSelection=(mouseY-80)/60+ filesScrole;
        if (overviewSelection>=level.stages.size()+level.sounds.size()) {
          overviewSelection=-1;
        }
      }

      if (overview_saveLevel.isMouseOver()) {
        println("saving level");
        level.save();
        gmillis=millis()+400;
        println("save complete");
      }
      if (help.isMouseOver()) {
        link("https://youtu.be/dh07dk1xXew");
      }
      if (overviewSelection!=-1) {
        if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
          if (level.stages.get(overviewSelection).type.equals("stage")) {
            if (edditStage.isMouseOver()) {
              editingStage=true;
              levelOverview=false;
              currentStageIndex=overviewSelection;
              respawnStage=currentStageIndex;
            }

            if (setMainStage.isMouseOver()) {
              level.mainStage=overviewSelection;
              background(0);
              return;
            }
          }
          if (level.stages.get(overviewSelection).type.equals("3Dstage")) {
            if (edditStage.isMouseOver()) {
              editingStage=true;
              levelOverview=false;
              currentStageIndex=overviewSelection;
              respawnStage=currentStageIndex;
            }
          }
        }//end if if selection is in range of the stages
      }//end of if something is selected

      if (filesScrole>0&&overviewUp.isMouseOver())
        filesScrole--;
      if (filesScrole+11<level.stages.size()+level.sounds.size()&&overviewDown.isMouseOver())
        filesScrole++;
    }//end of level overview

    if (newFile) {
      if (newFileBack.isMouseOver()) {
        levelOverview=true;
        newFile=false;
      }

      if (newFileCreate.isMouseOver()) {
        if (newFileName.equals("")) {
          return;
        }
        if (newFileType.equals("sound")) {
          if (fileToCoppyPath.equals("")) {
            return;
          }
          String pathSegments[]=fileToCoppyPath.split("/|\\\\");
          try {
            println("attempting to coppy file");
            java.nio.file.Files.copy(new File(fileToCoppyPath).toPath(), new File(sketchPath()+"/"+rootPath+"/"+pathSegments[pathSegments.length-1]).toPath());
          }
          catch(IOException i) {
            i.printStackTrace();
          }
          println("adding sound to level");
          level.sounds.put(newFileName, new StageSound(newFileName, "/"+pathSegments[pathSegments.length-1]));
          println("saving level");
          level.save();
          gmillis=millis()+400;
          println("save complete"+gmillis);
          newFile=false;
          newFileName="";
          fileToCoppyPath="";
          levelOverview=true;
          return;
        }
        currentStageIndex=level.stages.size();
        respawnStage=currentStageIndex;
        if (newFileType.equals("2D")) {
          level.stages.add(new Stage(newFileName, "stage"));
        }
        if (newFileType.equals("3D")) {
          level.stages.add(new Stage(newFileName, "3Dstage"));
        }

        editingStage=true;
        newFile=false;
      }
      if (newFileType.equals("sound")) {
        if (chooseFileButton.isMouseOver()) {
          selectInput("select audio file: .WAV .AFI .MP3:", "fileSelected");
        }
      }

      if (new3DStage.isMouseOver()) {
        newFileType="3D";
      }
      if (new2DStage.isMouseOver()) {
        newFileType="2D";
      }
      if (addSound.isMouseOver()) {
        newFileType="sound";
      }
    }
    if (drawingPortal2) {

      if (mouseY>80) {
        overviewSelection=(mouseY-80)/60+ filesScrole;
        if (overviewSelection>=level.stages.size()+level.sounds.size()) {
          overviewSelection=-1;
        }
      }

      if (overviewSelection!=-1) {
        if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
          if (level.stages.get(overviewSelection).type.equals("stage")||level.stages.get(overviewSelection).type.equals("3Dstage")) {
            if (selectStage.isMouseOver()) {
              editingStage=true;
              levelOverview=false;
              drawingPortal2=false;
              drawingPortal3=true;
              camPos=0;
              currentStageIndex=overviewSelection;
            }
          }
        }//end of if in stage range
      }
      if (filesScrole>0&&overviewUp.isMouseOver())
        filesScrole--;
      if (filesScrole+11<level.stages.size()+level.sounds.size()&&overviewDown.isMouseOver())
        filesScrole++;
    }//end of drawing portal 2
    if (creatingNewBlueprint) {
      if (createBlueprintGo.isMouseOver()) {
        if (new_name!=null&&!new_name.equals("")) {//is something was entered
          workingBlueprint=new Stage(new_name, "blueprint");
          entering_name=false;
          creatingNewBlueprint=false;
          editingBlueprint=true;
          camPos=-640;
          camPosY=360;
          rootPath=System.getenv("appdata")+"/CBi-games/skinny mann level creator/blueprints";
        }
      }
    }//end of creating new bluepint
    if (loadingBlueprint) {
      if (createBlueprintGo.isMouseOver()) {
        if (new_name!=null&&!new_name.equals("")) {//is something was entered
          rootPath=System.getenv("appdata")+"/CBi-games/skinny mann level creator/blueprints";
          workingBlueprint=new Stage(loadJSONArray(rootPath+"/"+new_name+".json"));
          entering_name=false;
          loadingBlueprint=false;
          editingBlueprint=true;
          camPos=-640;
          camPosY=360;
        }
      }
    }//end of loading blueprint
  }//end of left mouse button clicked
}//end of mouse clicked

void keyPressed() {
  if (key == ESC) {
    key = 0;  //clear the key so it doesnt close the program
  }
  if (simulating) {
    if (keyCode==65) {
      player1_moving_left=true;
    }
    if (keyCode==68) {
      player1_moving_right=true;
    }
    if (keyCode==32) {
      player1_jumping=true;
    }
    if (key=='e'||key=='E') {
      E_pressed=true;
    }
    if (e3DMode) {
      if (keyCode==87) {//w
        WPressed=true;
      }
      if (keyCode==83) {//s
        SPressed=true;
      }
    }//end of 3d mode
  }
  if (!simulating) {
    if (keyCode==37) {
      cam_left=true;
    }
    if (keyCode==39) {
      cam_right=true;
    }
    if (keyCode==38) {
      cam_up=true;
    }
    if (keyCode==40) {
      cam_down=true;
    }
  }//end of if sumilating



  if (key=='q') {
    println(player1.x+" "+player1.y+" "+player1.z/*+" "+player1.getY()*/);
  }



  if (editingStage||editingBlueprint) {
    if (key=='r'||key=='R') {
      triangleMode++;
      if (triangleMode==4)
        triangleMode=0;
    }
  }

  if (entering_file_path) {
    if (keyCode>=48&&keyCode<=57||keyCode==46||keyCode==32||(keyCode>=65&&keyCode<=90)||keyCode==59||keyCode==92||keyCode==45) {

      if (rootPath==null) {
        rootPath=key+"";
      } else {
        rootPath+=key;
      }
    }
    if (keyCode==8) {
      if (rootPath==null) {
      } else {
        if (rootPath.length()==1) {
          rootPath=null;
        } else {
          rootPath=rootPath.substring(0, rootPath.length()-1);
        }
      }
    }
  }

  if (entering_name) {
    if (keyCode>=48&&keyCode<=57||keyCode==46||keyCode==32||(keyCode>=65&&keyCode<=90)||keyCode==59||keyCode==92||keyCode==45) {

      if (new_name==null) {
        new_name=key+"";
      } else {
        new_name+=key;
      }
    }
    if (keyCode==8) {
      if (new_name==null) {
      } else {
        if (new_name.length()==1) {
          new_name=null;
        } else {
          new_name=new_name.substring(0, new_name.length()-1);
        }
      }
    }
  }
  if (newFile) {
    newFileName=getInput(newFileName, 0);
  }

  if (startup) {
    author = getInput(author, 0);
  }
  //System.out.println(keyCode);
}

void keyReleased() {
  if (simulating) {
    if (keyCode==65) {
      player1_moving_left=false;
    }
    if (keyCode==68) {
      player1_moving_right=false;
    }
    if (keyCode==32) {
      player1_jumping=false;
    }
    if (e3DMode) {
      if (keyCode==87) {//w
        WPressed=false;
      }
      if (keyCode==83) {//s
        SPressed=false;
      }
    }//end of 3d mode
  }
  if (key=='e'||key=='E') {
    E_pressed=false;
  }
  if (!simulating) {
    if (keyCode==37) {
      cam_left=false;
    }
    if (keyCode==39) {
      cam_right=false;
    }
    if (keyCode==38) {
      cam_up=false;
    }
    if (keyCode==40) {
      cam_down=false;
    }
  }
}

void mousePressed() {
  if (editingStage||editingBlueprint) {
    GUImousePressed();
  }
}

void mouseReleased() {
  if (editingStage||editingBlueprint) {
    GUImouseReleased();
  }
}

//void mouseDragged(){
//  if(mouseButton==LEFT){
//  if(editingStage&&(ground||holo_gram)){
//     if(mouseX>=RedPos+35&&mouseX<=RedPos+55&& mouseY>=98&&mouseY<=112&&RedPos>=0&&RedPos<=229){
//        RedPos=mouseX-40;
//     }
//     if(mouseX>=GreenPos+35&&mouseX<=GreenPos+55&& mouseY>=116&&mouseY<=132&&GreenPos>=0&&GreenPos<=229){
//       GreenPos=mouseX-40;
//     }
//     if(mouseX>=BluePos+35&&mouseX<=BluePos+55&& mouseY>=136&&mouseY<=152&&BluePos>=0&&BluePos<=229){
//        BluePos=mouseX-40;
//     }
//  }
//  }
//}

void mouseWheel(MouseEvent event) {
  float wheel_direction = event.getCount()*-1;
  if (grid_mode) {
    if (grid_size==10&&wheel_direction<0) {
    } else {

      grid_size+=wheel_direction*10;
    }
    if (grid_size<10) {
      grid_size=10;
    }
  }
}



char getCh(int mode, char leter) {
  if (mode==0) {
    if (Character.isLetter(leter)||leter==' ') {//mode 0 letters numbers and spcaes
      return leter;
    }
    if (leter==32) {
      return ' ';
    }

    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0')
      return leter;
  }
  if (mode==1) {//mode 1 number only
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0')
      return leter;
  }
  if (mode==2) {//mode 2 ip mode(numbers and .)
    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='.')
      return leter;
  }
  if (mode==3) {//mode 3 mode 0 but also allows line returns and /
    if (Character.isLetter(leter)||leter==' ') {//mode 0 letters numbers and spcaes
      return leter;
    }
    if (leter==32) {
      return ' ';
    }

    if (leter=='1'||leter=='2'||leter=='3'||leter=='4'||leter=='5'||leter=='6'||leter=='7'||leter=='8'||leter=='9'||leter=='0'||leter=='\n'||leter=='/')
      return leter;
  }

  return 0;
}

String doBackspace(String imp, int code) {
  if (code==8) {
    if (imp.length()>1) {
      return imp.substring(0, imp.length()-1);
    } else if (imp.length()==1) {
      return "";
    }
  }
  return imp;
}

String getInput(String in, int x, int code, char leter) {//code and leter exsist to allow sub windows to use this function correctly they shoud send the keyCode and key vaible in respectivlky
  if (getCh(x, leter)!=0) {
    in+=getCh(x, leter);
  }
  in=doBackspace(in, code);
  return in;
}

String getInput(String in, int x) {//for use in the main sketch whre keyCode and key are the same as used here
  return getInput(in, x, keyCode, key);
}

void turnThingsOff() {
  ground=false;
  check_point=false;
  goal=false;
  deleteing=false;
  moving_player=false;
  holo_gram=false;
  levelOverview=false;
  drawCoins=false;
  drawingPortal=false;
  drawingPortal3=false;
  sloap=false;
  holoTriangle=false;
  dethPlane=false;
  draw3DSwitch1=false;
  draw3DSwitch2=false;
  drawingSign=false;
  selecting=false;
  selectedIndex=-1;
  selectingBlueprint=false;
  placingSound=false;
}

int curMills=0, lasMills=0, mspc=0;

void thrdCalc2() {
  println("ere");
  while (loopThread2) {
    curMills=millis();
    mspc=curMills-lasMills;
    if (editingStage) {
      try {
        playerPhysics();
        if (death_cool_down==0) {
          death_cool_down=1;
          dead=false;
        }
      }
      catch(Throwable e) {
      }
    } else {
      random(10);//some how make it so it doesent stop the thread
    }
    lasMills=curMills;
    //println(mspc);
  }
}

boolean gameVersionCompatibilityCheck(String vers) {//returns ture if the inputed version id compatible
  return true;
}

void fileSelected(File selection) {
  if (selection == null) {
    return;
  }
  String path = selection.getAbsolutePath();
  println(path);
  String extenchen=path.substring(path.length()-3, path.length()).toLowerCase();
  println(extenchen);
  if (extenchen.equals("wav")||extenchen.equals("mp3")||extenchen.equals("afi")) {

    fileToCoppyPath=path;
  } else {
    println("invalid extenchen");
    return;
  }
}
