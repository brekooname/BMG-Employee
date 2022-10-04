import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../translations/locale_keys.g.dart';
import '../../../../config/locale/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/reloading_widget.dart';
import '../cubit/random_quote_cubit.dart';
import 'package:project_template/src/core/widgets/error_widget.dart' as errorwidget;

import '../widgets/quote_content.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late final AppLocalizations appLocalizations;

  _getRandomQuote() {
    BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
      builder: ((context, state) {
        if (state is RandomQuoteIsLoading) {
          return const ReloadingWidget();
        } else if (state is RandomQuoteFailure) {
          return errorwidget.ErrorWidget(
            onPressed: () => _getRandomQuote(),
          );
        } else if (state is RandomQuoteIsLoaded) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuoteContent(
                  quote: state.quote,
                ),
                InkWell(
                  onTap: () => _getRandomQuote(),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: const Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const ReloadingWidget();
        }
      }),
    );
  }

  

  @override
  void initState() {
    _getRandomQuote();
    appLocalizations=AppLocalizations(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      leading: IconButton(
        icon:const Icon(
          Icons.translate_outlined,
        ),
        onPressed: () async{
          if (appLocalizations.isEnLocale()){
            await appLocalizations.toArabic();
          } else {
            await appLocalizations.toEnglish();
          }
        },
      ),
      title: Text(AppLocalizations.translate(LocaleKeys.appName)),
      // centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: RefreshIndicator(
        onRefresh: () => _getRandomQuote(),
        child: _buildBodyContent(),
      ),
    );
  }
}
