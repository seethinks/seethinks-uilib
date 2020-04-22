import 'package:collection/collection.dart';

class ArrayUtil {
  static bool eq(val1, val2) {
    Function eq = const ListEquality().equals;

    return eq(val1, val2);
  }
}
