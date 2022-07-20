import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

abstract class LogicOutputComponent extends LogicComponent {
  LogicOutputComponent(float x, float y, String type, LogicBoard board) {
    super(x, y, type, board);
    button=new Button(primaryWindow, x, y, 100, 80, "  "+type+"  ");
  }
  LogicOutputComponent(float x, float y, String type, LogicBoard board, JSONArray cnects) {
    super(x, y, type, board, cnects);
    button=new Button(primaryWindow, x, y, 100, 80, "  "+type+"  ");
  }
  void draw() {
    button.x=x-camPos;
    button.y=y-camPosY;
    button.draw();
    fill(#FF98CF);
    ellipse(x-2-camPos, y+20-camPosY, 20, 20);
    ellipse(x-2-camPos, y+60-camPosY, 20, 20);
  }
  float[] getTerminalPos(int t) {
    if (t==0) {
      return new float[]{x-2-camPos, y+20-camPosY};
    }
    if (t==1) {
      return new float[]{x-2-camPos, y+60-camPosY};
    }
    return new float[]{-1000, -1000};
  }
}
