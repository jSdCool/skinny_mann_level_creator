Button newStage, newFileCreate, newFileBack, edditStage, setMainStage, selectStage, new2DStage, new3DStage, overview_saveLevel, help, newBlueprint, loadBlueprint, createBlueprintGo, addSound, overviewUp, overviewDown, chooseFileButton;

void initlizeButtons() {
  newStage=new Button(this,1200, 10, 60, 60, #0092FF, 0);
  newFileCreate=new Button(this,300, 600, 200, 40, "create", #BB48ED, #4857ED).setStrokeWeight(5);
  newFileBack=new Button(this,600, 600, 200, 40, "back", #BB48ED, #4857ED).setStrokeWeight(5);
  chooseFileButton=new Button(this,450, 540, 200, 40, "choose file", #BB48ED, #4857ED).setStrokeWeight(5);

  edditStage=new Button(this,1100, 10, 60, 60, #0092FF, 0);

  setMainStage=new Button(this,1000, 10, 60, 60, #0092FF, 0);


  selectStage=new Button(this,1200, 10, 60, 60, #0092FF, 0);


  new2DStage=new Button(this,400, 200, 80, 80, "2D", #BB48ED, #4857ED).setStrokeWeight(5);
  new3DStage=new Button(this,600, 200, 80, 80, "3D", #BB48ED, #4857ED).setStrokeWeight(5);
  addSound=new Button(this,800, 200, 80, 80, #BB48ED, #4857ED).setStrokeWeight(5);

  overview_saveLevel=new Button(this,60, 20, 50, 50, "save", #0092FF, 0).setStrokeWeight(5);
  help=new Button(this,130, 20, 50, 50, " ? ", #0092FF, 0);
  overviewUp=new Button(this,270, 20, 50, 50, " ^ ", #0092FF, 0);
  overviewDown=new Button(this,200, 20, 50, 50, " v ", #0092FF, 0);

  newBlueprint=new Button(this,200, 500, 200, 80, "new blueprint", #BB48ED, #4857ED).setStrokeWeight(10);
  loadBlueprint=new Button(this,800, 500, 200, 80, "load blueprint", #BB48ED, #4857ED).setStrokeWeight(10);

  createBlueprintGo=new Button(this,40, 400, 200, 40, "start", #BB48ED, #4857ED).setStrokeWeight(10);
}
