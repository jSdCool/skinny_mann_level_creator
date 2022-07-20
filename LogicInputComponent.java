//LogicInputComponent
import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

abstract class LogicInputComponent extends LogicComponent {
  LogicInputComponent(float x, float y, String type, LogicBoard board) {
    super(x, y, type, board);
    button=new Button(primaryWindow, x, y, 100, 40, "  "+type+"  ");
  }
  LogicInputComponent(float x, float y, String type, LogicBoard board, JSONArray cnects) {
    super(x, y, type, board, cnects);
    button=new Button(primaryWindow, x, y, 100, 40, "  "+type+"  ");
  }
  void draw() {
    button.x=x-camPos;
    button.y=y-camPosY;
    button.draw();
    fill(#FA5BD5);
    ellipse(x+102-camPos, y+20-camPosY, 20, 20);
  }
  float[] getTerminalPos(int t) {
    if (t==2) {
      return new float[]{x+102-camPos, y+20-camPosY};
    }
    return new float[]{-1000, -1000};
  }
}
