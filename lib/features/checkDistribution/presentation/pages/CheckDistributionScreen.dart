import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/bloc/Bloc.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/widgets/CheckDistributionDisplay.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/widgets/CheckDistributionEmpty.dart';
import 'package:clean_tdd_flutter/features/checkDistribution/presentation/widgets/CheckDistributionError.dart';

import '../../../../injection_container.dart';

class CheckDistributionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckDistributionBloc>(
      create: (_) => sl<CheckDistributionBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cek Distribusi'),
        ),
        body: BlocBuilder<CheckDistributionBloc, CheckdistributionState>(
          builder: (context, state) {
            if (state is CheckdistributionInitial) {
              return CheckDistributionEmpty();
            } else if (state is CheckDistributionLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CheckDistributionFailure) {
              return CheckDistributionError(error: state.error);
            } else if (state is CheckDistributionLoaded) {
              return CheckDistributionDisplay(checkDistributionLoaded: state);
            }
            return Container();
          },
        ),
      ),
    );
  }
}
