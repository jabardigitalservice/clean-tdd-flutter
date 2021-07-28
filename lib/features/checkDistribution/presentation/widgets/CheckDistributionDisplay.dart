import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';

class CheckDistributionDisplay extends StatelessWidget {
  final CheckDistributionLoaded? checkDistributionLoaded;

  const CheckDistributionDisplay({
    Key? key,
    @required this.checkDistributionLoaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(checkDistributionLoaded!.record.toJson().toString()),
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
          child: Text('Load Again'),
        )
      ],
    );
  }
}
