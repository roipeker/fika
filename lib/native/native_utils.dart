import '_osx.dart' if (dart.library.html) '_web.dart';

class NativeUtils {
  static void openUrl(String url) {
    NativeUtilsImpl.openUrl(url);
  }

  static void closeLoader(){
    NativeUtilsImpl.closeLoader();
  }
}
