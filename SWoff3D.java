import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class SWoff3D extends StageComponent {//ground component
  SWoff3D(JSONObject data, boolean stage_3D) {
    type="3DoffSW";
    x=data.getFloat("x");
    y=data.getFloat("y");
    if (stage_3D) {
      z=data.getFloat("z");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }

  SWoff3D(float X, float Y, float Z) {
    x=X;
    y=Y;
    z=Z;
    type="3DoffSW";
  }
  StageComponent copy() {
    return new SWoff3D(x, y, z);
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
    draw3DSwitch2(((x+group.xOffset)-drawCamPosX)*Scale, ((y+group.yOffset)+drawCamPosY)*Scale, Scale);
  }

  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    draw3DSwitch2((x+group.xOffset), y, (z+group.zOffset), Scale);
    if (player1.x>=(x+group.xOffset)-10&&player1.x<=(x+group.xOffset)+10&&player1.y >=(y+group.yOffset)-10&&player1.y<= (y+group.yOffset)+2 && player1.z >= (z+group.zOffset)-10 && player1.z <= (z+group.zOffset)+10) {
      e3DMode=false;
      WPressed=false;
      SPressed=false;
      gmillis=millis()+1200;
    }
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

  boolean colide(float x, float y, float z, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x >= ((this.x+group.xOffset))-20 && x <= ((this.x+group.xOffset)) + 20 && y >= ((this.y+group.yOffset)) - 10 && y <= (this.y+group.yOffset) && z >= ((this.z+group.zOffset)) - 10 && z <= (this.z+group.zOffset)) {
        return true;
      }
    }
    return false;
  }
}
