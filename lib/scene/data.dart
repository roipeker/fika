import 'package:fika/assets.dart';

class CoffeeVo {
  final String name, id;
  final double price;
  CoffeeVo(this.name, this.id, this.price);
}

final coffeeList = [
  CoffeeVo('Caramel Macchiato', Assets.img_1, 2.5),
  CoffeeVo('Caramel Cold Drink', Assets.img_2, 3.5),
  CoffeeVo('Iced Coffe Mocha', Assets.img_3, 4.20),
  CoffeeVo('Caramelized Pecan Latte', Assets.img_4, 3),
  CoffeeVo('Toffee Nut Latte', Assets.img_5, 2.5),
  CoffeeVo('Capuchino', Assets.img_6, 3.4),
  CoffeeVo('Toffee Nut Iced Latte', Assets.img_7, 2.4),
  CoffeeVo('Americano', Assets.img_8, 3.8),
  CoffeeVo('Vietnamese-Style Iced Coffee', Assets.img_9, 3),
  CoffeeVo('Black Tea Latte', Assets.img_10, 2.4),
  CoffeeVo('Classic Irish Coffee', Assets.img_11, 2.8),
  CoffeeVo('Toffee Nut Crunch Latte', Assets.img_12, 4.2),
];
