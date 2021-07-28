import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';

class CheckDistributionError extends StatelessWidget {
  final String? error;
  const CheckDistributionError({
    Key? key,
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(error ?? ''),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<CheckDistributionBloc>(context)
                .add(LoadCheckDistribution(
              lat: '-6.9508648',
              long: '107.6363893',
              id: 'aaa',
            ));
          },
          child: Text('Load Data'),
        )
      ],
    );
  }
}
