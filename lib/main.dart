import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kettotask/bloc/overlays/bloc.dart';
import 'package:kettotask/ui/feed/feed_home.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(KettoApp());
}

class KettoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OverLayBloc>(
          create: (context) => OverLayBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'HealthNest',
        debugShowCheckedModeBanner: false,
        navigatorKey: Get.key,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.white,
        )),
        home: FeedHome(),
        builder: (context, child) {
          return ResponsiveWrapper(
              shrinkWrap: true,
              maxWidth: 500,
              mediaQueryData: MediaQuery.of(context),
              minWidth: 400,
              breakpoints: [],
              child: child);
        },
      ),
    );
  }
}
