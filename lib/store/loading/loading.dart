import 'package:mobx/mobx.dart';

part 'loading.g.dart';

class Loading = _Loading with _$Loading;

abstract class _Loading with Store {
  @observable
  bool isLoading = true;

  @action
  void startLoading1000() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 1000), () {
      isLoading = false;
      print("Loading complete");
    });
  }

  @action
  void startLoading2000() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 2000), () {
      isLoading = false;
      print("Loading complete");
    });
  }

  @action
  void startLoading3000() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 3000), () {
      isLoading = false;
      print("Loading complete");
    });
  }

  @action
  void startLoading5000() {
    isLoading = true;
    Future.delayed(const Duration(milliseconds: 5000), () {
      isLoading = false;
      print("Loading complete");
    });
  }

  @action
  void updateLoading(bool update) {
    isLoading = update;
  }
}
