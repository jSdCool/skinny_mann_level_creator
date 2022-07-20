//Delay
import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Delay extends LogicComponent {
  int time=10;
  ArrayList<Boolean> mem=new ArrayList<>();
  Delay(float x, float y, LogicBoard lb) {
    super(x, y, "delay", lb);
    button.setText("delay "+time+" ticks  ");
    for (int i=0; i<time; i++) {
      mem.add(false);
    }
  }

  Delay(JSONObject data, LogicBoard lb) {
    super(data.getFloat("x"), data.getFloat("y"), "delay", lb, data.getJSONArray("connections"));
    time=data.getInt("delay");
    button.setText("delay "+time+" ticks  ");
    for (int i=0; i<time; i++) {
      mem.add(false);
    }
  }

  void draw() {
    super.draw();
    fill(0);
    textSize(15);
    textAlign(LEFT, CENTER);
    text("input", x+5-camPos, y+16-camPosY);
    text("clear", x+5-camPos, y+56-camPosY);
  }

  void tick() {
    if (inputTerminal2) {
      mem=new ArrayList<>();
      for (int i=0; i<time; i++) {
        mem.add(false);
      }
    }
    outputTerminal=mem.remove(0);
    mem.add(inputTerminal1);
    //println(mem);
  }
  void setData(int data) {
    time=data;
    button.setText("delay "+time+" ticks  ");
    mem=new ArrayList<>();
    for (int i=0; i<time; i++) {
      mem.add(false);
    }
  }
  int getData() {
    return time;
  }

  JSONObject save() {
    JSONObject contence=super.save();
    contence.setInt("delay", time);
    return contence;
  }
}
