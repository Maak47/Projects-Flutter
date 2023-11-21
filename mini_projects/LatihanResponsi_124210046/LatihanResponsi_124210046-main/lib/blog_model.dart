class BlogModel {
  final int? id;
  final String? title;
  final String? url;
  final String? imageUrl;
  final String? newsSite;
  final String? summary;
  final String? publishedAt;
  final String? updatedAt;
  final bool? featured;
  final List<dynamic>? launches;
  final List<dynamic>? events;

  BlogModel({
    this.id,
    this.title,
    this.url,
    this.imageUrl,
    this.newsSite,
    this.summary,
    this.publishedAt,
    this.updatedAt,
    this.featured,
    this.launches,
    this.events,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      imageUrl: json['image_url'] as String?,
      newsSite: json['news_site'] as String?,
      summary: json['summary'] as String?,
      publishedAt: json['published_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      featured: json['featured'] as bool?,
      launches: json['launches'] as List<dynamic>?,
      events: json['events'] as List<dynamic>?,
    );
  }
}
