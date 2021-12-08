Button newStage,newFileCreate,newFileBack,edditStage,exitStageEdit,setMainStage,draw_coin,draw_portal,selectStage,draw_sloap,draw_holoTriangle,draw_dethPlane,new2DStage,new3DStage,toggle3DMode,switch3D1,switch3D2,saveLevel,overview_saveLevel,help;

void initlizeButtons(){
  newStage=new Button(1200,10,60,60,#0092FF,0);
newFileCreate=new Button(300,600,200,40,"create",#BB48ED,#4857ED).setStrokeWeight(5).setTextFactor(5);
newFileBack=new Button(600,600,200,40,"back",#BB48ED,#4857ED).setStrokeWeight(5).setTextFactor(4);

edditStage=new Button(1100,10,60,60,#0092FF,0);
exitStageEdit= new Button(520,40,50,50," < ",255,203).setStrokeWeight(5);
setMainStage=new Button(1000,10,60,60,#0092FF,0);
draw_coin=new Button(580,40,50,50,255,203).setStrokeWeight(5);
draw_portal=new Button(640,40,50,50,255,203).setStrokeWeight(5);

selectStage=new Button(1200,10,60,60,#0092FF,0);
draw_sloap=new Button(700,40,50,50,255,203).setStrokeWeight(5);
draw_holoTriangle=new Button(760,40,50,50,255,203).setStrokeWeight(5);
draw_dethPlane=new Button(820,40,50,50,255,203).setStrokeWeight(5);

new2DStage=new Button(400,200,80,80,"2D",#BB48ED,#4857ED).setTextFactor(1).setStrokeWeight(5);
new3DStage=new Button(600,200,80,80,"3D",#BB48ED,#4857ED).setTextFactor(1).setStrokeWeight(5);
toggle3DMode=new Button(820,40,50,50,"  3D  ",255,203).setStrokeWeight(5);
switch3D1=new Button(880,40,50,50,255,203).setStrokeWeight(5);
switch3D2=new Button(940,40,50,50,255,203).setStrokeWeight(5);

saveLevel=new Button(1000,40,50,50,"save",255,203);
overview_saveLevel=new Button(60,20,50,50,"save",#0092FF,0).setStrokeWeight(5);
help=new Button(130,20,50,50," ? ",#0092FF,0);
}
