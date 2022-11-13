import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_template/src/injector_container.dart' as di;
import 'app.dart';
import 'firebase_options.dart';
import 'src/bloc_observer.dart';
import 'src/config/locale/app_localizations_setup.dart';
import 'src/core/constant/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  if (Constant.isWindows()) {
    setWindowSize();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  Firestore.initialize(
    dotenv.env["FIREBASE_PROJECT_ID"]!,
  );
  AppLocalizationsSetup.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
      () => runApp(AppLocalizationsSetup.initLocalization(
            app: const MyApp(),
          )),
      blocObserver: AppBlocObserver());
}

setWindowSize() async {
  await DesktopWindow.setMinWindowSize(minSize);
  await DesktopWindow.setWindowSize(minSize);
  await DesktopWindow.setMaxWindowSize(maxSize);
}
