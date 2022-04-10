Button newStage, newFileCreate, newFileBack, edditStage, setMainStage, selectStage, new2DStage, new3DStage, overview_saveLevel, help,newBlueprint,loadBlueprint,createBlueprintGo,addSound;

void initlizeButtons() {
  newStage=new Button(1200, 10, 60, 60, #0092FF, 0);
  newFileCreate=new Button(300, 600, 200, 40, "create", #BB48ED, #4857ED).setStrokeWeight(5).setTextFactor(5);
  newFileBack=new Button(600, 600, 200, 40, "back", #BB48ED, #4857ED).setStrokeWeight(5).setTextFactor(4);

  edditStage=new Button(1100, 10, 60, 60, #0092FF, 0);

  setMainStage=new Button(1000, 10, 60, 60, #0092FF, 0);


  selectStage=new Button(1200, 10, 60, 60, #0092FF, 0);


  new2DStage=new Button(400, 200, 80, 80, "2D", #BB48ED, #4857ED).setTextFactor(1).setStrokeWeight(5);
  new3DStage=new Button(600, 200, 80, 80, "3D", #BB48ED, #4857ED).setTextFactor(1).setStrokeWeight(5);
  addSound=new Button(800, 200, 80, 80, #BB48ED, #4857ED).setStrokeWeight(5);

  overview_saveLevel=new Button(60, 20, 50, 50, "save", #0092FF, 0).setStrokeWeight(5);
  help=new Button(130, 20, 50, 50, " ? ", #0092FF, 0);
  
  newBlueprint=new Button(200, 500, 200, 80,"new blueprint",#BB48ED,#4857ED).setStrokeWeight(10);
  loadBlueprint=new Button(800, 500, 200, 80,"load blueprint",#BB48ED,#4857ED).setStrokeWeight(10);
  
  createBlueprintGo=new Button(40, 400, 200, 40,"start",#BB48ED,#4857ED).setStrokeWeight(10);
}
/*

*/
