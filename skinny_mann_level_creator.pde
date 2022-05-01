import processing.sound.*;

void settings() {
  size(1280, 720, P3D);
}

void setup() {
  textSize(80);//make text not fuzzy
  frameRate(60);//limmit the frame rate
  surface.setTitle("skinny mann level creator");//set the window title
  scr2 =new ToolBox(millis());//initilize the tool box window
  colors=loadJSONArray("data/colors.json");//load saved colors
  thread("thrdCalc2");//start the physics thread
  coin3D=loadShape("data/modles/coin/tinker.obj");//load the 3d coin modle
  coin3D.scale(3);
  initlizeButtons();
}
boolean startup=true, editing_level=true, player1_moving_right=false, player1_moving_left=false, dev_mode=false, player1_jumping=false, loading=false, newLevel=false, simulating=false, entering_file_path=false, coursor=false, level_complete=false, dead=false, entering_name=false, cam_left=false, cam_right=false, drawing=false, draw=false, extra=false, ground=false, check_point=false, goal=false, deleteing=false, delete=false, moving_player=false, grid_mode=false, holo_gram=false, editingStage=false, levelOverview=false, newFile=false, drawCoins=false, drawingPortal=false, drawingPortal2=false, drawingPortal3=false, E_pressed=false, saveColors=false, sloap=false, loopThread2=true, cam_up=false, cam_down=false, holoTriangle=false, dethPlane=false, setPlayerPosTo=false, e3DMode=false, WPressed=false, SPressed=false, draw3DSwitch1=false, draw3DSwitch2=false, checkpointIn3DStage=false, shadow3D=true, tutorialMode=false, drawingSign=false, selecting=false, viewingItemContents=false, loadingBlueprint=false, creatingNewBlueprint=false, editingBlueprint=false, selectingBlueprint=false, placingSound=false,editinglogicBoard=false,connectingLogic=false,connecting=false,moveLogicComponents=false,movingLogicComponent;
String file_path, new_name="my_level", GAME_version="0.5.0_Early_Access", EDITOR_version="0.0.1.9_EAc", rootPath="", coursorr="", newFileName="", newFileType="2D", stageType="", author="your name here", displayText="", fileToCoppyPath="";
//int player1 []={20,700,1,0,1,0}; // old player data
Player player1 =new Player(20, 699, 1, "red");
int camPos=0, camPosY=0, death_cool_down, start_down, eadgeScroleDist=300, respawnX=20, respawnY=700, spdelay=0, Color=0, RedPos=0, BluePos=0, GreenPos=0, RC=0, GC=0, BC=0, grid_size=10, filesScrole=0, overviewSelection=-1, portalIndex1, stageIndex, preSI, respawnStage, setPlayerPosX, setPlayerPosY, setPlayerPosZ, startingDepth=0, totalDepth=300, respawnZ=50, coinRotation=0, coinCount=0, gmillis=0, eadgeScroleDistV=250, currentStageIndex, tutorialDrawLimit=0, displayTextUntill=0, drawCamPosX=0, drawCamPosY;
int buttonMin=0, buttonMax=0, coinsIndex, triangleMode=0, selectedIndex=-1, viewingItemIndex=-1, currentBluieprintIndex=0,logicBoardIndex,connectingFromIndex,movingLogicIndex;
float[]tpCords=new float[3];
JSONArray mainIndex, colors;
JSONObject portalStage1, portalStage2;
float downX, downY, upX, upY, Scale=1, gravity=0.001;
ToolBox scr2 ;
PShape coin3D;
Level level;
ArrayList<Boolean> coins = new ArrayList<Boolean>();
Stage workingBlueprint, blueprints[], displayBlueprint;
PApplet primaryWindow=this;
void draw() {

  if (frameCount%20==0) {//curcor blinking code
    coursor=false;
    coursorr="";
  }
  if (frameCount%40==0) {
    coursor=true;
    coursorr="|";
  }

  if (saveColors) {//save the saved colors if you want to save colors
    saveJSONArray(colors, "/data/colors.json");
    saveColors=false;
  }

  if (startup) {//if on the startup screen
    background(#48EDD8);
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(200, 300, 200, 80);//new button
    rect(800, 300, 200, 80);//load button
    fill(0);
    textSize(80);
    textAlign(LEFT, BOTTOM);
    text("new", 210, 370+15);
    text("load", 810, 370+15);
    fill(0);
    textSize(15);
    text("game ver: "+GAME_version+ "  editor ver: "+EDITOR_version, 0, 718);//game version text
    fill(0);
    textSize(15);
    text("author: "+author+coursorr, 10, 30);//author text
    strokeWeight(0);
    rect(60, 31, textWidth(author), 1);//draw the line under the author name
    newBlueprint.draw();
    loadBlueprint.draw();
  }//end of startup screen
  if (loading) {//if loading a lavel
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name", 40, 100);
    if (rootPath!=null) {//manual cursor blinking becasue apperently I hadent made the global system yet
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
    line(40, 152, 1200, 152);//draw the line the the text sits on
    stroke(#4857ED);
    fill(#BB48ED);
    strokeWeight(10);
    rect(40, 400, 200, 40);//draw load button
    fill(0);
    textSize(40);
    text("load", 50, 435+10);
  }//end of loading level
  if (newLevel) {//if creating a new level
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter level name", 40, 100);
    if (new_name!=null) {//manual cursor blinking becasue apperently I hadent made the global system yet
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
    rect(40, 400, 200, 40);//start button
    fill(0);
    textSize(40);
    text("start", 50, 435+10);
    stroke(0);
    strokeWeight(1);
    line(40, 152, 800, 152);//line for name text
  }//end of make new level


  if (editingStage) {//if edditing the stage
    //background(7646207);
    if (!simulating) {//if not simulating allow the camera to be moved by the arrow keys
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

    stageLevelDraw();//level draw code
    stageEditGUI();//level gui code

    if (selectingBlueprint&&blueprints.length!=0) {//if selecting blueprint
      generateDisplayBlueprint();//visualize the blueprint that is selected 
      renderBlueprint();//render blueprint 
    }
  }

  if (levelOverview) {//if on the level overview
    background(#0092FF);
    fill(#7CC7FF);
    stroke(#7CC7FF);
    strokeWeight(0);
    if (overviewSelection!=-1) {//if something is selected
      rect(0, (overviewSelection- filesScrole)*60+80, 1280, 60);//draw the highlight
      if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
        if (level.stages.get(overviewSelection).type.equals("stage")) {//if the selected thing is a stage
          edditStage.draw();//draw edit button
          fill(255, 255, 0);
          strokeWeight(1);
          quad(1155, 37, 1129, 54, 1114, 39, 1140, 22);//draw the pencil
          fill(#E5B178);
          triangle(1129, 54, 1114, 39, 1109, 53);//more pencil thing
          setMainStage.draw();//draw set main stage button
          fill(255, 0, 0);
          quad(1030, 16, 1010, 40, 1030, 66, 1050, 40);//draw the main stage diamond
          if (setMainStage.isMouseOver()) {//hover text for set main stage
            fill(200);
            rect(mouseX-4, mouseY-18, 135, 20);
            fill(0);
            textSize(15);
            textAlign(LEFT, BOTTOM);
            text("set as main stage", mouseX, mouseY);
          }
        }
        if (level.stages.get(overviewSelection).type.equals("3Dstage")) {//if the selected thing is a 3D stage
          edditStage.draw();//draw edit stage button
          fill(255, 255, 0);
          strokeWeight(1);
          quad(1155, 37, 1129, 54, 1114, 39, 1140, 22);//draw the pencil
          fill(#E5B178);
          triangle(1129, 54, 1114, 39, 1109, 53);
        }
      }//end of thing slected is in stage range
      if(overviewSelection>=level.stages.size()+level.sounds.size()){//if the selection is in the logic board range
          edditStage.draw();//draw edit button
          fill(255, 255, 0);
          strokeWeight(1);
          quad(1155, 37, 1129, 54, 1114, 39, 1140, 22);//draw the pencil
          fill(#E5B178);
          triangle(1129, 54, 1114, 39, 1109, 53);//more pencil thing
        
      }
    }//end of if something is selected
    textAlign(LEFT, BOTTOM);
    stroke(0);
    strokeWeight(2);
    line(0, 80, 1280, 80);
    fill(0);
    textSize(30);

    String[] keys=new String[0];//create a string array that can be used to place the sound keys in
    keys=level.sounds.keySet().toArray(keys);//place the sound keys into the array
    for (int i=0; i < 11 && i + filesScrole < level.stages.size()+level.sounds.size()+level.logicBoards.size(); i++) {//loop through all the stages and sounds and display 11 of them on screen
      if (i+ filesScrole<level.stages.size()) {//if the current thing attemping to diaply is in the range of stages
        fill(0);
        String displayName=level.stages.get(i+ filesScrole).name, type=level.stages.get(i+ filesScrole).type;//get the name and type of the stages
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("stage")) {//if it is a stage then display the stage icon
          drawWorldSymbol(20, 90+60*(i));
        }
      } else if(i+ filesScrole<level.stages.size()+level.sounds.size()){//if the thing is in the range of sounds
        fill(0);
        String displayName=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).name, type=level.sounds.get(keys[i+ filesScrole-level.stages.size()]).type;//get the name and type of a sound in the level
        text(displayName, 80, 130+60*(i));//display the name
        if (type.equals("sound")) {//if the thing is a sound then display the sound icon
          drawSpeakericon(this, 40, 110+60*(i), 0.5);
        }
      }else{
        fill(0);
        String displayName=level.logicBoards.get(i+ filesScrole-(level.stages.size()+level.sounds.size())).name;//get the name of the logic board
        text(displayName, 80, 130+60*(i));//display the name
      }
    }
    textAlign(CENTER, CENTER);
    newStage.draw();//draw the new file button
    fill(0);
    textSize(90);
    text("+", 1230, 25);
    textAlign(LEFT, BOTTOM);
    respawnX=(int)level.SpawnX;//set the respawn info to that of the current level
    respawnY=(int)level.SpawnY;
    respawnStage=level.mainStage;

    overview_saveLevel.draw();//draw save button
    help.draw();//draw help button
    if (filesScrole>0)//draw scroll buttons
      overviewUp.draw();
    if (filesScrole+11<level.stages.size()+level.sounds.size()+level.logicBoards.size())
      overviewDown.draw();
  }//end of level over view



  if (newFile) {//if on the new file screen
    background(#0092FF);
    stroke(0);
    strokeWeight(2);
    line(100, 450, 1200, 450);
    //highlight the option that is currently set
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

    new2DStage.draw();//draw the selection buttons
    new3DStage.draw();
    addSound.draw();
    newFileCreate.draw();
    newFileBack.draw();
    drawSpeakericon(this, addSound.x+addSound.lengthX/2, addSound.y+addSound.lengthY/2, 1);
    fill(0);
    textSize(70);
    textAlign(LEFT, BOTTOM);
    if (newFileType.equals("sound")) {//if the selected type is sound
      text("name: "+newFileName+coursorr, 100, 445);//dfisplay the entyered name
      String pathSegments[]=fileToCoppyPath.split("/|\\\\");
      textSize(30);
      text(pathSegments[pathSegments.length-1], 655, 585);//display the name of the selected file
      chooseFileButton.draw();
    } else {
      text(newFileName+coursorr, 100, 445);//display the entered name
    }
  }

  if (drawingPortal2) {//if drawing portal part 2 aka outher overview selection screen
    background(#0092FF);
    fill(#7CC7FF);
    stroke(#7CC7FF);
    strokeWeight(0);
    if (overviewSelection!=-1) {//if sonethign is selected
      rect(0, (overviewSelection- filesScrole)*60+80, 1280, 60);//highlight
      if (level.stages.get(overviewSelection).type.equals("stage")||level.stages.get(overviewSelection).type.equals("3Dstage")) {//if the selected thing is a posible destination stage
        selectStage.draw();//draw the select stage button
        textAlign(LEFT, BOTTOM);
        stroke(0, 255, 0);
        strokeWeight(7);
        line(1212, 44, 1224, 55);//checkmark
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
    if (filesScrole>0)//scroll buttons
      overviewUp.draw();
    if (filesScrole+11<level.stages.size()+level.sounds.size())
      overviewDown.draw();
    textAlign(LEFT, BOTTOM);
  }//end of drawing portal2

  if (creatingNewBlueprint) {//if creating a new bueprint screen
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter blueprint name", 40, 100);
    if (new_name!=null) {//display the name entered
      text(new_name+coursorr, 40, 150);
    } else if (coursor) {
      text("|", 40, 150);
    }
    createBlueprintGo.draw();//create button
    stroke(0);
    strokeWeight(1);
    line(40, 152, 800, 152);//text line
  }//end of creating new blueprint
  if (loadingBlueprint) {//if loading blueprint
    background(#48EDD8);
    fill(0);
    textSize(20);
    text("enter blueprint name", 40, 100);
    if (new_name!=null) {//coursor and entrd name
      text(new_name+coursorr, 40, 150);
    } else if (coursor) {
      text("|", 40, 150);
    }
    stroke(0);
    strokeWeight(1);
    line(40, 152, 1200, 152);
    createBlueprintGo.setText("load");//load button
    createBlueprintGo.draw();
  }//end of loading blueprint
  if (editingBlueprint) {//if edditing blueprint
    background(7646207);
    fill(0);
    strokeWeight(0);
    rect(width/2-0.5, 0, 1, height);//draw lines in the center of the screen that indicate wherer (0,0) is
    rect(0, height/2-0.5, width, 1);
    blueprintEditDraw();//draw the accual blueprint
    stageEditGUI();//overlays when placing things
  }
  if(editinglogicBoard){//if editing a logic board
    background(#FFECA0);
    for(int i=0;i<level.logicBoards.get(logicBoardIndex).components.size();i++){//draw the components
      level.logicBoards.get(logicBoardIndex).components.get(i).draw();
    }
    for(int i=0;i<level.logicBoards.get(logicBoardIndex).components.size();i++){//draw the connections
      level.logicBoards.get(logicBoardIndex).components.get(i).drawConnections();
    }
    
    if(connectingLogic&&connecting){//draw the connnecting line
      float[] nodePos = level.logicBoards.get(logicBoardIndex).components.get(connectingFromIndex).getTerminalPos(2);
      stroke(0);
      strokeWeight(5);
      line(nodePos[0],nodePos[1],mouseX,mouseY);
    }
    
    if(movingLogicComponent&&moveLogicComponents){
        level.logicBoards.get(logicBoardIndex).components.get(movingLogicIndex).setPos(mouseX,mouseY);
      }
  }


  engageHUDPosition();//setup for HUD incase of being in 3D mode
  fill(255);
  textSize(200*Scale);
  textAlign(CENTER, CENTER);
  if (displayTextUntill>=millis()) {//info display text logic
    text(displayText, width/2, height*0.2);
  }

  textAlign(LEFT, BOTTOM);
  textSize(10);
  text("fps: "+ frameRate, 1200, 10);//framrate and de3bug thigns
  text("mspc: "+mspc, 1200, 25);
  if (millis()<gmillis) {
    glitchEffect();
  }

  disEngageHUDPosition();
}//end of draw


void mouseClicked() {

  if (mouseButton==LEFT) {//if the button pressed was the left button
    println(mouseX+" "+mouseY);//print the location the mouse clicked to the console
    if (startup) {//if on the startup screen
      if (mouseX >=200 && mouseX <= 400 && mouseY >= 300 && mouseY <= 380) {//new level button
        startup=false;
        newLevel=true;
      }
      if (mouseX >=800 && mouseX <= 1000 && mouseY >= 300 && mouseY <= 380) {//load level button
        startup=false;
        loading=true;
      }
      if (newBlueprint.isMouseOver()) {//new blurprint button
        startup=false;
        creatingNewBlueprint=true;
        new_name="my blueprint";
        entering_name=true;
      }
      if (loadBlueprint.isMouseOver()) {//loaf blueprint button
        startup=false;
        loadingBlueprint=true;
        new_name="";
        entering_name=true;
      }
    }
    if (loading) {//if loading level
      if (mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150) {//click box for the line to type the name
        entering_file_path=true;
      }
      if (mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440) {//load button
        try {//attempt to load the level
          mainIndex=loadJSONArray(rootPath+"/index.json");
          entering_file_path=false;
          loading=false;
          levelOverview=true;
        }
        catch(Throwable e) {//do nothign if loading fails
        }
        level=new Level(mainIndex);
        return;
      }
    }
    if (newLevel) {//if creating a new level
      if (mouseX >=40 && mouseX <= 1200 && mouseY >= 100 && mouseY <= 150) {//text line click box
        entering_name=true;
      }//rect(40,400,200,40);
      if (mouseX >=40 && mouseX <= 240 && mouseY >= 400 && mouseY <= 440) {//create button
        entering_name=false;
        newLevel=false;
        rootPath=new_name;
        JSONArray mainIndex=new JSONArray();//set up a new level
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

    GUImouseClicked();//gui clicking code


    if (levelOverview) {//if on level overview
      if (newStage.isMouseOver()) {//if the new file button is clicked
        levelOverview=false;
        newFile=true;
        newFileName="";
      }
      if (mouseY>80) {//if the mouse is in the files section of the screen
        overviewSelection=(mouseY-80)/60+ filesScrole;//figure out witch thing to select
        if (overviewSelection>=level.stages.size()+level.sounds.size()+level.logicBoards.size()) {//de seclect if there was nothing under where the click happend
          overviewSelection=-1;
        }
      }

      if (overview_saveLevel.isMouseOver()) {//save button in the level overview
        println("saving level");
        level.save();
        gmillis=millis()+400;//glitch effect
        println("save complete");
      }
      if (help.isMouseOver()) {//help button in the level overview
        link("https://youtu.be/dh07dk1xXew");
      }
      if (overviewSelection!=-1) {//if something is selected
        if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
          if (level.stages.get(overviewSelection).type.equals("stage")) {//if the selected thing is a stage
            if (edditStage.isMouseOver()) {//eddit stage button
              editingStage=true;
              levelOverview=false;
              currentStageIndex=overviewSelection;
              respawnStage=currentStageIndex;
            }

            if (setMainStage.isMouseOver()) {//set main stage button
              level.mainStage=overviewSelection;
              background(0);
              return;
            }
          }
          if (level.stages.get(overviewSelection).type.equals("3Dstage")) {//if the selected thing is a 3D stage
            if (edditStage.isMouseOver()) {//eddit button
              editingStage=true;
              levelOverview=false;
              currentStageIndex=overviewSelection;
              respawnStage=currentStageIndex;
            }
          }
        }//end if if selection is in range of the stages
        if(overviewSelection>=level.stages.size()+level.sounds.size()){//if the selecion is in the logic board range
          if (edditStage.isMouseOver()) {//eddit button
          levelOverview=false;
          editinglogicBoard=true;
          logicBoardIndex=overviewSelection-(level.stages.size()+level.sounds.size());
          }
        }
      }//end of if something is selected

      if (filesScrole>0&&overviewUp.isMouseOver())//scroll up button
        filesScrole--;
      if (filesScrole+11<level.stages.size()+level.sounds.size()+level.logicBoards.size()&&overviewDown.isMouseOver())//scroll down button
        filesScrole++;
    }//end of level overview

    if (newFile) {//if on the new file page
      if (newFileBack.isMouseOver()) {//back button
        levelOverview=true;
        newFile=false;
      }

      if (newFileCreate.isMouseOver()) {//create button
        if (newFileName.equals("")) {//if no name has been entered
          return;
        }
        if (newFileType.equals("sound")) {//if the type that is selected is sound
          if (fileToCoppyPath.equals("")) {//if no file is selected
            return;
          }
          String pathSegments[]=fileToCoppyPath.split("/|\\\\");//split the file path at directory seperator
          try {//attempt to coppy the file
            println("attempting to coppy file");
            java.nio.file.Files.copy(new File(fileToCoppyPath).toPath(), new File(sketchPath()+"/"+rootPath+"/"+pathSegments[pathSegments.length-1]).toPath());
          }
          catch(IOException i) {
            i.printStackTrace();
          }
          println("adding sound to level");
          level.sounds.put(newFileName, new StageSound(newFileName, "/"+pathSegments[pathSegments.length-1]));//add the sound to the level
          println("saving level");
          level.save();//save the level
          gmillis=millis()+400;///glitch effect
          println("save complete"+gmillis);
          newFile=false;//return back to the obverview
          newFileName="";
          fileToCoppyPath="";
          levelOverview=true;
          return;
        }
        currentStageIndex=level.stages.size();//set the current sateg to the new stage
        respawnStage=currentStageIndex;
        if (newFileType.equals("2D")) {//create the approriate type of stage based on what is selectd
          level.stages.add(new Stage(newFileName, "stage"));
        }
        if (newFileType.equals("3D")) {
          level.stages.add(new Stage(newFileName, "3Dstage"));
        }

        editingStage=true;
        newFile=false;
      }
      if (newFileType.equals("sound")) {
        if (chooseFileButton.isMouseOver()) {//choose file button for when the type is sound
          selectInput("select audio file: .WAV .AFI .MP3:", "fileSelected");//open file selection diaglog
        }
      }

      if (new3DStage.isMouseOver()) {//buttons to set type
        newFileType="3D";
      }
      if (new2DStage.isMouseOver()) {
        newFileType="2D";
      }
      if (addSound.isMouseOver()) {
        newFileType="sound";
      }
    }
    if (drawingPortal2) {//if placing portal part 2 (part that has the overview)

      if (mouseY>80) {//select the file that was clicked on in the overview
        overviewSelection=(mouseY-80)/60+ filesScrole;
        if (overviewSelection>=level.stages.size()+level.sounds.size()) {
          overviewSelection=-1;
        }
      }

      if (overviewSelection!=-1) {//if something is selected
        if (overviewSelection<level.stages.size()) {//if the selection is in rage of the stages
          if (level.stages.get(overviewSelection).type.equals("stage")||level.stages.get(overviewSelection).type.equals("3Dstage")) {//if the selected thing is a valid destination stage
            if (selectStage.isMouseOver()) {//if the select stagge button is clicked
              editingStage=true;//go to that stage
              levelOverview=false;
              drawingPortal2=false;
              drawingPortal3=true;
              camPos=0;
              currentStageIndex=overviewSelection;
            }
          }
        }//end of if in stage range
      }
      if (filesScrole>0&&overviewUp.isMouseOver())//scroll up button
        filesScrole--;
      if (filesScrole+11<level.stages.size()+level.sounds.size()&&overviewDown.isMouseOver())//scroll down button
        filesScrole++;
    }//end of drawing portal 2
    if (creatingNewBlueprint) {//if creating a new blueprint
      if (createBlueprintGo.isMouseOver()) {//create button
        if (new_name!=null&&!new_name.equals("")) {//if something was entered
          workingBlueprint=new Stage(new_name, "blueprint");//creat and load the new blueprint
          entering_name=false;//set up enviormatn vaibles
          creatingNewBlueprint=false;
          editingBlueprint=true;
          camPos=-640;
          camPosY=360;
          rootPath=System.getenv("appdata")+"/CBi-games/skinny mann level creator/blueprints";
        }//end of name was enterd
      }//end of create button
    }//end of creating new bluepint
    if (loadingBlueprint) {//if loading blueprint
      if (createBlueprintGo.isMouseOver()) {//load button
        if (new_name!=null&&!new_name.equals("")) {//if something was entered
          rootPath=System.getenv("appdata")+"/CBi-games/skinny mann level creator/blueprints";
          workingBlueprint=new Stage(loadJSONArray(rootPath+"/"+new_name+".json"));//load the blueprint
          entering_name=false;//set enviormaent varibles
          loadingBlueprint=false;
          editingBlueprint=true;
          camPos=-640;
          camPosY=360;
        }//end of thing were entered
      }//end of load button
    }//end of loading blueprint
    if(editinglogicBoard){
      if(connectingLogic){
        
      }
      //level.logicBoards.get(logicBoardIndex).components.add(new GenericLogicComponent(mouseX,mouseY,level.logicBoards.get(logicBoardIndex)));
    }//end of edditing logic board
  }//end of left mouse button clicked
}//end of mouse clicked

void keyPressed() {
  if (key == ESC) {
    key = 0;  //clear the key so it doesnt close the program
  }
  if (simulating) {
    if (keyCode==65) {//if 'A' is pressed
      player1_moving_left=true;
    }
    if (keyCode==68) {//if 'D' is pressed
      player1_moving_right=true;
    }
    if (keyCode==32) {//if SPACE is pressed
      player1_jumping=true;
    }
    if (key=='e'||key=='E') {//if 'E' is pressed
      E_pressed=true;
    }
    if (e3DMode) {//if 3D mode is on
      if (keyCode==87) {//if 'W' is pressed
        WPressed=true;
        key = 0;//clear key so CTRL + W doesent close the program
      }
      if (keyCode==83) {//if 'S' is pressed
        SPressed=true;
      }
    }//end of 3d mode
  }
  if (!simulating) {//if the simulation is paused
    if (keyCode==37) {//if LEFT ARROW is pressed
      cam_left=true;
    }
    if (keyCode==39) {//if RIGHT ARROW is pressed
      cam_right=true;
    }
    if (keyCode==38) {//if UP ARROW is pressed
      cam_up=true;
    }
    if (keyCode==40) {//if DOWN ARROW is pressed
      cam_down=true;
    }
  }//end of if sumilating



  if (key=='q') {//if 'q' is pressed then print debg info to the console
    println(player1.x+" "+player1.y+" "+player1.z);
  }



  if (editingStage||editingBlueprint) {//if edditng a stage
    if (key=='r'||key=='R') {//if 'R' is pressed
      triangleMode++;//increase the current rotation
      if (triangleMode==4)//reset if rotation os over max
        triangleMode=0;
    }
  }

  if (entering_file_path) {//if ennering "file path"
    if (keyCode>=48&&keyCode<=57/*numbers*/||keyCode==46/*decimal*/||keyCode==32/*space*/||(keyCode>=65&&keyCode<=90)/*a-z*/||keyCode==59/*;:*/||keyCode==92/*\*/||keyCode==45/*-_*/) {

      if (rootPath==null) {//if the path is blank
        rootPath=key+"";//add current key pressed to path
      } else {
        rootPath+=key;//add current key pressed to path
      }
    }
    if (keyCode==8) {//if the key is BACKSPACE
      if (rootPath==null) {//if there3 is nothing then do nothing
      } else {
        if (rootPath.length()==1) {//delet if only 1 charcter
          rootPath=null;
        } else {
          rootPath=rootPath.substring(0, rootPath.length()-1);//remove last charicter
        }
      }
    }
  }//end of entering file path

  if (entering_name) {//if entering anme
    if (keyCode>=48&&keyCode<=57/*numbers*/||keyCode==46/*decimal*/||keyCode==32/*space*/||(keyCode>=65&&keyCode<=90)/*a-z*/||keyCode==59/*;:*/||keyCode==92/*\*/||keyCode==45/*-_*/) {

      if (new_name==null) {//if the path is blank
        new_name=key+"";//add current key pressed to path
      } else {
        new_name+=key;//add current key pressed to path
      }
    }
    if (keyCode==8) {//if the key is BACKSPACE
      if (new_name==null) {
      } else {
        if (new_name.length()==1) {
          new_name=null;
        } else {
          new_name=new_name.substring(0, new_name.length()-1);//remove the last charicter
        }
      }
    }
  }//end of entering name
  if (newFile) {//if new file
    newFileName=getInput(newFileName, 0);//use the cencable typing functions
  }

  if (startup) {//if on the main menue
    author = getInput(author, 0);//typing for the author name
  }
  //System.out.println(keyCode);//usefull to figureout what key is what
}

void keyReleased() {
  if (simulating) {//if the simulatiuon is running
    if (keyCode==65) {//if 'A" released
      player1_moving_left=false;
    }
    if (keyCode==68) {//if 'D' released
      player1_moving_right=false;
    }
    if (keyCode==32) {//if SPACE relased
      player1_jumping=false;
    }
    if (e3DMode) {//if 3D mode on
      if (keyCode==87) {//if 'W' relased
        WPressed=false;
      }
      if (keyCode==83) {//if 'S' released
        SPressed=false;
      }
    }//end of 3d mode
  }//end of simulation is running
  if (key=='e'||key=='E') {//if 'E' released
    E_pressed=false;
  }
  if (!simulating) {//if the simulation is paused
    if (keyCode==37) {//if LEFT ARROW released
      cam_left=false;
    }
    if (keyCode==39) {//if RIGHT ARROW released
      cam_right=false;
    }
    if (keyCode==38) {//if UP ARROW released
      cam_up=false;
    }
    if (keyCode==40) {//if DOWN ARROW released
      cam_down=false;
    }
  }//end of simulation pasued
}//end of key relaesed

void mousePressed() {
  if (editingStage||editingBlueprint) {//if edditing a stage or blueprint
    GUImousePressed();
  }
  if(editinglogicBoard){
      if(connectingLogic){
        LogicBoard board=level.logicBoards.get(logicBoardIndex);
        for(int i=0;i<board.components.size();i++){
          float[] nodePos=board.components.get(i).getTerminalPos(2);
          if(Math.sqrt(Math.pow(nodePos[0]-mouseX,2)+Math.pow(nodePos[1]-mouseY,2))<=10){
            connecting=true;
            connectingFromIndex=i;
            return;
          }
        }
      }
      if(moveLogicComponents){
        LogicBoard board=level.logicBoards.get(logicBoardIndex);
        for(int i=0;i<board.components.size();i++){
          if(board.components.get(i).button.isMouseOver()){
           movingLogicIndex=i;
           movingLogicComponent=true;
           return;
          }
        }
      }
  }//end of editng logic board
}

void mouseReleased() {
  if (editingStage||editingBlueprint) {//if edditing a stage or blueprint
    GUImouseReleased();
  }
  if(editinglogicBoard){
    if(connectingLogic&&connecting){
      connecting=false;
      LogicBoard board=level.logicBoards.get(logicBoardIndex);
      for(int i=0;i<board.components.size();i++){
         float[] nodePos1=board.components.get(i).getTerminalPos(0),nodePos2=board.components.get(i).getTerminalPos(1);
          if(Math.sqrt(Math.pow(nodePos1[0]-mouseX,2)+Math.pow(nodePos1[1]-mouseY,2))<=10){
            board.components.get(connectingFromIndex).connect(i,0);
            return;
          }
          if(Math.sqrt(Math.pow(nodePos2[0]-mouseX,2)+Math.pow(nodePos2[1]-mouseY,2))<=10){
            board.components.get(connectingFromIndex).connect(i,1);
            return;
          }
      }
    }    
    if(moveLogicComponents){
      if(movingLogicComponent){
        movingLogicComponent=false;
        level.logicBoards.get(logicBoardIndex).components.get(movingLogicIndex).setPos(mouseX,mouseY);
        
      }
    }
  }//end of editing logic board
}


void mouseWheel(MouseEvent event) {//when the scroll wheel is moved
  float wheel_direction = event.getCount()*-1;
  if (grid_mode) {//if grid mode is active 
    if (grid_size==10&&wheel_direction<0) {
    } else {

      grid_size+=wheel_direction*10;//change the grid size
    }
    if (grid_size<10) {
      grid_size=10;
    }
  }
}


/**used to easaly process keyboard inputs
 @param mode what charicter mode to use
 @param letter the char from the keyboard to be processed
 @returns a char that is compatbale with the selected mode
*/
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

/** processes backspace operations
  @param imp the string that needs a backspace opperation
  @param code the key ID of the key that was pressed
  @returns a string with 1 less char
*/
String doBackspace(String imp, int code) {
  if (code==8) {//if the key was backspace
    if (imp.length()>1) {//remove the last char
      return imp.substring(0, imp.length()-1);
    } else if (imp.length()==1) {
      return "";
    }
  }
  return imp;
}

/**used to process keyboard inputs by modifying strings
  @param in the string to be modified
  @param x the allowed charicter mode
  @param code keyCode value
  @param letter key value
  @returns in modified according to the mode selected by x
*/
String getInput(String in, int x, int code, char leter) {//code and leter exsist to allow sub windows to use this function correctly they shoud send the keyCode and key vaible in respectivlky
  if (getCh(x, leter)!=0) {
    in+=getCh(x, leter);
  }
  in=doBackspace(in, code);
  return in;
}

/**used to process keyboard inputs by modifying strings||only use if in top level sketch||auto fill the outher values for getinput
  @param in the string to be modified
  @param x the allowed charicter mode
  @returns in modified according to the mode selected by x
*/
String getInput(String in, int x) {//for use in the main sketch whre keyCode and key are the same as used here
  return getInput(in, x, keyCode, key);
}

/**resets tool stages to default

*/
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
  connectingLogic=false;
  moveLogicComponents=false;
}

int curMills=0, lasMills=0, mspc=0;

/**seperate therad for calculation physics

*/
void thrdCalc2() {
  println("ere");
  while (loopThread2) {
    curMills=millis();
    mspc=curMills-lasMills;//calculate how long its been sence the last physics calculation
    if (editingStage) {//if edditing a stage
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
      random(10);//make preocessing think that this thread is still active while it waits
    }
    lasMills=curMills;
    //println(mspc);
  }
}

/**used in the game to check if a level is of a compatable verson 
no implmentation in level editor
*/
boolean gameVersionCompatibilityCheck(String vers) {//returns ture if the inputed version is compatible
  return true;
}

/**function that handles the output of the file selection dialog

*/
void fileSelected(File selection) {
  if (selection == null) {
    return;
  }
  String path = selection.getAbsolutePath();
  println(path);
  String extenchen=path.substring(path.length()-3, path.length()).toLowerCase();
  println(extenchen);
  if (extenchen.equals("wav")||extenchen.equals("mp3")||extenchen.equals("afi")) {//check if the file type is valid

    fileToCoppyPath=path;
  } else {
    println("invalid extenchen");
    return;
  }
}
