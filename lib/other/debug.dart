debug() {
  print("-----Debug-Start-----");
  print(adjacentElementsProduct([4, 12, 3, 1, 5]));
  print("-----Debug-End-----");
}

// Mine
// 暂时没有简单的写法
adjacentElementsProduct(array) {
  int max;
  for (int i = 0; i < array.length - 1; i++) {
    var value = array[i] * array[i + 1];
    if (i == 0) {
      max = value;
    } else {
      if (value > max) {
        max = value;
      }
    }
  }
  return max;
}
