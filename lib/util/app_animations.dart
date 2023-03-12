class AppAnimations {
  const AppAnimations._();

  static const _base = 'assets/animations/';

  static String _lottiePath(String name) => '$_base$name.json';

  static final arrow = _lottiePath('arrow');
  static final scanner = _lottiePath('scanner');
}
