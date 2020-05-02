import 'package:mobx/mobx.dart';

part 'download.g.dart';

class DownloadStore = _DownloadStoreBase with _$DownloadStore;

abstract class _DownloadStoreBase with Store {
  @observable
  bool isDownloading = false;

  @observable
  double totalSize = 0;

  @observable
  double sizeDownloaded = 0;

  @observable
  double downloadPercentage = 0;

  @action
  void updateDownloading(bool update) {
    isDownloading = update;
  }

  void updateDownloadPercentage() {
    downloadPercentage = (sizeDownloaded / totalSize) * 100;
  }

  @action
  void updateTotalSize(double size) {
    totalSize = size;
    updateDownloadPercentage();
  }

  @action
  void updateDownloadedSize(double size) {
    sizeDownloaded = size;
    updateDownloadPercentage();
  }

  @action
  void reset() {
    totalSize = 0;
    sizeDownloaded = 0;
    downloadPercentage = 0;
  }
}
