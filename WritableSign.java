import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class WritableSign extends StageComponent {
  String contents;
  WritableSign(JSONObject data, boolean stage_3D) {
    type="WritableSign";
    x=data.getFloat("x");
    y=data.getFloat("y");
    if (stage_3D) {
      z=data.getFloat("z");
    }
    contents=data.getString("contents");
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }
  WritableSign(float X, float Y) {
    x=X;
    y=Y;
    contents="";
    type="WritableSign";
  }
  WritableSign(float X, float Y, float Z) {
    x=X;
    y=Y;
    z=Z;
    contents="";
    type="WritableSign";
  }
  StageComponent copy() {
    WritableSign e=new WritableSign(x, y, z);
    e.contents=contents;
    return  e;
  }

  void draw() {
    Group group=getGroup();
    if (!group.visable)
      return;
    drawSign(Scale*((x+group.xOffset)-drawCamPosX), Scale*((y+group.yOffset)+drawCamPosY), Scale);

    float playx=player1.getX(), playy=player1.getY();
    if (playx>(x+group.xOffset)-35&&playx<(x+group.xOffset)+35&&playy>(y+group.yOffset)-40&&playy<(y+group.yOffset)) {//display the press e message to the player
      fill(255);
      textSize(Scale*20);
      displayText="Press E";
      displayTextUntill=millis()+100;

      if (E_pressed) {
        E_pressed=false;
        viewingItemContents=true;
      }
    }
  }
  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    drawSign((x+group.xOffset), (y+group.yOffset), (z+group.zOffset), Scale);

    float playx=player1.getX(), playy=player1.getY();
    if (playx>(x+group.xOffset)-35&&playx<(x+group.xOffset)+35&&playy>(y+group.yOffset)-40&&playy<(y+group.yOffset)&& player1.z >= (z+group.zOffset)-20 && player1.z <= (z+group.zOffset)+20) {
      fill(255);
      textSize(20);
      displayText="Press E";
      displayTextUntill=millis()+100;
      if (E_pressed) {
        E_pressed=false;
        viewingItemContents=true;
      }
    }
  }
  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x >= ((this.x+group.xOffset))-35 && x <= ((this.x+group.xOffset)) + 35 && y >= ((this.y+group.yOffset)) - 65 && y <= (this.y+group.yOffset)) {
        return true;
      }
    }
    return false;
  }

  boolean colide(float x, float y, float z, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x >= ((this.x+group.xOffset))-35 && x <= ((this.x+group.xOffset)) + 35 && y >= ((this.y+group.yOffset)) - 65 && y <= (this.y+group.yOffset) && z >= ((this.z+group.yOffset)) - 5 && z <= (this.z+group.zOffset)+5) {
        return true;
      }
    }
    return false;
  }

  JSONObject save(boolean stage_3D) {
    JSONObject part=new JSONObject();
    part.setFloat("x", x);
    part.setFloat("y", y);
    if (stage_3D) {
      part.setFloat("z", z);
    }
    part.setString("type", type);
    part.setString("contents", contents);
    part.setInt("group", group);
    return part;
  }

  void setData(String data) {
    contents=data;
  }

  String getData() {
    return contents;
  }
}
