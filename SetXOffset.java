import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class SetXOffset extends LogicOutputComponent {
  int groupNumber=0;
  float offset=0;
  SetXOffset(float x, float y, LogicBoard lb) {
    super(x, y, "x-offset", lb);
    button.setText("x-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }

  SetXOffset(JSONObject data, LogicBoard lb, Level level) {
    super(data.getFloat("x"), data.getFloat("y"), "x-offset", lb, data.getJSONArray("connections"));
    groupNumber=data.getInt("group number");
    offset=data.getFloat("offset");
    button.setText("x-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }
  void tick() {
    if (inputTerminal1) {
      level.groups.get(groupNumber).xOffset=offset;
    }
    if (inputTerminal2) {
      level.groups.get(groupNumber).xOffset=0;
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
    button.setText("x-offset "+level.groupNames.get(groupNumber)+" by "+offset);
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
    button.setText("x-offset "+level.groupNames.get(groupNumber)+" by "+offset);
  }
  float getOffset() {
    return offset;
  }
}
