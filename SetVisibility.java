import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class SetVisibility extends LogicOutputComponent {
  int groupNumber=0;
  SetVisibility(float x, float y, LogicBoard lb) {
    super(x, y, "set visable", lb);
    button.setText("  visibility of "+level.groupNames.get(groupNumber));
  }

  SetVisibility(JSONObject data, LogicBoard lb, Level level) {
    super(data.getFloat("x"), data.getFloat("y"), "set visable", lb, data.getJSONArray("connections"));
    groupNumber=data.getInt("group number");
    button.setText("  visibility of "+level.groupNames.get(groupNumber));
  }
  void tick() {
    if (inputTerminal1) {
      level.groups.get(groupNumber).visable=true;
    }
    if (inputTerminal2) {
      level.groups.get(groupNumber).visable=false;
    }
  }
  JSONObject save() {
    JSONObject component=super.save();
    component.setInt("group number", groupNumber);
    return component;
  }
  void setData(int data) {
    groupNumber=data;
    button.setText("  visibility of "+level.groupNames.get(groupNumber));
  }
  int getData() {
    return groupNumber;
  }

  void draw() {
    super.draw();
    fill(0);
    textSize(15);
    textAlign(LEFT, CENTER);
    text("true", x+5-camPos, y+16-camPosY);
    text("false", x+5-camPos, y+56-camPosY);
  }
}
