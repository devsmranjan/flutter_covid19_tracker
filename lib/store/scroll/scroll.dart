import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'scroll.g.dart';

class ScrollStore = _ScrollStoreBase with _$ScrollStore;

abstract class _ScrollStoreBase with Store {
  @observable
  bool isScrollReached = false;

  @observable
  int scrollReachedTimes = 0;

 

  @action
  void updateScrollReached(ScrollController scrollController, var offsetToReach) {
    if (scrollController.offset >= offsetToReach && !scrollController.position.outOfRange) {
      // print("reached : " + scrollController.offset.toString());
      scrollReachedTimes++;
      isScrollReached = true;
    }
  }
}
