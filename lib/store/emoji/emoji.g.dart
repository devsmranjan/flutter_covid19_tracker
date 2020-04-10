// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emoji.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Emoji on _Emoji, Store {
  final _$sadEmojiAtom = Atom(name: '_Emoji.sadEmoji');

  @override
  String get sadEmoji {
    _$sadEmojiAtom.context.enforceReadPolicy(_$sadEmojiAtom);
    _$sadEmojiAtom.reportObserved();
    return super.sadEmoji;
  }

  @override
  set sadEmoji(String value) {
    _$sadEmojiAtom.context.conditionallyRunInAction(() {
      super.sadEmoji = value;
      _$sadEmojiAtom.reportChanged();
    }, _$sadEmojiAtom, name: '${_$sadEmojiAtom.name}_set');
  }

  final _$normalEmojiAtom = Atom(name: '_Emoji.normalEmoji');

  @override
  String get normalEmoji {
    _$normalEmojiAtom.context.enforceReadPolicy(_$normalEmojiAtom);
    _$normalEmojiAtom.reportObserved();
    return super.normalEmoji;
  }

  @override
  set normalEmoji(String value) {
    _$normalEmojiAtom.context.conditionallyRunInAction(() {
      super.normalEmoji = value;
      _$normalEmojiAtom.reportChanged();
    }, _$normalEmojiAtom, name: '${_$normalEmojiAtom.name}_set');
  }

  final _$_EmojiActionController = ActionController(name: '_Emoji');

  @override
  void getRandomEmoji() {
    final _$actionInfo = _$_EmojiActionController.startAction();
    try {
      return super.getRandomEmoji();
    } finally {
      _$_EmojiActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'sadEmoji: ${sadEmoji.toString()},normalEmoji: ${normalEmoji.toString()}';
    return '{$string}';
  }
}
