import 'package:fika/utils.dart';

class Coffee extends AbsSprite {
  String id;
  GShape ref;
  GBitmap img;
  double w, h;
  int idx = -1;

  Coffee(this.id);

  @override
  void addedToStage() {
    super.addedToStage();
    // ref.visible = false;
    img = UiUtils.image(id, this);
    img.alignPivot(Alignment(0, .3));

    /// usamos "ref" para que el bounding box del objeto no recorte el
    /// dropshadow.
    ref = UiUtils.shape(this);
    ref.graphics
        .beginFill(Colors.white.withOpacity(.01))
        .drawRect(0, 0, 10, 10)
        .endFill();
    ref.width = img.width;
    ref.height = img.height + 40;
    ref.y = -img.pivotY;
    ref.x = -img.pivotX;

    var spot2 = UiUtils.shape();
    spot2.graphics.beginFill(Color(0xff372118)).drawCircle(0, 0, 100).endFill();
    spot2.height = 50;
    spot2.width = 220; //img.width * .67;
    spot2.x = 0;
    spot2.y = -img.pivotY + img.height - 15;
    spot2.filters = [GBlurFilter(14, 14)];
    addChildAt(spot2, 0);
  }
}
