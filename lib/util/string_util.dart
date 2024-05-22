

abstract class StringUtil {
 static String capitalizeFirstLetter(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }


 static String formatSize(double size, int index) {
   return size.toStringAsFixed(index % 2 == 0 ? 0 : 1);
 }



}
