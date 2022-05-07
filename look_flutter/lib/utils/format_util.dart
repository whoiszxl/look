class FormatUtil {

  static String seconds2Str(num seconds) {
    if(seconds == null) {
      return '00:00';
    }
    num m = (seconds / 60).truncate();
    num s = seconds - m * 60;
    if (s < 10) {
      return '$m:0$s';
    }
    return '$m:$s';
  }

}