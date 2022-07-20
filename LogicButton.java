import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class LogicButton extends StageComponent {//ground component
  int variable=-1;
  LogicButton(JSONObject data, boolean stage_3D) {
    type="logic button";
    x=data.getFloat("x");
    y=data.getFloat("y");
    if (stage_3D) {
      z=data.getFloat("z");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
    variable=data.getInt("variable");
  }

  LogicButton(float X, float Y, float Z) {
    x=X;
    y=Y;
    z=Z;
    type="logic button";
  }
  StageComponent copy() {
    return new LogicButton(x, y, z);
  }
  LogicButton(float X, float Y) {
    x=X;
    y=Y;
    type="logic button";
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
    part.setInt("variable", variable);
    return part;
  }

  void draw() {
    Group group=getGroup();
    if (!group.visable)
      return;
    boolean state=false;
    if (variable!=-1) {
      if (source.player1.x>=(x+group.xOffset)-10&&source.player1.x<=(x+group.xOffset)+10&&source.player1.y >=(y+group.yOffset)-10&&source.player1.y<= (y+group.yOffset)+2) {
        source.level.variables.set(variable, true);
      } else {
        source.level.variables.set(variable, false);
      }
    }
    if (variable!=-1) {
      state=source.level.variables.get(variable);
    }
    source.drawLogicButton(source, ((x+group.xOffset)-source.drawCamPosX)*source.Scale, ((y+group.yOffset)+source.drawCamPosY)*source.Scale, source.Scale, state);
  }

  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    boolean state=false;
    if (variable!=-1) {
      if (source.player1.x>=(x+group.xOffset)-10&&source.player1.x<=(x+group.xOffset)+10&&source.player1.y >=(y+group.yOffset)-10&&source.player1.y<= (y+group.yOffset)+2 && source.player1.z >= (z+group.zOffset)-10 && source.player1.z <= (z+group.zOffset)+10) {
        source.level.variables.set(variable, true);
      } else {
        source.level.variables.set(variable, false);
      }
    }
    if (variable!=-1) {
      state=source.level.variables.get(variable);
    }
    source.drawLogicButton((x+group.xOffset), (y+group.yOffset), (z+group.zOffset), 1, state);
  }

  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x >= ((this.x+group.xOffset))-20 && x <= ((this.x+group.xOffset)) + 20 && y >= ((this.y+group.yOffset)) - 10 && y <= (this.y+group.yOffset)) {
        return true;
      }
    }
    return false;
  }

  void setData(int data) {
    variable=data;
  }

  int getDataI() {
    return variable;
  }
}
