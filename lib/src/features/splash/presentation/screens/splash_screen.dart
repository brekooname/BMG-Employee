import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_template/src/core/utils/media_query_values.dart';
import '../../../../core/utils/assets_manager.dart';

import '../../../../config/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  _nextTo() =>
      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);

  _startDelay() {
    _timer = Timer(
        const Duration(
          milliseconds: 500,
        ),
        () => _nextTo());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:context.width*.2) ,
                child: Image.asset(ImgAssets.bmgIcon,)),
            ),
          ],
        ),
    );
  }
}
