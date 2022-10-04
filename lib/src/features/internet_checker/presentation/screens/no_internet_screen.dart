import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.checkInternet,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
      ),
    );
  }
}
