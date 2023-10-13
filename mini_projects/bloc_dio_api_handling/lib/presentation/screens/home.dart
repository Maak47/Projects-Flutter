import 'package:bloc_dio_api_handling/logic/cubits/post_cubit/post_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post_model.dart';
import '../../logic/cubits/post_cubit/post_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Handling'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocConsumer<PostCubit, PostState>(
          listener: (context, state) {
            if (state is PostErrorState) {
              SnackBar snackBar = SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            if (state is PostLoadingState) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is PostLoadedState) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  PostModel post = state.posts[index];
                  return Card(
                      child: ListTile(
                    leading: Text(post.id.toString()),
                    title: Text(post.title.toString()),
                    subtitle: Text(post.body.toString()),
                  ));
                },
              );
            }
            return Center(
              child: Text('An Error Occured!'),
            );
          },
        ),
      ),
    );
  }
}
