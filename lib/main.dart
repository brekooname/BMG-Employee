
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_template/src/injector_container.dart' as di;
import 'app.dart';
import 'src/bloc_observer.dart';
import 'src/config/locale/app_localizations_setup.dart';
import 'src/core/firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions().firebaseOptionsDefault,
  );

  AppLocalizationsSetup.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
      () => runApp(AppLocalizationsSetup.initLocalization(
            app: const MyApp(),
          )),
      blocObserver: AppBlocObserver());
}
