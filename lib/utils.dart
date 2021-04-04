import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart" as svg;
import 'package:graphx/graphx.dart';

export 'package:flutter/material.dart';
export 'package:graphx/graphx.dart' hide PainterUtils, MatrixUtils;

export 'assets.dart';

class GraphScene extends StatelessWidget {
  final Widget child;
  final GSprite front, back;

  GraphScene({
    Key key,
    this.front,
    this.back,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SceneBuilderWidget(
      builder: () => SceneController(
        front: front,
        back: back,
      ),
      child: child,
    );
  }
}

abstract class UiUtils {
  static Future<GSvgShape> svgShape(String textData, [GSprite doc]) async {
    var data = await UiUtils.svgDataFromString(textData);
    var ico = GSvgShape(data);
    doc?.addChild(ico);
    return ico;
  }

  static GShape shape([GSprite doc]) {
    var shape = GShape();
    doc?.addChild(shape);
    return shape;
  }

  static GSprite sprite([GSprite doc]) {
    var sprite = GSprite();
    doc?.addChild(sprite);
    return sprite;
  }

  static GBitmap image(String path, [GSprite doc]) {
    // final texture = await ResourceLoader.loadTexture(path);
    final texture = ResourceLoader.getTexture(path);
    var bitmap = GBitmap(texture);
    doc?.addChild(bitmap);
    return bitmap;
  }

  static Future<SvgData> svgDataFromString(String rawSvg) async {
    final svgRoot = await svg.svg.fromSvgString(rawSvg, rawSvg);
    var obj = SvgData();
    obj.hasContent = svgRoot.hasDrawableContent;
    obj.picture = svgRoot.toPicture();
    obj.viewBox = GRect.fromNative(svgRoot.viewport.viewBoxRect);
    obj.size = GRect(
      0,
      0,
      svgRoot.viewport.size.width,
      svgRoot.viewport.size.height,
    );
    return obj;
  }
}

class AbsSprite extends GSprite {
  double get sw => stage?.stageWidth ?? 0.0;

  double get sh => stage?.stageHeight ?? 0.0;

  @protected
  bool dirty = false;

  AbsSprite({GSprite doc}) {
    doc?.addChild(this);
  }

  void invalidateDraw() {
    dirty = true;
  }

  @override
  void update(double delta) {
    if (dirty) {
      dirty = false;
      draw();
    }
    super.update(delta);
  }

  @mustCallSuper
  void draw() {
    dirty = false;
  }
}

extension GraphExt on GDisplayObject {
  void kill(Object callback) => GTween.killTweensOf(callback);

  GTween dly(double time, Function callback) =>
      GTween.delayedCall(time, callback);
}

/// bezier
class _BezierControlPoint {
  GPoint prev;
  GPoint next;

  _BezierControlPoint([this.prev, this.next]) {
    prev ??= GPoint();
    next ??= GPoint();
  }
}

abstract class BezierUtils {
  static void bezierCurveThrough(Graphics g, List<GPoint> points,
      [double tension = .25]) {
    double _dist(double x, double y) => Math.sqrt(x * x + y * y);

    tension ??= .25;
    var len = points.length;
    if (len == 2) {
      g.moveTo(points[0].x, points[0].y);
      g.lineTo(points[1].x, points[1].y);
      return;
    }

    final List<_BezierControlPoint> cpoints = <_BezierControlPoint>[];
    points.forEach((e) {
      cpoints.add(_BezierControlPoint());
    });

    for (var i = 1; i < len - 1; ++i) {
      final pi = points[i];
      final pp = points[i - 1];
      final pn = points[i + 1];
      var rdx = pn.x - pp.x;
      var rdy = pn.y - pp.y;
      var rd = _dist(rdx, rdy);
      var dx = rdx / rd;
      var dy = rdy / rd;

      var dp = _dist(pi.x - pp.x, pi.y - pp.y);
      var dn = _dist(pi.x - pn.x, pi.y - pn.y);

      var cpx = pi.x - dx * dp * tension;
      var cpy = pi.y - dy * dp * tension;
      var cnx = pi.x + dx * dn * tension;
      var cny = pi.y + dy * dn * tension;

      cpoints[i].prev.setTo(cpx, cpy);
      cpoints[i].next.setTo(cnx, cny);
    }

    /// end points
    cpoints[0].next = GPoint(
      (points[0].x + cpoints[1].prev.x) / 2,
      (points[0].y + cpoints[1].prev.y) / 2,
    );

    cpoints[len - 1].prev = GPoint(
      (points[len - 1].x + cpoints[len - 2].next.x) / 2,
      (points[len - 1].y + cpoints[len - 2].next.y) / 2,
    );

    /// draw?
    g.moveTo(points[0].x, points[0].y);
    for (var i = 1; i < len; ++i) {
      var p = points[i];
      var cp = cpoints[i];
      var cpp = cpoints[i - 1];
      g.cubicCurveTo(cpp.next.x, cpp.next.y, cp.prev.x, cp.prev.y, p.x, p.y);
    }
  }
}
