List<T> map2<F, T>(List<F> list, T f(F element)) {
  List<T> result = [];
  list.forEach((F item) {
    result.add(f(item));
  });
  return result;
}
