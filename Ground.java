import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Ground extends StageComponent {//ground component
  Ground(JSONObject data, boolean stage_3D) {
    type="ground";
    x=data.getFloat("x");
    y=data.getFloat("y");
    dx=data.getFloat("dx");
    dy=data.getFloat("dy");
    ccolor=data.getInt("color");
    if (stage_3D) {
      z=data.getFloat("z");
      dz=data.getFloat("dz");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }
  Ground(float X, float Y, float DX, float DY, int fcolor) {
    type="ground";
    x=X;
    y=Y;
    dx=DX;
    dy=DY;
    ccolor=fcolor;
  }
  Ground(float X, float Y, float Z, float DX, float DY, float DZ, int fcolor) {
    type="ground";
    x=X;
    y=Y;
    z=Z;
    dx=DX;
    dy=DY;
    dz=DZ;
    ccolor=fcolor;
  }
  StageComponent copy() {
    return new Ground(x, y, z, dx, dy, dz, ccolor);
  }

  JSONObject save(boolean stage_3D) {
    JSONObject part=new JSONObject();
    part.setFloat("x", x);
    part.setFloat("y", y);
    part.setFloat("dx", dx);
    part.setFloat("dy", dy);
    if (stage_3D) {
      part.setFloat("z", z);
      part.setFloat("dz", dz);
    }
    part.setInt("color", ccolor);
    part.setString("type", type);
    part.setInt("group", group);
    return part;
  }

  void draw() {
    Group group=getGroup();
    if (!group.visable)
      return;
    fill(ccolor);
    rect(Scale*((x+group.xOffset)-drawCamPosX)-1, Scale*((y+group.yOffset)+drawCamPosY)-1, Scale*dx+2, Scale*dy+2);
  }

  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    fill(ccolor);
    //strokeWeight(0);
    translate((x+group.xOffset)+dx/2, (y+group.yOffset)+dy/2, (z+group.zOffset)+dz/2);
    box(dx, dy, dz);
    translate(-1*((x+group.xOffset)+dx/2), -1*((y+group.yOffset)+dy/2), -1*((z+group.zOffset)+dz/2));
  }

  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    float x2 = (this.x+group.xOffset)+dx, y2=(this.y+group.yOffset)+dy;
    if (x >= (this.x+group.xOffset) && x <= x2 && y >= (this.y+group.yOffset) && y <= y2/* terain hit box*/) {
      return true;
    }
    return false;
  }

  boolean colide(float x, float y, float z, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    float x2 = (this.x+group.xOffset)+dx, y2=(this.y+group.yOffset)+dy, z2=(this.z+group.zOffset)+dz;
    if (x >= (this.x+group.xOffset) && x <= x2 && y >= (this.y+group.yOffset) && y <= y2 && z>=(this.z+group.zOffset) && z<=z2/* terain hit box*/) {
      return true;
    }
    return false;
  }
}
