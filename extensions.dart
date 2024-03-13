
import 'dart:developer';

extension Logger on String {
  void logger() {
    log("PRINTING IN LOG : $this");
  }
}