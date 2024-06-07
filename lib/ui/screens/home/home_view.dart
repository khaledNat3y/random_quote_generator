import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_theme.dart';
import 'cubit/quote_cubit.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Quotes App", style: AppTheme.font20WhiteBold,),
              const Spacer(),
              BlocBuilder<QuoteCubit, QuoteState>(
                builder: (context, state) {
                  if (state is QuoteLoadInProgress) {
                    return const CircularProgressIndicator(
                      color: AppColors.white,
                    );
                  } else if (state is QuoteLoadSuccess) {
                    return Column(
                      children: [
                        Text(
                          state.quote.q!,
                          style: AppTheme.font20WhiteBold,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          state.quote.a!,
                          style: AppTheme.font17WhiteBold,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children:  [
                        Text(".....", style: AppTheme.font20WhiteBold, textAlign: TextAlign.center,),
                        const SizedBox(height: 10,),
                        Text("....", style: AppTheme.font17WhiteBold, textAlign: TextAlign.center,),
                      ],
                    );
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  context.read<QuoteCubit>().fetchQuote();
                },
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: AppColors.white),
                child: Text("Generate", style: AppTheme.font18BlackRegular,),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  final state = context.read<QuoteCubit>().state;
                  if (state is QuoteLoadSuccess) {
                    final quote = '${state.quote.q} - ${state.quote.a}';
                    Share.share(quote);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: AppColors.white,
                ),
                child: Text("Share", style: AppTheme.font18BlackRegular,),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}