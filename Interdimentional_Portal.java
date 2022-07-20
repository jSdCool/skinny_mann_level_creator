import java.io.Serializable;
import processing.core.*;
import processing.data.*;
import java.util.ArrayList;

class Interdimentional_Portal extends StageComponent {//ground component
  float linkX, linkY, linkZ;
  int linkIndex;
  Interdimentional_Portal(JSONObject data, boolean stage_3D) {
    type="interdimentional Portal";
    x=data.getFloat("x");
    y=data.getFloat("y");
    linkX=data.getFloat("linkX");
    linkY=data.getFloat("linkY");
    linkIndex=data.getInt("link Index")-1;
    if (!data.isNull("z")) {
      z=data.getFloat("z");
    }
    if (!data.isNull("linkZ")) {
      linkZ=data.getFloat("linkZ");
    }
    if (!data.isNull("group")) {
      group=data.getInt("group");
    }
  }
  StageComponent copy() {
    return null;
  }

  JSONObject save(boolean stage_3D) {
    JSONObject part=new JSONObject();
    part.setFloat("x", x);
    part.setFloat("y", y);
    if (stage_3D) {
      part.setFloat("z", z);
      part.setFloat("linkZ", linkZ);
    }
    part.setString("type", type);
    part.setFloat("linkX", linkX);
    part.setFloat("linkY", linkY);
    part.setInt("link Index", linkIndex+1);
    part.setInt("group", group);
    return part;
  }

  void draw() {
    Group group=getGroup();
    if (!group.visable)
      return;
    float playx=player1.getX(), playy=player1.getY();
    drawPortal(Scale*((x+group.xOffset)-drawCamPosX), Scale*((y+group.yOffset)+drawCamPosY), Scale*1);
    if ((playx>(x+group.xOffset)-25&&playx<(x+group.xOffset)+25&&playy>(y+group.yOffset)-50&&playy<(y+group.yOffset)+60)) {
      fill(255);
      textSize(Scale*20);
      displayText="Press E";
      displayTextUntill=millis()+100;
    }

    if (E_pressed&&(playx>(x+group.xOffset)-25&&playx<(x+group.xOffset)+25&&playy>(y+group.yOffset)-50&&playy<(y+group.yOffset)+60)) {
      E_pressed=false;
      selectedIndex=-1;
      stageIndex=linkIndex;
      currentStageIndex=linkIndex;

      background(0);
      if (linkZ!=-1) {
        setPlayerPosZ=(int)linkZ;
        player1.z=linkZ;
        tpCords[2]=linkZ;
      }
      player1.setX(linkX).setY(linkY);
      setPlayerPosTo=true;
      tpCords[0]=(int)linkX;
      tpCords[1]=(int)linkY;
      gmillis=millis()+850;
    }
  }

  void draw3D() {
    Group group=getGroup();
    if (!group.visable)
      return;
    float playx=player1.getX(), playy=player1.getY();

    translate(0, 0, z);
    drawPortal((x+group.xOffset), (y+group.yOffset), 1);
    translate(0, 0, -z);
    if ((playx>(x+group.xOffset)-25&&playx<(x+group.xOffset)+25&&playy>(y+group.yOffset)-50&&playy<(y+group.yOffset)+60&& player1.z >= z-20 && player1.z <= z+20)) {
      fill(255);
      textSize(20);
      displayText="Press E";
      displayTextUntill=millis()+100;
    }

    if (E_pressed&&(playx>(x+group.xOffset)-25&&playx<(x+group.xOffset)+25&&playy>(y+group.yOffset)-50&&playy<(y+group.yOffset)+60)) {
      E_pressed=false;
      selectedIndex=-1;
      stageIndex=linkIndex;
      currentStageIndex=linkIndex;

      background(0);
      if (linkZ!=-1) {
        setPlayerPosZ=(int)linkZ;
        player1.z=linkZ;
        tpCords[2]=linkZ;
      }
      player1.setX(linkX).setY(linkY);
      setPlayerPosTo=true;
      tpCords[0]=(int)linkX;
      tpCords[1]=(int)linkY;
      gmillis=millis()+850;
    }
  }

  boolean colide(float x, float y, boolean c) {
    Group group=getGroup();
    if (!group.visable)
      return false;
    if (c) {
      if (x>(this.x+group.xOffset)-25&&x<(this.x+group.xOffset)+25&&y>(this.y+group.yOffset)-50&&y<(this.y+group.yOffset)+60) {
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
      if (x > (this.x+group.xOffset)-25 && x < (this.x+group.xOffset)+25 && y >(this.y+group.yOffset)-50 && y < (this.y+group.yOffset)+60 && z > (this.z+group.zOffset)-2 && z < (this.z+group.zOffset)+2) {
        return true;
      }
    }
    return false;
  }
}
