import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_quote_generator/data/api_manager.dart';
import 'package:random_quote_generator/data/model/quote_generate_model.dart';

class QuoteCubit extends Cubit<QuoteState> {

  QuoteCubit() : super(QuoteInitial());

  Future<void> fetchQuote() async {
    emit(QuoteLoadInProgress());
    try {
      final quote = await ApiManager.fetchRandomQuote();
      emit(QuoteLoadSuccess(quote));
    } catch (_) {
      emit(QuoteLoadFailure());
    }
  }
}

abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoadInProgress extends QuoteState {}

class QuoteLoadSuccess extends QuoteState {
  final QuoteGenerateModel quote;

  QuoteLoadSuccess(this.quote);
}

class QuoteLoadFailure extends QuoteState {}
