import 'dart:ui';

import 'package:fika/utils.dart';

import 'data.dart';

class HeaderTitle extends AbsSprite {
  GText title, outText;
  GText price;

  @override
  void addedToStage() {
    super.addedToStage();
    title = buildTitle();
    outText = buildTitle();
    price = GText(
      text: '2,50€',
      textStyle: TextStyle(
        fontSize: 29,
        letterSpacing: -1.6,
        fontWeight: FontWeight.normal,
        color: Color(0xff484445),
      ),
    );
    addChild(price);
    addChild(title);
    addChild(outText);
    price.alignPivot(Alignment.topCenter);
    price.y = 163;
    price.x = sw / 2;
  }

  void setCurrentItem(int id, int dir) {
    var vo = coffeeList[id];
    String p = vo.price.toStringAsFixed(2);
    p = p.replaceAll('.', ',');
    price.tween(
      duration: .18,
      alpha: .1,
      scaleY: .8,
      onComplete: () {
        price.text = p + ' €';
        price.tween(duration: .3, alpha: 1, scaleY: 1);
      },
    );
    price.alignPivot(Alignment.topCenter);

    outText.text = title.text;
    outText.alignPivot(Alignment.bottomCenter);
    outText.validate();

    title.text = vo.name;
    title.alignPivot(Alignment.bottomCenter);

    outText.setProps(x: sw / 2, alpha: 1);
    double outX ;
    if( dir == -1){
      title.setProps(x: sw, alpha: 0);
      outX = -sw * .2;
    } else {
      title.setProps(x: 0, alpha: 0);
      outX = sw * 1.2;
    }
    outText.tween(
      duration: .6,
      x: outX,
      alpha: 0,
      ease: GEase.easeOutSine,
    );
    title.tween(
      duration: .6,
      delay: .2,
      x: sw / 2,
      alpha: 1,
      ease: GEase.easeOutSine,
    );
  }

  GText buildTitle() {
    var tf = GText(
      text: 'Caramel\nMacchiato',
      width: sw * .8,
      textStyle: TextStyle(
        fontSize: 30,
        letterSpacing: -1.6,
        fontWeight: FontWeight.bold,
        color: Color(0xff0C0103),
        height: 1,
      ),
      paragraphStyle: ParagraphStyle(textAlign: TextAlign.center),
    );
    tf.validate();
    tf.alignPivot(Alignment.bottomCenter);
    tf.y = 142;
    tf.x = sw / 2;
    return tf;
  }
}
