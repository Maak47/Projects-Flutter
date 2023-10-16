import 'package:news_app_clean_architecture/features/daily_news/domain/entities/article.dart';

import '../../../../core/resources/data_state.dart';

abstract class ArticleRepository {
  //Api Methods
  Future<DataState<List<ArticleEntity>>> getNewsArticles();

  //Database Methods
  Future<List<ArticleEntity>> getSavedArticles();
  Future<void> saveArticle(ArticleEntity article);
  Future<void> removeArticle(ArticleEntity article);
}
