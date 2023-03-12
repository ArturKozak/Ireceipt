class AppIcons {
  const AppIcons._();

  static const _base = 'assets/svg/';

  static String _svgPath(String name) => '$_base$name.svg';

  static final flashLightOn = _svgPath('flashlight_on');
  static final flashLightOff = _svgPath('flashlight_off');
}
