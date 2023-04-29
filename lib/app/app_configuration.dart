enum ApplicationVersion {
  pl,
}

@pragma('vm:entry-point', true)
class ApplicationConfiguration {
  final ApplicationVersion version;

  bool get isPl => version == ApplicationVersion.pl;

  const ApplicationConfiguration._(this.version);

  factory ApplicationConfiguration.pl() {
    return ApplicationConfiguration._(ApplicationVersion.pl);
  }
}
