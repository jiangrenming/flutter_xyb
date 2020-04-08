
enum Env {
  PROD,
  DEV,
}
class Config {
  static Env env;
  static String get apiHost {
    switch (env) {
      case Env.PROD:
        return "http://market.myahmt.com";
      case Env.DEV:
        return "http://121.41.61.44:8123";
    }
  }
}