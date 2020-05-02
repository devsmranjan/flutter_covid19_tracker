// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DownloadStore on _DownloadStoreBase, Store {
  final _$isDownloadingAtom = Atom(name: '_DownloadStoreBase.isDownloading');

  @override
  bool get isDownloading {
    _$isDownloadingAtom.context.enforceReadPolicy(_$isDownloadingAtom);
    _$isDownloadingAtom.reportObserved();
    return super.isDownloading;
  }

  @override
  set isDownloading(bool value) {
    _$isDownloadingAtom.context.conditionallyRunInAction(() {
      super.isDownloading = value;
      _$isDownloadingAtom.reportChanged();
    }, _$isDownloadingAtom, name: '${_$isDownloadingAtom.name}_set');
  }

  final _$totalSizeAtom = Atom(name: '_DownloadStoreBase.totalSize');

  @override
  double get totalSize {
    _$totalSizeAtom.context.enforceReadPolicy(_$totalSizeAtom);
    _$totalSizeAtom.reportObserved();
    return super.totalSize;
  }

  @override
  set totalSize(double value) {
    _$totalSizeAtom.context.conditionallyRunInAction(() {
      super.totalSize = value;
      _$totalSizeAtom.reportChanged();
    }, _$totalSizeAtom, name: '${_$totalSizeAtom.name}_set');
  }

  final _$sizeDownloadedAtom = Atom(name: '_DownloadStoreBase.sizeDownloaded');

  @override
  double get sizeDownloaded {
    _$sizeDownloadedAtom.context.enforceReadPolicy(_$sizeDownloadedAtom);
    _$sizeDownloadedAtom.reportObserved();
    return super.sizeDownloaded;
  }

  @override
  set sizeDownloaded(double value) {
    _$sizeDownloadedAtom.context.conditionallyRunInAction(() {
      super.sizeDownloaded = value;
      _$sizeDownloadedAtom.reportChanged();
    }, _$sizeDownloadedAtom, name: '${_$sizeDownloadedAtom.name}_set');
  }

  final _$downloadPercentageAtom =
      Atom(name: '_DownloadStoreBase.downloadPercentage');

  @override
  double get downloadPercentage {
    _$downloadPercentageAtom.context
        .enforceReadPolicy(_$downloadPercentageAtom);
    _$downloadPercentageAtom.reportObserved();
    return super.downloadPercentage;
  }

  @override
  set downloadPercentage(double value) {
    _$downloadPercentageAtom.context.conditionallyRunInAction(() {
      super.downloadPercentage = value;
      _$downloadPercentageAtom.reportChanged();
    }, _$downloadPercentageAtom, name: '${_$downloadPercentageAtom.name}_set');
  }

  final _$_DownloadStoreBaseActionController =
      ActionController(name: '_DownloadStoreBase');

  @override
  void updateDownloading(bool update) {
    final _$actionInfo = _$_DownloadStoreBaseActionController.startAction();
    try {
      return super.updateDownloading(update);
    } finally {
      _$_DownloadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTotalSize(double size) {
    final _$actionInfo = _$_DownloadStoreBaseActionController.startAction();
    try {
      return super.updateTotalSize(size);
    } finally {
      _$_DownloadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateDownloadedSize(double size) {
    final _$actionInfo = _$_DownloadStoreBaseActionController.startAction();
    try {
      return super.updateDownloadedSize(size);
    } finally {
      _$_DownloadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isDownloading: ${isDownloading.toString()},totalSize: ${totalSize.toString()},sizeDownloaded: ${sizeDownloaded.toString()},downloadPercentage: ${downloadPercentage.toString()}';
    return '{$string}';
  }
}
