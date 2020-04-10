import 'dart:math';

import 'package:mobx/mobx.dart';

part 'emoji.g.dart';

class Emoji = _Emoji with _$Emoji;

abstract class _Emoji with Store {
  List _normalExp = ["😌", "😀", "😃"];

  List _sadExp = ["😟", "😕", "😩", "😷", "😬"];

  @observable
  String sadEmoji = "";

  @observable
  String normalEmoji = "";

  @action
  void getRandomEmoji() {
    final _random = Random();
    sadEmoji = _sadExp[_random.nextInt(_sadExp.length)];
    normalEmoji = _normalExp[_random.nextInt(_normalExp.length)];
  }
}
