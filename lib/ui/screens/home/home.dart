import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_view.dart';
import 'cubit/quote_cubit.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuoteCubit()..fetchQuote(),
      child: const HomeView(),
    );
  }
}


