
String converString(String numStr) {
  double num = double.parse(numStr);
  if (num < 100000) {
    return  '${num}';
  } 
  String newNum = (num / 10000.0).toStringAsFixed(1);
  return '${newNum}万';
}