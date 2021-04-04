import 'dart:html' as html;

class NativeUtilsImpl {

  static void closeLoader() {
    html.querySelector("#loader")?.remove();
  }

  static void openUrl(String url) {
    html.window.open('$url', 'roipeker');
  }
}
