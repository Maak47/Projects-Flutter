import 'package:bloc_dio_api_handling/data/repositories/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/post_model.dart';
import 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(PostLoadingState()) {
    fetchPosts();
  }
  PostRepository postRepository = PostRepository();
  void fetchPosts() async {
    try {
      List<PostModel> posts = await postRepository.fetchPosts();
      emit(PostLoadedState(posts));
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionError) {
        emit(PostErrorState(
            'Can\'t fetch posts. Please Check your Internet connection '));
      } else {
        emit(PostErrorState(ex.type.toString()));
      }
    }
  }
}
