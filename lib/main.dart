import 'package:currency_converter/app.dart';
import 'package:currency_converter/core/helpers/bloc_observer.dart';
import 'package:currency_converter/core/service_locator/dependency_injection.dart';
import 'package:currency_converter/core/services/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupGetIt();
  await SQLHelper.initDB();
  await ScreenUtil.ensureScreenSize();

  Bloc.observer = MyBlocObserver();

  runApp(const App());
}
