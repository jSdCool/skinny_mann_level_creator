import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Set3DMode extends LogicOutputComponent {
  int groupNumber=0;
  float offset=0;
  Set3DMode(float x, float y, LogicBoard lb) {
    super(x, y, "  set 3D  ", lb);
  }

  Set3DMode(JSONObject data, LogicBoard lb, Level level) {
    super(data.getFloat("x"), data.getFloat("y"), "  set 3D  ", lb, data.getJSONArray("connections"));
  }
  void tick() {
    if (inputTerminal1) {
      e3DMode=true;
    }
    if (inputTerminal2) {
      e3DMode=false;
    }
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
