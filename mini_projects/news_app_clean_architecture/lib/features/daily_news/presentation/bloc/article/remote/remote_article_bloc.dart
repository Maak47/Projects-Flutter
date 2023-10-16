import 'package:bloc/bloc.dart';
import 'package:news_app_clean_architecture/core/resources/data_state.dart';

import '../../../../domain/usecases/get_article.dart';
import 'remote_article_event.dart';
import 'remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase) : super(RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      print(dataState.exception!.message);
      emit(RemoteArticlesError(dataState.exception!));
    }
  }
}
