import 'package:flutter/material.dart';
import 'package:random_quote_generator/data/api_manager.dart';
import 'package:random_quote_generator/data/model/quote_generate_model.dart';
import 'package:random_quote_generator/ui/utils/app_colors.dart';
import 'package:random_quote_generator/ui/utils/app_theme.dart';
import 'package:share/share.dart';  // Import the share package

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool inProgress = false;
  QuoteGenerateModel? quoteGenerateModel;

  @override
  void initState() {
    _fetchQuote();
    super.initState();
  }

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
              Text(
                quoteGenerateModel?.q ?? ".....",
                style: AppTheme.font20WhiteBold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10,),
              Text(quoteGenerateModel?.a?? "....",
                style: AppTheme.font17WhiteBold,
                textAlign: TextAlign.center,),
              const Spacer(),
              inProgress
                  ? const CircularProgressIndicator(
                color: AppColors.white,
              )
                  : ElevatedButton(
                onPressed: _fetchQuote,
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                    backgroundColor: AppColors.white),
                child: Text("Generate", style: AppTheme.font18BlackRegular,),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: _shareQuote,
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  backgroundColor: AppColors.white,
                ),
                child: Text("share", style: AppTheme.font18BlackRegular,),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }

  _fetchQuote() async {
    setState(() {
      inProgress = true;
    });
    try {
      final fetchQuote = await ApiManager.fetchRandomQuote();
      print(fetchQuote.toJson().toString());
      setState(() {
        quoteGenerateModel = fetchQuote;
      });

    } catch (e) {
      debugPrint("Failed to generate quote");
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  _shareQuote() {
    if (quoteGenerateModel != null) {
      final quote = '${quoteGenerateModel!.q} - ${quoteGenerateModel!.a}';
      Share.share(quote);
    }
  }
}
