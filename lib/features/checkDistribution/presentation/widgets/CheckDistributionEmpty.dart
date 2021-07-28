import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';

class CheckDistributionEmpty extends StatelessWidget {
  const CheckDistributionEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text('Tidak Ada Data'),
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
