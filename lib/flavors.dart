enum Flavor {
  dev,
  prod,
}

extension FlavorName on Flavor {
  String get name => toString().split('.').last;
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Buma';
      case Flavor.prod:
        return 'Buma';
      default:
        return 'title';
    }
  }

  static final Map<String, dynamic> sharedMap = {};

  static final devMap = {
  
    // staging
    'baseURL': 'https://dummyapi.io/data/v1',
    'socketURL': 'https://dummyapi.io/data/v1',
   
    // 'baseURLImages':'https://dummyapi.io/data/v1/',
    ...sharedMap,
  };

  static final prodMap = {
   
    'baseURL': 'https://dummyapi.io/data/v1',
    'socketURL': 'https://dummyapi.io/data/v1',
    ...sharedMap,
  };

  static Map<String, dynamic> get variables {
    switch (appFlavor) {
      case Flavor.dev:
        return devMap;
      case Flavor.prod:
        return prodMap;
      default:
        return devMap;
    }
  }
}
