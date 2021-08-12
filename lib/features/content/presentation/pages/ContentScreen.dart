import 'package:clean_tdd_flutter/features/content/presentation/bloc/Bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';

class ContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContentBloc>(
      create: (_) => sl<ContentBloc>()..add(LoadContent(page: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Content'),
        ),
        body: BlocBuilder<ContentBloc, ContentState>(
          builder: (context, state) {
            if (state is ContentInitial) {
              return Container();
            } else if (state is ContentLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ContentFailure) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Output'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.error),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Kembali')),
                    ],
                  ),
                ),
              );
            } else if (state is ContentLoaded) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Output'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(state.record.toJson().toString()),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Kembali')),
                    ],
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
