class ToolBox extends PApplet {
  
  public ToolBox(int miliOffset) {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
    millisOffset=miliOffset;
  }
  
  public int redVal=0,greenVal=0,blueVal=0,CC=0;
  int rsp=0,gsp=0,bsp=0,selectedColor=0,millisOffset;
  String page="colors";
  Button colorPage,toolsPage,draw_coin,draw_portal,draw_sloap,draw_holoTriangle,draw_dethPlane,toggle3DMode,switch3D1,switch3D2,saveLevel,exitStageEdit,sign; 
  
 public void settings(){
  size(1280,720); 
 }
 void setup(){
  colorPage=new Button(50,50,100,50,"colors/depth"); 
  toolsPage=new Button(155,50,100,50,"tools"); 
  
  toggle3DMode=new Button(820,40+100,50,50,"  3D  ",255,203).setStrokeWeight(5);
  switch3D1=new Button(880,40+100,50,50,255,203).setStrokeWeight(5);
  switch3D2=new Button(940,40+100,50,50,255,203).setStrokeWeight(5);
  saveLevel=new Button(1000,40+100,50,50,"save",255,203).setStrokeWeight(5);
  draw_sloap=new Button(700,40+100,50,50,255,203).setStrokeWeight(5);
  draw_holoTriangle=new Button(760,40+100,50,50,255,203).setStrokeWeight(5);
  draw_dethPlane=new Button(820,40+100,50,50,255,203).setStrokeWeight(5);
  draw_coin=new Button(580,40+100,50,50,255,203).setStrokeWeight(5);
  draw_portal=new Button(640,40+100,50,50,255,203).setStrokeWeight(5);
  exitStageEdit= new Button(520,40+100,50,50," < ",255,203).setStrokeWeight(5);
  sign=new Button(1060,140,50,50,255,203).setStrokeWeight(5);
 }
 
 
 public void draw(){
   redVal=(int)((rsp/1080.0)*255);
   greenVal=(int)((gsp/1080.0)*255);
   blueVal=(int)((bsp/1080.0)*255);
   
   
   if(blueVal==255){
     blueVal=254;
   }
     CC=(int)(Math.pow(16,4)*redVal+Math.pow(16,2)*greenVal+blueVal);
   CC=CC-16777215;
   
   if(page.equals("colors")){
   stroke(0);
   background(CC);
   fill(255);
   strokeWeight(10);
   rect(100,150,1080,50);
   rect(100,300,1080,50);
   rect(100,450,1080,50);
   fill(255,0,0);
   rect(rsp+75,125,50,100);
   fill(0,255,0);
   rect(gsp+75,275,50,100);
   fill(0,0,255);
   rect(bsp+75,425,50,100);
   fill(255);
   strokeWeight(0);
   rect(440,550,400,150);
   fill(0);
   textSize(30);
   textAlign(CENTER,CENTER);
   text(redVal,640,100);
   text(greenVal,640,250);
   text(blueVal,640,400);
   JSONObject colo=colors.getJSONObject(selectedColor);
   fill((int)(colo.getInt("red")*Math.pow(16,4)+colo.getInt("green")*Math.pow(16,2)+colo.getInt("blue"))-16777215);
   rect(600,600,80,80);
   fill(180);
   rect(500,600,50,80);
   rect(730,600,50,80);
   rect(600,560,80,30);
   fill(0);
   triangle(510,640,540,625,540,655);
   triangle(770,640,740,625,740,655);
   fill(0);
   textSize(15);
   text("save color",640,570);
   if(level!=null&&level.stages.size()>0&&currentStageIndex!=-1&&level.stages.get(currentStageIndex).type.equals("3Dstage")){
     
     fill(255);
     rect(100,550,200,150);
     rect(950,550,200,150);
     fill(0);
     textSize(25);
     text("starting depth",200,570);
     text("total depth",1050,570);
     text(startingDepth,200,650);
     text(totalDepth,1050,650);
   }
   colorPage.draw();
   toolsPage.draw();
   
   }//end of if page is colors
   if(page.equals("tools")){
     background(255*0.5);
     colorPage.draw();
     toolsPage.draw();
     
     if(editingStage){
       
       
       fill(203);
    rect(35,35+100,60,60);
    fill(255);
    rect(40,40+100,50,50);
    fill(0);
    stroke(0);
    strokeWeight(0);
    if(simulating){
     rect(50,50+100,8,30);
     rect(70,50+100,8,30);
    }else{
     triangle(50,50+100,75,65+100,50,80+100);
    }
    
    if(!e3DMode){
    strokeWeight(0);
    if(ground){
      fill(#F2F258);
    }else{
     fill(203);
    }
    rect(95,35+100,60,60);
    fill(255);
    rect(100,40+100,50,50);
    fill(-7254783);
    stroke(-7254783);
    rect(100,70+100,50,20);
    fill(-16732415);
    stroke(-16732415);
    rect(100,60+100,50,10);
    
    if(ground||holo_gram){
     fill(Color);
     stroke(0);
     strokeWeight(2);
     rect(40,100+100,230,10);
     rect(40,120+100,230,10);
     rect(40,140+100,230,10);
    }
    strokeWeight(0);
    if(check_point){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(155,35+100,60,60);
    fill(255);
    rect(160,40+100,50,50);
     fill(#B9B9B9);
     strokeWeight(0);
     rect(168,45+100,5,40);
     fill(#EA0202);
     stroke(#EA0202);
     strokeWeight(0);
     triangle(170,85-60+20+100,170,85-40+20+100,170+30,85-50+20+100);
    strokeWeight(0);
    if(!level.stages.get(currentStageIndex).type.equals("3Dstage")){
   if(goal){
     fill(#F2F258);
   }else{
    fill(203);
   }
   rect(215,35+100,60,60);
    fill(255);
    rect(220,40+100,50,50);
    fill(0);
    stroke(0);
    strokeWeight(0);
    rect(223,43+100,15,15);
    rect(253,43+100,15,15);
    rect(238,58+100,15,15);
    rect(223,73+100,15,15);
    rect(253,73+100,15,15);
    }
    if(deleteing){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(275,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(280,40+100,50,50);
    fill(203);
    stroke(203);
    strokeWeight(0);
    rect(285,55+100,40,5);
    rect(300,50+100,10,5);
    rect(290,60+100,5,20);
    rect(290,80+100,30,5);
    rect(315,60+100,5,20);
    rect(298,60+100,5,20);
    rect(307,60+100,5,20);
    
    if(moving_player){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(335,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(340,40+100,50,50);
    strokeWeight(0);
    draw_mann(365,88+100,1,0.6,"red");
    
    if(grid_mode){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(395,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(400,40+100,50,50);
    textSize(20);
    fill(0);
    stroke(0);
    strokeWeight(1);
    line(410,42+100,410,87+100);
    line(420,42+100,420,87+100);
    line(430,42+100,430,87+100);
    line(440,42+100,440,87+100);
    line(402,50+100,448,50+100);
    line(402,60+100,448,60+100);
    line(402,70+100,448,70+100);
    line(402,80+100,448,80+100);
    text(grid_size,410,80+100);
    strokeWeight(0);
    if(holo_gram){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(455,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(460,40+100,50,50);
    exitStageEdit.draw();
       
       if(drawCoins){
      draw_coin.setColor(255,#F2F258);
    }else{
      draw_coin.setColor(255,203);
    }
    draw_coin.draw();
    drawCoin(605,65+100,4);
    if(drawingPortal){
      draw_portal.setColor(255,#F2F258);
    }else{
      draw_portal.setColor(255,203);
    }
    draw_portal.draw();
    drawPortal(665,65+100,0.45);
    
    if(!level.stages.get(currentStageIndex).type.equals("3Dstage")){
    if(sloap){
      draw_sloap.setColor(255,#F2F258);
    }else{
      draw_sloap.setColor(255,203);
    }//draw_holoTriangle
    draw_sloap.draw();
    fill(-7254783);
    stroke(-7254783);
    strokeWeight(0);
    triangle(705,85+100,745,85+100,745,45+100);
    if(holoTriangle){
      draw_holoTriangle.setColor(255,#F2F258);
    }else{
      draw_holoTriangle.setColor(255,203);
    }//draw_holoTriangle
    draw_holoTriangle.draw();
    fill(-4623063);
    stroke(-4623063);
    strokeWeight(0);
    triangle(765,85+100,805,85+100,805,45+100);
    }
    
    if(dethPlane){
      draw_dethPlane.setColor(255,#F2F258);
    }else{
      draw_dethPlane.setColor(255,203);
    }//draw_holoTriangle
    draw_dethPlane.draw();
    fill(-114431);
    stroke(-114431);
    rect(825,65+100,40,20);
    }
    saveLevel.draw();
    
    if(drawingSign){
      sign.setColor(255,#F2F258);
    }else{
      sign.setColor(255,203);
    }
    sign.draw();
    drawSign(sign.x+sign.lengthX/2,sign.y+sign.lengthY,0.6);
    
    textAlign(LEFT,BOTTOM);
    if(mouseX >=40 && mouseX <= 90 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,200,16);
      fill(0);
      textSize(15);
      text("play/pause the simulation",mouseX,mouseY+5);
      }
      if(!e3DMode){
    if(mouseX >=100 && mouseX <= 140 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,100,16);
      fill(0);
      textSize(15);
      text("solid ground",mouseX,mouseY+5);
      }  
    if(mouseX >=160 && mouseX <= 190 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("checkpoint",mouseX,mouseY+5);
      }
      if(!level.stages.get(currentStageIndex).type.equals("3Dstage")){
      if(mouseX >=220 && mouseX <= 270 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,80,16);
      fill(0);
      textSize(15);
      text("finish line",mouseX,mouseY+5);
      }
      }
      
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,50,16);
      fill(0);
      textSize(15);
      text("delete",mouseX,mouseY+5);
      }
      if(mouseX >=340 && mouseX <= 390 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,97,16);
      fill(0);
      textSize(15);
      text("move player",mouseX,mouseY+5);
      }
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("grid mode",mouseX,mouseY+5);
      }
      
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("hologram",mouseX,mouseY+5);
      }
      if(exitStageEdit.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,125,16);
      fill(0);
      textSize(15);
      text("exit to overview",mouseX,mouseY+5);
      }
    textAlign(LEFT,BOTTOM);
    if(draw_coin.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,38,16);
      fill(0);
      textSize(15);
      text("coin",mouseX,mouseY+5);
      }
      if(draw_portal.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,180,16);
      fill(0);
      textSize(15);
      text("inter dimentional portal",mouseX,mouseY+5);
      }
      if(!level.stages.get(currentStageIndex).type.equals("3Dstage")){
      if(draw_sloap.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,45,16);
      fill(0);
      textSize(15);
      text("sloap",mouseX,mouseY+5);
      }
      if(draw_holoTriangle.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,138,16);
      fill(0);
      textSize(15);
      text("holographic sloap",mouseX,mouseY+5);
      }
      }
      
      if(draw_dethPlane.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("deth plane",mouseX,mouseY+5);
      }
      }
      if(saveLevel.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,75,16);
      fill(0);
      textSize(15);
      text("save level",mouseX,mouseY+5);
      }
      if(sign.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,textWidth("sign"),16);
      fill(0);
      textSize(15);
      text("sign",mouseX,mouseY+5);
      }
      if(level.stages.get(currentStageIndex).type.equals("3Dstage")){
      
      if(!e3DMode){
        toggle3DMode.setColor(255,203);
    toggle3DMode.draw();
    
    fill(203);
    rect(35,35+100,60,60);
    fill(255);
    rect(40,40+100,50,50);
    fill(0);
    stroke(0);
    strokeWeight(0);
    if(simulating){
     rect(50,50+100,8,30);
     rect(70,50+100,8,30);
    }else{
     triangle(50,50+100,75,65+100,50,80+100);
    }
    
    strokeWeight(0);
    if(ground){
      fill(#F2F258);
    }else{
     fill(203);
    }
    rect(95,35+100,60,60);
    fill(255);
    rect(100,40+100,50,50);
    fill(-7254783);
    stroke(-7254783);
    rect(100,70+100,50,20);
    fill(-16732415);
    stroke(-16732415);
    rect(100,60+100,50,10);
    exitStageEdit.draw();
    textAlign(LEFT,BOTTOM);
    
    if(grid_mode){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(395,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(400,40+100,50,50);
    textSize(20);
    fill(0);
    stroke(0);
    strokeWeight(1);
    line(410,42+100,410,87+100);
    line(420,42+100,420,87+100);
    line(430,42+100,430,87+100);
    line(440,42+100,440,87+100);
    line(402,50+100,448,50+100);
    line(402,60+100,448,60+100);
    line(402,70+100,448,70+100);
    line(402,80+100,448,80+100);
    text(grid_size,410,80+100);
    strokeWeight(0);
    if(deleteing){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(275,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(280,40+100,50,50);
    fill(203);
    stroke(203);
    strokeWeight(0);
    rect(285,55+100,40,5);
    rect(300,50+100,10,5);
    rect(290,60+100,5,20);
    rect(290,80+100,30,5);
    rect(315,60+100,5,20);
    rect(298,60+100,5,20);
    rect(307,60+100,5,20);
    
    if(moving_player){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(335,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(340,40+100,50,50);
    strokeWeight(0);
    draw_mann(365,88+100,1,0.6,"red");
    
    
    
    
    
    
    if(check_point){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(155,35+100,60,60);
    fill(255);
    rect(160,40+100,50,50);
     fill(#B9B9B9);
     strokeWeight(0);
     rect(168,45+100,5,40);
     fill(#EA0202);
     stroke(#EA0202);
     strokeWeight(0);
     triangle(170,85-60+20+100,170,85-40+20+100,170+30,85-50+20+100);
     
     
    
    if(holo_gram){
      fill(#F2F258);
    }else{
    fill(203);
    }
    rect(455,35+100,60,60);
    fill(255);
    strokeWeight(0);
    rect(460,40+100,50,50);
 
    if(draw3DSwitch1){
    switch3D1.setColor(255,#F2F258);
    }else{
      switch3D1.setColor(255,203);
    }
    switch3D1.draw();
    draw3DSwitch1(905,80+100,1);
    
    if(draw3DSwitch2){
    switch3D2.setColor(255,#F2F258);
    }else{
      switch3D2.setColor(255,203);
    }
    switch3D2.draw();
    draw3DSwitch2(965,80+100,1);
    
    if(drawingPortal){
      draw_portal.setColor(255,#F2F258);
    }else{
      draw_portal.setColor(255,203);
    }
    draw_portal.draw();
    drawPortal(665,65+100,0.45);
    
    if(drawCoins){
      draw_coin.setColor(255,#F2F258);
    }else{
      draw_coin.setColor(255,203);
    }
    draw_coin.draw();
    drawCoin(605,65+100,4);
    
    saveLevel.draw();
    textAlign(LEFT,BOTTOM);
    if(toggle3DMode.isMouseOver()){
          stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,125,16);
      fill(0);
      textSize(15);
      textAlign(LEFT,BOTTOM);
      text("toggle 3D mode",mouseX,mouseY+5);
        }
       
       if(switch3D1.isMouseOver()){
          stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,140,16);
      fill(0);
      textSize(15);
      textAlign(LEFT,BOTTOM);
      text("turn 3D on switch",mouseX,mouseY+5);
        }
        
        if(switch3D2.isMouseOver()){
          stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,140,16);
      fill(0);
      textSize(15);
      textAlign(LEFT,BOTTOM);
      text("turn 3D off switch",mouseX,mouseY+5);
        }
        if(mouseX >=160 && mouseX <= 190 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("checkpoint",mouseX,mouseY+5);
      }
      if(draw_portal.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,180,16);
      fill(0);
      textSize(15);
      text("inter dimentional portal",mouseX,mouseY+5);
      }
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,165,16);
      fill(0);
      textSize(15);
      text("hologram (solid in 3D)",mouseX,mouseY+5);
      }
      if(draw_coin.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,38,16);
      fill(0);
      textSize(15);
      text("coin",mouseX,mouseY+5);
      }
      
      if(saveLevel.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,75,16);
      fill(0);
      textSize(15);
      text("save level",mouseX,mouseY+5);
      }
      textAlign(LEFT,BOTTOM);
    if(mouseX >=40 && mouseX <= 90 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,200,16);
      fill(0);
      textSize(15);
      text("play/pause the simulation",mouseX,mouseY+5);
      }
    if(mouseX >=100 && mouseX <= 140 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,100,16);
      fill(0);
      textSize(15);
      text("solid ground",mouseX,mouseY+5);
      }
      if(exitStageEdit.isMouseOver()){
        stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,125,16);
      fill(0);
      textSize(15);
      text("exit to overview",mouseX,mouseY+5);
      }
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,85,16);
      fill(0);
      textSize(15);
      text("grid mode",mouseX,mouseY+5);
      }
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40+100 && mouseY <= 90+100){
      stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,50,16);
      fill(0);
      textSize(15);
      text("delete",mouseX,mouseY+5);
      }
      }//end of if not in 3D mode
      else{
       toggle3DMode.setColor(255,#F2F258);
        toggle3DMode.draw();
        if(toggle3DMode.isMouseOver()){
          textAlign(LEFT,BOTTOM);
          stroke(0);  
      fill(200);
        strokeWeight(2);
        rect(mouseX-4,mouseY-13,125,16);
      fill(0);
      textSize(15);
      textAlign(LEFT,BOTTOM);
      text("toggle 3D mode",mouseX,mouseY+5);
        } 
      }
      }//end of if stage is 3D
     }//end of if edditing
     else{
      fill(0);
      textSize(20);
      text("you are not currently editing a stage",300,300);
     }
   }//end of if page is tools
   
 }

  public void mouseClicked(){
   if(page.equals("colors")){
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 150 && mouseY <= 200){
     rsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 300 && mouseY <= 350){
     gsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 450 && mouseY <= 500){
     bsp=mouseX-75;
   }
   if(mouseX >= 600 && mouseX <=680 && mouseY >= 600 && mouseY <=680){
     JSONObject colo=colors.getJSONObject(selectedColor);
     rsp=(int)Math.ceil(colo.getInt("red")/255.0*1080);
     gsp=(int)Math.ceil(colo.getInt("green")/255.0*1080);
     bsp=(int)Math.ceil(colo.getInt("blue")/255.0*1080);
   }
   if(mouseX >= 500 && mouseX <= 550 && mouseY >= 600 && mouseY <=680&&selectedColor>0){
     selectedColor--;
   }
   
   if(mouseX >= 730 && mouseX <= 780 && mouseY >= 600 && mouseY <=680&&selectedColor<colors.size()-1){
     selectedColor++;
   }
  // println((mouseX >= 600 && mouseX <=680 && mouseY >= 560 && mouseY <=590)+" "+mouseX+" "+mouseY);
   if(mouseX >= 600 && mouseX <=680  && mouseY >= 560 && mouseY <=590){
     JSONObject colo=new JSONObject();
     colo.setInt("red",redVal);
     colo.setInt("green",greenVal);
     colo.setInt("blue",blueVal);
     colors.setJSONObject(colors.size(),colo);
     saveColors=true;
   }
   }//end of if pages is colors
   
   if(colorPage.isMouseOver()){
    page="colors"; 
   }
   if(toolsPage.isMouseOver()){
    page="tools"; 
   }
   
   if(page.equals("tools")){
     if(editingStage){
      if(level.stages.get(currentStageIndex).type.equals("stage")){
        if(draw_coin.isMouseOver()){
        turnThingsOff();
        drawCoins=true;
      }
      if(draw_portal.isMouseOver()){
        turnThingsOff();
        drawingPortal=true;
      }
      if(draw_sloap.isMouseOver()){
        turnThingsOff();
        sloap=true;
      }
      if(draw_holoTriangle.isMouseOver()){
        turnThingsOff();
        holoTriangle=true;
      }
      if(draw_dethPlane.isMouseOver()){
        turnThingsOff();
        dethPlane=true;
      }
      if(mouseX >=40 && mouseX <= 270 && mouseY >= 40+100 && mouseY <= 90+100){
        if(mouseX >=40 && mouseX <= 90 && mouseY >= 40+100 && mouseY <= 90+100){
          extra=true;
          if(extra&&simulating){
             simulating=false; 
             extra=false;
          }
          if(extra&&!simulating){
             simulating=true; 
             extra=false;
          }
        }
      }
      
      if(mouseX >=100 && mouseX <= 140 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        ground=true;
        
      }
      if(mouseX >=160 && mouseX <= 190 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        check_point=true;
      }
      if(mouseX >=220 && mouseX <= 270 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        goal=true;

      }
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40+100 && mouseY <= 90+100){
turnThingsOff();
        deleteing=true;
      }
      if(mouseX >=340 && mouseX <= 390 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        moving_player=true;
      }
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40+100 && mouseY <= 90+100){
        extra=true;
        if(extra&&grid_mode){
          grid_mode=false;
          extra=false;
        }
        if(extra&&!grid_mode){
          grid_mode=true;
          extra=false;
        }
      }
      
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        holo_gram=true;
      }
      
      if(exitStageEdit.isMouseOver()){
         turnThingsOff();
        levelOverview=true;
        editingStage=false;
       
      }
      if(sign.isMouseOver()){
        turnThingsOff();
        drawingSign=true;
      }
      }
      
      if(level.stages.get(currentStageIndex).type.equals("3Dstage")){
      
      if(!e3DMode){
        if(mouseX >=40 && mouseX <= 270 && mouseY >= 40+100 && mouseY <= 90+100){//pause / play button
        if(mouseX >=40 && mouseX <= 90 && mouseY >= 40+100 && mouseY <= 90+100){
          extra=true;
          if(extra&&simulating){
             simulating=false; 
             extra=false;
          }
          if(extra&&!simulating){
             simulating=true; 
             extra=false;
          }
        }
      }
      
      if(mouseX >=100 && mouseX <= 140 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        ground=true;
        
      }
      
      if(mouseX >=280 && mouseX <= 330 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        deleteing=true;
      }
      
      if(mouseX >=400 && mouseX <= 440 && mouseY >= 40+100 && mouseY <= 90+100){
        extra=true;
        if(extra&&grid_mode){
          grid_mode=false;
          extra=false;
        }
        if(extra&&!grid_mode){
          grid_mode=true;
          extra=false;
        }
      }
      
      if(mouseX >=340 && mouseX <= 390 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        moving_player=true;
      }
      
      if(exitStageEdit.isMouseOver()){
         turnThingsOff();
        levelOverview=true;
        editingStage=false;
       
      }
      
      
      
      if(mouseX >=160 && mouseX <= 190 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        check_point=true;
      }
      
        if(toggle3DMode.isMouseOver()){
        e3DMode=true;
        return;
      }
      if(switch3D1.isMouseOver()){
        turnThingsOff();
        draw3DSwitch1=true;
      }
      if(switch3D2.isMouseOver()){
        turnThingsOff();
        draw3DSwitch2=true;
      }
      if(draw_portal.isMouseOver()){
        turnThingsOff();
        drawingPortal=true;
      }
      if(mouseX >=460 && mouseX <= 500 && mouseY >= 40+100 && mouseY <= 90+100){
        turnThingsOff();
        holo_gram=true;
      }
      if(draw_coin.isMouseOver()){
        turnThingsOff();
        drawCoins=true;
      }
      if(sign.isMouseOver()){
        turnThingsOff();
        drawingSign=true;
      }
      }else{
        if(toggle3DMode.isMouseOver()){
        e3DMode=false;
      }
      if(mouseX >=40 && mouseX <= 270 && mouseY >= 40+100 && mouseY <= 90+100){
        if(mouseX >=40 && mouseX <= 90 && mouseY >= 40+100 && mouseY <= 90+100){
          extra=true;
          if(extra&&simulating){
             simulating=false; 
             extra=false;
          }
          if(extra&&!simulating){
             simulating=true; 
             extra=false;
          }
        }
      }
      if(sign.isMouseOver()){
        turnThingsOff();
        drawingSign=true;
      }
      }//end of 3D mode is on 
      }
      
      if(saveLevel.isMouseOver()){
       println("saving level");
      level.save(); 
      gmillis=millis()+400+millisOffset;
      println("save complete"+gmillis);
     }
     }//end of edditing stage
   }
  }
  
  public void mouseDragged(){
   if(page.equals("colors")){
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 150 && mouseY <= 200){
     rsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 300 && mouseY <= 350){
     gsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 450 && mouseY <= 500){
     bsp=mouseX-75;
   }
   }//end of if pages is colors
  }
  
  void mouseWheel(MouseEvent event) {
    if(page.equals("colors")){
  float wheel_direction = event.getCount()*-1;

   if(level!=null&&level.stages.size()>0&&level.stages.get(currentStageIndex).type.equals("3Dstage")){
  if(mouseX>=100&&mouseX<=300&&mouseY>=550&&mouseY<=700){
    startingDepth+=wheel_direction*5;
    if(startingDepth<0){
      startingDepth=0;
    }
  }
  if(mouseX>=950&&mouseX<=1150&&mouseY>=550&&mouseY<=700){
    totalDepth+=wheel_direction*5;
    if(totalDepth<5){
      totalDepth=5;
    }
  }
}
    }//end of if page is colors
  }
  
  
  
  
  
  
  
  
  
//button class V1.1.2
class Button{
  protected float x,y,lengthX,lengthY;
  private int fColor=#FFFFFF,sColor=#AAAAAA,textcolor=0;
  private String text="";
  private float textScaleFactor=2.903,strokeWeight=3;
  Button(float X,float Y,float DX,float DY){
  x=X;
  y=Y;
  lengthX=DX;
  lengthY=DY;
  findTextScale();
  strokeWeight=3;
  }
  Button(float X,float Y,float DX,float DY,String Text){
  x=X;
  y=Y;
  lengthX=DX;
  lengthY=DY;
  text=Text;
  findTextScale();
  strokeWeight=3;
  }
  Button(float X,float Y,float DX,float DY,int c1,int c2){
  x=X;
  y=Y;
  lengthX=DX;
  lengthY=DY;
  fColor=c1;
  sColor=c2;
  findTextScale();
  strokeWeight=3;
  }
  Button(float X,float Y,float DX,float DY,String Text,int c1,int c2){
  x=X;
  y=Y;
  lengthX=DX;
  lengthY=DY;
  text=Text;
  fColor=c1;
  sColor=c2;
  findTextScale();
  strokeWeight=3;
  }
  
  void findTextScale(){
    for(int i=1;i<300;i++){
      textSize(i);
      if(textWidth(text)>lengthX||textAscent()+textDescent()>lengthY){
        textScaleFactor=i-1;
        break;
      }
    }
  }
  
  public Button draw(){
    strokeWeight(0);
    fill(sColor);
   rect(x-strokeWeight,y-strokeWeight,lengthX+strokeWeight*2,lengthY+strokeWeight*2);
   fill(fColor);
   rect(x,y,lengthX,lengthY);
   fill(textcolor);
   textAlign(CENTER, CENTER);
   if(!text.equals("")){
   textSize(textScaleFactor);
   text(text,lengthX/2+x,lengthY/2+y);
   }
    return this;
  }
  
  public Button setText(String t){
   text=t;
   findTextScale();
    return this;
  }
  public String getText(){
    return text;
  }
  public boolean isMouseOver(){
   return mouseX>=x&&mouseX<=x+lengthX&&mouseY>=y&&mouseY<=y+lengthY; 
  }
  public Button setColor(int c1,int c2){
    fColor=c1;
    sColor=c2;
    return this;
  }
  public int getColor(){
   return fColor; 
  }
  public String toString(){
    return "button at:"+x+" "+y+" length: "+lengthX+" height: "+lengthY+" with text: "+text+" and a color of: "+fColor;
  }
  

  @Deprecated
  public Button setTextFactor(float factor){
    //textScaleFactor=factor;
    return this;
  }
  public Button setTextColor(int c){
   textcolor=c;
    return this;
  }
  public Button setX(float X){
   x=X;
    return this;
  }
  public Button setStrokeWeight(float s){
   strokeWeight=s;
   return this;
  }
}//end of button class

void drawCoin(float x,float y,float Scale){
strokeWeight(0);
fill(#FCC703);
circle(x,y,12*Scale);
fill(255,255,0);
circle(x,y,10*Scale);
fill(#FCC703);
rect(x-2*Scale,y-3*Scale,4*Scale,6*Scale);
}

void drawPortal(float x,float y,float scale){
  fill(0);
  strokeWeight(0);
  ellipse(x,y,50*scale,100*scale);
  fill(#AE00FA);
  ellipse(x,y,35*scale,80*scale);
  fill(0);
  ellipse(x,y,20*scale,60*scale);
  fill(#AE00FA);
  ellipse(x,y,5*scale,40*scale);
}

void draw3DSwitch1(float x,float y,float Scale){
 fill(196);
 strokeWeight(0);
 rect((x-20)*Scale,(y-5)*Scale,40*Scale,5*Scale);
 fill(#FAB800);
 rect((x-10)*Scale,(y-10)*Scale,20*Scale,5*Scale);
}

void draw3DSwitch2(float x,float y,float Scale){
 fill(196);
 strokeWeight(0);
 rect((x-20)*Scale,(y-5)*Scale,40*Scale,5*Scale);
}

void drawCheckPoint(float x,float y){
  fill(#B9B9B9);
            strokeWeight(0);
            rect((x-3)*Scale,(y-60)*Scale,5*Scale,60*Scale);
            fill(#EA0202);
            stroke(#EA0202);
            strokeWeight(0);
            triangle(x*Scale,(y-60)*Scale,x*Scale,(y-40)*Scale,(x+30)*Scale,(y-50)*Scale); 
}

void drawSign(float x,float y,float Scale){
  fill(#A54A00);
  rect(x-5*Scale,y-30*Scale,10*Scale,30*Scale);
  rect(x-35*Scale,y-65*Scale,70*Scale,40*Scale);
  fill(#C4C4C4);
  rect(x-33*Scale,y-63*Scale,66*Scale,36*Scale);
  fill(#767675);
  rect(x-30*Scale,y-58*Scale,60*Scale,2*Scale);
  rect(x-30*Scale,y-52*Scale,60*Scale,2*Scale);
  rect(x-30*Scale,y-46*Scale,60*Scale,2*Scale);
  rect(x-30*Scale,y-40*Scale,60*Scale,2*Scale);
  rect(x-30*Scale,y-34*Scale,60*Scale,2*Scale);
}

void draw_mann(float x, float y,int pose,float scale,String shirt_color){
  strokeWeight(0);
  if(shirt_color.equals("red")){
     fill(255,0,0);
     stroke(255,0,0);
  }
  if(shirt_color.equals("green")){
     fill(0,181,0);
     stroke(0,181,0);
  }
  
  if(pose==1){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-10*scale,y-20*scale,scale*6,scale*10);
    rect(x+4*scale,y-20*scale,scale*6,scale*10);
    rect(x-10*scale,y-10*scale,scale*6,scale*10);
    rect(x+4*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==2){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-12*scale,y-20*scale,scale*6,scale*10);
    rect(x+6*scale,y-20*scale,scale*6,scale*10);
    rect(x-14*scale,y-10*scale,scale*6,scale*10);
    rect(x+8*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==3){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-13*scale,y-20*scale,scale*6,scale*10);
    rect(x+7*scale,y-20*scale,scale*6,scale*10);
    rect(x-18*scale,y-10*scale,scale*6,scale*10);
    rect(x+12*scale,y-10*scale,scale*6,scale*10);
  }
  if(pose==4){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-12*scale,y-30*scale,scale*6,scale*10);
    rect(x+6*scale,y-30*scale,scale*6,scale*10);
    rect(x-16*scale,y-20*scale,scale*6,scale*10);
    rect(x+10*scale,y-20*scale,scale*6,scale*10);
    rect(x-19*scale,y-10*scale,scale*6,scale*10);
    rect(x+15*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==5){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-13*scale,y-20*scale,scale*6,scale*10);
    rect(x+7*scale,y-20*scale,scale*6,scale*10);
    rect(x-18*scale,y-10*scale,scale*6,scale*10);
    rect(x+12*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==6){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-12*scale,y-20*scale,scale*6,scale*10);
    rect(x+6*scale,y-20*scale,scale*6,scale*10);
    rect(x-14*scale,y-10*scale,scale*6,scale*10);
    rect(x+8*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==7){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-10*scale,y-20*scale,scale*6,scale*10);
    rect(x+4*scale,y-20*scale,scale*6,scale*10);
    rect(x-10*scale,y-10*scale,scale*6,scale*10);
    rect(x+4*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==8){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-8*scale,y-20*scale,scale*6,scale*10);
    rect(x+2*scale,y-20*scale,scale*6,scale*10);
    rect(x-6*scale,y-10*scale,scale*6,scale*10);
    rect(x+1*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==9){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-7*scale,y-20*scale,scale*6,scale*10);
    rect(x+1*scale,y-20*scale,scale*6,scale*10);
    rect(x-2*scale,y-10*scale,scale*6,scale*10);
    rect(x-4*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==10){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-8*scale,y-30*scale,scale*6,scale*10);
    rect(x+2*scale,y-30*scale,scale*6,scale*10);
    rect(x-4*scale,y-20*scale,scale*6,scale*10);
    rect(x-4*scale,y-20*scale,scale*6,scale*10);
    rect(x+2*scale,y-10*scale,scale*6,scale*10);
    rect(x-7*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==11){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-7*scale,y-20*scale,scale*6,scale*10);
    rect(x+1*scale,y-20*scale,scale*6,scale*10);
    rect(x-2*scale,y-10*scale,scale*6,scale*10);
    rect(x-4*scale,y-10*scale,scale*6,scale*10);
  }
  
  if(pose==12){
    rect(x-10*scale,y-55*scale,scale*20,scale*25);
    fill(-17813);
    stroke(-17813);
    rect(x-15*scale,y-75*scale,scale*30,scale*20);
    fill(-16763137);
    stroke(-16763137);
    rect(x-10*scale,y-30*scale,scale*6,scale*10);
    rect(x+4*scale,y-30*scale,scale*6,scale*10);
    rect(x-8*scale,y-20*scale,scale*6,scale*10);
    rect(x+2*scale,y-20*scale,scale*6,scale*10);
    rect(x-6*scale,y-10*scale,scale*6,scale*10);
    rect(x+1*scale,y-10*scale,scale*6,scale*10);
  }
}
}//end of ColorSelectorScreen class
