import 'package:fika/scene/coffee.dart';
import 'package:fika/scene/data.dart';
import 'package:fika/utils.dart';

import 'header_title.dart';
import 'menu_btn.dart';

class CoffeeMenu extends AbsSprite {
  MenuBtn menu_btn;
  double startDragY = 0.0;
  double lastDragY = 0.0;

  HeaderTitle title;
  var items = <Coffee>[];
  var alphas = <double>[1, 1, .88, .7, 0];
  var positions = [2, .95, .7, .6, .72];
  var posX = <double>[0, 0, .02, -.02, 0];
  var scales = [1.5, .8, .5, .35, .14];

  @override
  void addedToStage() {
    super.addedToStage();
    stage.keyboard.onUp.add((event) {
      if (event.arrowUp) {
        scroll(-1);
      } else if (event.arrowDown) {
        scroll(1);
      }
    });

    menu_btn = MenuBtn(this);
    menu_btn.setPosition(sw - 20, sh - 60);

    title = HeaderTitle();
    addChild(title);
    initList();
    stage.onMouseDown.add(_onDown);
  }

  void _onDragEnd(e) {
    stage.onMouseMove.remove(_onMove);
  }

  void _onMove(e) {
    var my = mouseY;
    var dragDistance = my - startDragY;
    var diffLastY = lastDragY - my;
    lastDragY = my;
    if (dragDistance.abs() > 140) {
      startDragY = my ;
      var speedRatio = diffLastY.abs() / 80;
      speedRatio = speedRatio.clamp(.2, 0.9);
      scroll(dragDistance.sign.toInt(), 1 - speedRatio);
    }
  }

  void _onDown(e) {
    lastDragY = startDragY = mouseY;
    stage.onMouseMove.add(_onMove);
    stage.onMouseUp.addOnce(_onDragEnd);
  }


  void initList() {
    final len = coffeeList.length;
    var cx = sw / 2;
    for (var i = 0; i < len; ++i) {
      var id = coffeeList[i].id;
      // var i2 = len-1-i;
      var item = Coffee(id);
      item.x = cx;
      item.y = sh;
      item.visible = false;
      item.scale = 0;

      items.add(item);
      addChildAt(item, 0);
    }
    scroll(0);
  }

  int _scroll = 0;

  void scroll(int dir, [double speed = .3]) {
    if( dir != 0 && menu_btn.showingText){
      menu_btn.showText(false);
    }

    _scroll += dir;
    final len = coffeeList.length;
    final len2 = positions.length;
    _scroll %= len;

    title.setCurrentItem(_scroll, dir);

    for (var i = 0; i < len; ++i) {
      var item = items[i];
      var j = i + _scroll;
      j %= len;
      if (item.idx == -1) {
        item.idx = j;
      }
      if (j < len2) {
        var diff = (item.idx - j);
        item.idx = j;
        var dur = 0.0;
        var dly = 0.0;
        if (diff.abs() == 1) {
          dur = .3 + 1.2 * speed;
          var off = dir > 0 ? (len2 - j)/2 : j;
          dly = off * .03 * speed;
        }
        var pos = positions[j] - .18;
        var sc = scales[j];
        var al = alphas[j];
        var ty = pos * sh;
        var tx = sw / 2 + posX[j] * sw;
        if (j == 0) {
          dur *= 1.2;
        }
        GTween.killTweensOf(item);
        item.scaleY = item.scaleX;
        item.tween(
          duration: dur,
          delay: dly,
          scale: sc,
          // scaleX: sc,
          y: ty,
          ease: GEase.easeOutSine,
          colorize: kColorWhite.withOpacity(1 - al),
        );
        item.visible = true;
        final index = len - 1 - j;
        addChildAt(item, index);
      } else {
        item.visible = false;
      }
    }
  }

}
