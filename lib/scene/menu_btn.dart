import 'package:fika/utils.dart';

class MenuBtn extends AbsSprite {
  GSvgShape arrow;
  GText text;
  GShape _hitArea;

  MenuBtn([GSprite doc]) : super(doc: doc);

  bool get showingText => text.alpha > 0.5;

  void showText(bool flag) {
    text.tween(duration: .46, alpha: !flag ? 0 : 1);
    _hitArea.x = flag ? text.x : arrow.x;
  }

  @override
  Future<void> addedToStage() async {
    super.addedToStage();
    arrow = await UiUtils.svgShape(Assets.icoMenu, this);
    text = GText(
      text: 'Menu',
      textStyle: TextStyle(
        color: kColorWhite,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: -.7,
      ),
    );
    addChild(text);
    text.validate();
    arrow.y = -2;
    arrow.x = text.textWidth + 2;
    arrow.colorize = Colors.white;
    arrow.mouseEnabled = text.mouseEnabled = false;

    _hitArea = UiUtils.shape();
    _hitArea.graphics
        .beginFill(kColorTransparent)
        .drawGRect(this.bounds)
        .endFill();
    addChild(_hitArea);
    alignPivot(Alignment.bottomRight);

    filters = [GDropShadowFilter(2, 2, 0, 0, Colors.black26)];
    var isPress = false;
    _hitArea.onMouseDown.add((event) {
      isPress = true;
      tween(duration: .2, colorize: kColorBlack);
    });
    stage.onMouseUp.add((event) {
      if (!isPress) return;
      isPress = false;
      tween(duration: .6, colorize: kColorBlack.withOpacity(0));
    });
  }
}
