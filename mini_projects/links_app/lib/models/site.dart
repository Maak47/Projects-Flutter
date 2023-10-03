class Site {
  final String name;
  final String imageUrl;
  final String url;
  bool isFavorite;

  Site({
    required this.name,
    required this.imageUrl,
    required this.url,
    this.isFavorite = false,
  });

  static List<Site> recommendedSites = [
    Site(
      name: 'Google',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png',
      url: 'https://www.google.com/', // Replace with the actual URL
      isFavorite: false,
    ),
    Site(
      name: 'Google',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png',
      url: 'https://www.google.com/', // Replace with the actual URL
      isFavorite: false,
    ),
    Site(
      name: 'Google',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png',
      url: 'https://www.google.com/', // Replace with the actual URL
      isFavorite: false,
    ),
    Site(
      name: 'Google',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png',
      url: 'https://www.google.com/', // Replace with the actual URL
      isFavorite: false,
    ),
    Site(
      name: 'Google',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Google_2015_logo.svg/1200px-Google_2015_logo.svg.png',
      url: 'https://www.google.com/', // Replace with the actual URL
      isFavorite: false,
    ),
  ];
}
