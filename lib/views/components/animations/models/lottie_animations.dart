enum LottieAnimations {
  dataNotFound(name: 'datanotfound'),
  empty(name: 'empty'),
  smallError(name: 'small_error'),
  loading(name: 'loading'),
  error(name: 'error');

  final String name;
  const LottieAnimations({required this.name});
}
