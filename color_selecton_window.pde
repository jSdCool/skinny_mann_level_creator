class ColorSelectorScreen extends PApplet {
  
  public ColorSelectorScreen() {
    super();
    PApplet.runSketch(new String[]{this.getClass().getName()}, this);
  }
  
  public int redVal=0,greenVal=0,blueVal=0,CC=0;
  int rsp=0,gsp=0,bsp=0,selectedColor=0;

  
  
 public void settings(){
  size(1280,720); 
  
  println(camPos);
 }
 public void draw(){
   redVal=(int)((rsp/1080.0)*255);
   greenVal=(int)((gsp/1080.0)*255);
   blueVal=(int)((bsp/1080.0)*255);
   
   
   if(blueVal==255){
     blueVal=254;
   }
     CC=(int)(Math.pow(16,4)*redVal+Math.pow(16,2)*greenVal+blueVal);
  // println(gsp);
   CC=CC-16777215;
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
   
 }

  public void mouseClicked(){
   //println(mouseX+" "+mouseY); 
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
     println("hey");
   }
  }
  
  public void mouseDragged(){
   //println(mouseX+" "+mouseY); 
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 150 && mouseY <= 200){
     rsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 300 && mouseY <= 350){
     gsp=mouseX-75;
   }
   if(mouseX >= 100-25 && mouseX <= 1180-25 && mouseY >= 450 && mouseY <= 500){
     bsp=mouseX-75;
   }
  }
  
  void mouseWheel(MouseEvent event) {
  float wheel_direction = event.getCount()*-1;
  //rect(100,550,200,150);
   //rect(950,550,200,150);
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
  }
}
