import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Goal extends StageComponent {//ground component
  Goal(JSONObject data, boolean stage_3D) {
    type="goal";
    x=data.getFloat("x");
    y=data.getFloat("y");
    if (stage_3D) {
      z=data.getFloat("z");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }
  Goal(float X, float Y) {
    type="goal";
    x=X;
    y=Y;
  }

  StageComponent copy() {
    return new Goal(x, y);
  }
  JSONObject save(boolean stage_3D) {
    JSONObject part=new JSONObject();
    part.setFloat("x", x);
    part.setFloat("y", y);
    if (stage_3D) {
      part.setFloat("z", z);
    }
    part.setString("type", type);
    part.setInt("group", group);
    return part;
  }

  void draw() {
    Group group=getGroup();
    if (!group.visable)
      return;
    float x2 = (x+group.xOffset)-drawCamPosX, y2 = (y+group.yOffset);
    fill(255);
    rect(Scale*x2, Scale*(y2+drawCamPosY), Scale*50, Scale*50);
    rect(Scale*(x2+100), Scale*(y2+drawCamPosY), Scale*50, Scale*50);
    rect(Scale*(x2+200), Scale*(y2+drawCamPosY), Scale*50, Scale*50);
    fill(0);
    rect(Scale*(x2+50), Scale*(y2+drawCamPosY), Scale*50, Scale*50);
    rect(Scale*(x2+150), Scale*(y2+drawCamPosY), Scale*50, Scale*50);

    float px =player1.getX(), py=player1.getY();

    if (px >= x2+drawCamPosX && px <= x2+drawCamPosX + 250 && py >= y2 - 50 && py <= y2 + 50) {
      if (!level_complete) {
        level.logicBoards.get(level.levelCompleteBoard).superTick();
      }
      level_complete=true;
    }
  }

  void draw3D() {
  }

  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x >= (this.x+group.xOffset) && x <= ((this.x+group.xOffset)) + 250 && y >= ((this.y+group.yOffset)) - 50 && y <= ((this.y+group.yOffset)) + 50) {
        return true;
      }
    }
    return false;
  }
}
