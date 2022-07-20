import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class SetZOffset extends LogicOutputComponent {
  int groupNumber=0;
  float offset=0;
  SetZOffset(float x, float y, LogicBoard lb) {
    super(x, y, "z-offset", lb);
    button.setText("z-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }

  SetZOffset(JSONObject data, LogicBoard lb, Level level) {
    super(data.getFloat("x"), data.getFloat("y"), "z-offset", lb, data.getJSONArray("connections"));
    groupNumber=data.getInt("group number");
    offset=data.getFloat("offset");
    button.setText("z-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }
  void tick() {
    if (inputTerminal1) {
      level.groups.get(groupNumber).zOffset=offset;
    }
    if (inputTerminal2) {
      level.groups.get(groupNumber).zOffset=0;
    }
  }
  JSONObject save() {
    JSONObject component=super.save();
    component.setInt("group number", groupNumber);
    component.setFloat("offset", offset);
    return component;
  }
  void setData(int data) {
    groupNumber=data;
    button.setText("z-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }
  int getData() {
    return groupNumber;
  }

  void draw() {
    super.draw();
    fill(0);
    textSize(15);
    textAlign(LEFT, CENTER);
    text("set", x+5-camPos, y+16-camPosY);
    text("reset", x+5-camPos, y+56-camPosY);
  }
  void setOffset(float of) {
    offset=of;
    button.setText("z-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }
  float getOffset() {
    return offset;
  }
}
