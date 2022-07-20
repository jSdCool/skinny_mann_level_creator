import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class CheckPoint extends StageComponent {//ground component
  CheckPoint(JSONObject data, boolean stage_3D) {
    type="check point";
    x=data.getFloat("x");
    y=data.getFloat("y");
    if (stage_3D) {
      z=data.getFloat("z");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }

  CheckPoint(float X, float Y) {
    type="check point";
    x=X;
    y=Y;
  }
  CheckPoint(float X, float Y, float Z) {
    type="check point";
    x=X;
    y=Y;
    z=Z;
  }
  StageComponent copy() {
    return new CheckPoint(x, y, z);
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
    float playx=player1.getX();
    boolean po=false;
    if (playx>=(x+group.xOffset)-5 && playx<= (x+group.xOffset)+5 && (y+group.yOffset)-50 <= player1.getY() && (y+group.yOffset)>=player1.getY()-10) {
      respawnX=(int)x;
      respawnY=(int)y;
      respawnStage=currentStageIndex;
      po=true;
      checkpointIn3DStage=false;
    }

    float x2=(x+group.xOffset)-drawCamPosX;
    float y2=(y+group.yOffset)+drawCamPosY;
    if (po)
      fill(#E5C402);
    else
      fill(#B9B9B9);
    rect((x2-3)*Scale, (y2-60)*Scale, 5*Scale, 60*Scale);
    fill(#EA0202);
    triangle(x2*Scale, (y2-60)*Scale, x2*Scale, (y2-40)*Scale, (x2+30)*Scale, (y2-50)*Scale);
  }

  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    //noStroke();
    float playx=player1.getX();
    boolean po=false;
    if (playx>=(x+group.xOffset)-20 && playx<= (x+group.xOffset)+20 && (y+group.yOffset)-50 <= player1.getY() && (y+group.yOffset)>=player1.getY()-10 && player1.z >= (z+group.zOffset)-20 && player1.z <= (z+group.zOffset)+20) {
      respawnX=(int)x;
      respawnY=(int)y;
      respawnZ=(int)player1.z;
      respawnStage=stageIndex;
      checkpointIn3DStage=true;
      po=true;
    }


    if (po)
      fill(#E5C402);
    else
      fill(#B9B9B9);
    //strokeWeight(0);
    translate((x+group.xOffset), (y+group.yOffset)-30, (z+group.zOffset));
    box(4, 60, 4);
    translate(-(x+group.xOffset), -((y+group.yOffset)-30), -(z+group.zOffset));
    fill(#EA0202);
    //stroke(#EA0202);
    //strokeWeight(0);
    translate((x+group.xOffset)+10, (y+group.yOffset)-50, (z+group.zOffset));
    box(20, 20, 2);
    translate(-((x+group.xOffset)+10), -((y+group.yOffset)-50), -(z+group.zOffset));
  }

  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x>=(this.x+group.xOffset)-8 && x<= (this.x+group.xOffset)+8 && y >= (this.y+group.yOffset)-50 && y <= (this.y+group.yOffset)) {
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
      if (x>=(this.x+group.xOffset)-8 && x<= (this.x+group.xOffset)+8 && y >= (this.y+group.yOffset)-50 && y <= (this.y+group.yOffset) && z>=(this.z+group.zOffset)-8 && z<= (this.z+group.zOffset)+8 ) {
        return true;
      }
    }
    return false;
  }
}
