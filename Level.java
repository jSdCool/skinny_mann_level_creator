import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Level implements Serializable{
static skinny_mann_level_creator source;
  ArrayList<Stage> stages=new ArrayList<>();
  ArrayList<LogicBoard> logicBoards=new ArrayList<>();
  ArrayList<Boolean> variables=new ArrayList<>();
  ArrayList<Group> groups=new ArrayList<>();
  ArrayList<String> groupNames=new ArrayList<>();
  public int mainStage, numOfCoins, levelID, numlogicBoards=0, loadBoard, tickBoard, levelCompleteBoard;
  public String name, createdVersion;
  public float SpawnX, SpawnY, RewspawnX, RespawnY;
  public HashMap<String, StageSound> sounds=new HashMap<>();
  

  Level(JSONArray file) {
    println("loading level");
    JSONObject job =file.getJSONObject(0);
    mainStage=job.getInt("mainStage");
    numOfCoins=job.getInt("coins");
    levelID=job.getInt("level_id");
    SpawnX=job.getFloat("spawnX");
    SpawnY=job.getFloat("spawnY");
    RewspawnX=job.getFloat("spawn pointX");
    RespawnY=job.getFloat("spawn pointY");
    name=job.getString("name");
    createdVersion=job.getString("game version");
    author=job.getString("author");
    currentStageIndex=mainStage;
    if (job.isNull("number of variable")) {
      println("setting up variables because none exsisted before");
      variables.add(false);
      variables.add(false);
      variables.add(false);
      variables.add(false);
      variables.add(false);
    } else {
      for (int i=0; i<job.getInt("number of variable"); i++) {
        variables.add(false);
      }
      println("loaded "+variables.size()+" variables");
    }
    if (!job.isNull("groups")) {
      JSONArray gps= job.getJSONArray("groups");
      for (int i=0; i<gps.size(); i++) {
        groupNames.add(gps.getString(i));
        groups.add(new Group());
      }
      println("loaded "+groups.size()+" groups");
    } else {
      println("no groups found, creating default");
      groupNames.add("group 0");
      groups.add(new Group());
    }
    source.player1.x=SpawnX;
    source.player1.y=SpawnY;
    source.respawnX=(int)RewspawnX;
    source.respawnY=(int)RespawnY;
    source.respawnStage=currentStageIndex;
    println("checking game version compatablility");
    if (!source.gameVersionCompatibilityCheck(createdVersion)) {
      println("game version not compatable with the verion of this level");
      throw new RuntimeException("this level is not compatable with this version of the game");
    }
    println("game version is compatable with this level");
    println("loading level components");
    for (int i=1; i<file.size(); i++) {
      job=file.getJSONObject(i);
      if (job.getString("type").equals("stage")||job.getString("type").equals("3Dstage")) {
        stages.add(new Stage(loadJSONArray(rootPath+job.getString("location"))));
        println("loaded stage: "+stages.get(stages.size()-1).name);
      }
      if (job.getString("type").equals("sound")) {
        sounds.put(job.getString("name"), new StageSound(job));
        println("loaded sound: "+job.getString("name"));
      }
      if (job.getString("type").equals("logicBoard")) {
        logicBoards.add(new LogicBoard(loadJSONArray(rootPath+job.getString("location")), this));
        numlogicBoards++;
        print("loaded logicboard: "+logicBoards.get(logicBoards.size()-1).name);
        if (logicBoards.get(logicBoards.size()-1).name.equals("load")) {
          loadBoard=logicBoards.size()-1;
          print(" board id set to: "+loadBoard);
        }
        if (logicBoards.get(logicBoards.size()-1).name.equals("tick")) {
          tickBoard=logicBoards.size()-1;
          print(" board id set to: "+tickBoard);
        }
        if (logicBoards.get(logicBoards.size()-1).name.equals("level complete")) {
          levelCompleteBoard=logicBoards.size()-1;
          print(" board id set to: "+levelCompleteBoard);
        }
        println("");
      }
    }
    coins=new ArrayList<Boolean>();
    for (int i=0; i<numOfCoins; i++) {
      coins.add(false);
    }
    println("loaded "+coins.size()+" coins");

    if (numlogicBoards==0) {
      println("generating new logic boards as none exsisted");
      logicBoards.add(new LogicBoard("load"));
      logicBoards.add(new LogicBoard("tick"));
      logicBoards.add(new LogicBoard("level complete"));
      loadBoard=0;
      tickBoard=1;
      levelCompleteBoard=2;
    }
    println("level load complete");
  }

  void reloadCoins() {
    coins=new ArrayList<Boolean>();
    for (int i=0; i<numOfCoins; i++) {
      coins.add(false);
    }
  }

  void save() {
    JSONArray index=new JSONArray();
    JSONObject head = new JSONObject();
    head.setInt("mainStage", mainStage);
    head.setInt("coins", numOfCoins);
    head.setInt("level_id", levelID);
    head.setFloat("spawnX", SpawnX);
    head.setFloat("spawnY", SpawnY);
    head.setFloat("spawn pointX", RewspawnX);
    head.setFloat("spawn pointY", RespawnY);
    head.setString("name", name);
    head.setString("game version", GAME_version);
    head.setString("author", author);
    head.setInt("number of variable", variables.size());
    JSONArray grps=new JSONArray();
    for (int i=0; i<groupNames.size(); i++) {
      grps.setString(i, groupNames.get(i));
    }
    head.setJSONArray("groups", grps);
    index.setJSONObject(0, head);
    for (int i=1; i<stages.size()+1; i++) {
      JSONObject stg=new JSONObject();
      stg.setString("name", stages.get(i-1).name);
      stg.setString("type", stages.get(i-1).type);
      stg.setString("location", stages.get(i-1).save());
      index.setJSONObject(i, stg);
    }
    String[] keys=new String[0];
    keys=(String[])sounds.keySet().toArray(keys);
    if (keys.length!=0)
      for (int i=0; i<keys.length; i++) {
        index.setJSONObject(index.size(), sounds.get(keys[i]).save());
      }
    for (int i=0; i<logicBoards.size(); i++) {
      JSONObject board=new JSONObject();
      board.setString("name", logicBoards.get(i).name);
      board.setString("type", "logicBoard");
      board.setString("location", logicBoards.get(i).save());
      index.setJSONObject(index.size(), board);
    }
    saveJSONArray(index, rootPath+"/index.json");
  }
}
