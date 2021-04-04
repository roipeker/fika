import 'package:fika/assets.dart';
import 'package:fika/scene/header_title.dart';
import 'package:fika/utils.dart';
import 'package:flutter/material.dart';
import 'package:graphx/graphx.dart';

import 'coffee.dart';
import 'coffee_menu.dart';

class HomeScene extends AbsSprite {
  GShape bg;
  HeaderTitle title;
  CoffeeMenu menu;

  @override
  Future<void> addedToStage() async {
    super.addedToStage();
    await Assets.loadImages();

    var spot = UiUtils.shape(this);
    spot.graphics
        .beginGradientFill(
            GradientType.radial, [Color(0xff966C45), kColorWhite],
            ratios: [0.2, 1])
        .drawCircle(0, 0, sw * .67)
        .endFill();
    spot.height = 146;
    spot.setPosition(sw * .55, sh * .97);
    spot.filters = [GBlurFilter(20, 20)];

    var back = await UiUtils.svgShape(Assets.icoBack, this);
    var walletSpr = UiUtils.sprite(this);
    // walletSpr.filters = [GDropShadowFilter(2, 2, 0, 0, Colors.black26)];
    var wallet = await UiUtils.svgShape(Assets.icoWallet, walletSpr);
    // wallet.colorize = kColorWhite;
    back.setPosition(22, 36);
    wallet.setPosition(sw - wallet.width - 22, 32);

    // testHome();
    testMenu();
  }

  void testMenu() {
    menu = CoffeeMenu();
    addChild(menu);
  }

  void testHome() {
    bg = UiUtils.shape(this);
    bg.graphics
        .beginGradientFill(
      GradientType.linear,
      [Color(0xffAA8B6E), Color(0xffFFFBF6)],
      ratios: [0, .65],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    )
        .drawGRect(stage.stageRect)
        .endFill();
    // bg.visible = false;
    var cup01 = UiUtils.image(Assets.img_9);
    cup01.alignPivot(Alignment.topCenter);
    addChild(cup01);
    cup01.width = 152;
    cup01.scaleY = cup01.scaleX;
    cup01.x = sw / 2;
    cup01.y = 133;

    var cup02 = UiUtils.image(Assets.img_11);
    addChild(cup02);
    cup02.width = 300;
    cup02.alignPivot(Alignment.topCenter);
    cup02.scaleY = cup02.scaleX;
    cup02.scaleX *= -1;
    cup02.x = sw / 2;
    cup02.y = 186;

    var cup03 = UiUtils.image(Assets.img_8);
    addChild(cup03);
    cup03.alignPivot(Alignment.center);
    cup03.scale = 1.14;
    cup03.x = sw / 2;
    cup03.y = 490;

    var logo = UiUtils.image(Assets.img_logo, this);
    logo.alignPivot(Alignment.topCenter);
    logo.height = 148;
    logo.scaleX = logo.scaleY;
    logo.y = 458;
    logo.x = sw / 2;

    var cup04 = UiUtils.image(Assets.img_1);
    cup04.alignPivot(Alignment.topCenter);
    addChild(cup04);
    cup04.scale = 1.77;
    cup04.x = sw / 2;
    cup04.y = sh * .78;
  }
}
