import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_template/src/core/utils/app_colors.dart';
import 'package:project_template/src/core/utils/app_dialogs.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/main_screen_padding.dart';
import '../../../login/presentation/cubit/login_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int get currentIndex {
    return _currentIndex < 0 ? 0 : _currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.appName,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          centerTitle: true,
          leading: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LogoutSuccess) {
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
              } else if (state is LogoutFailure) {
                AppDialogs.appSnackBar(context: context, text: state.message);
              }
            },
            child: IconButton(
              onPressed: () async {
                await BlocProvider.of<LoginCubit>(context).logout();
              },
              icon: const Icon(Icons.logout),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.black,
          showUnselectedLabels: true,
          items: mainScreens
              .map((mainScreen) => BottomNavigationBarItem(
                    label: mainScreen.screenName,
                    icon: Icon(mainScreen.icon),
                  ))
              .toList(),
          onTap: (newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          },
        ),
        body: IndexedStack(
          index: currentIndex,
          children: mainScreens.map((e) => e.screen).toList(),
        ));
  }
}
