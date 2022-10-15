import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'package:flutterminimalweb/pages/pages.dart';
import 'package:flutterminimalweb/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, child!),
        maxWidth: 1200,
        minWidth: 400,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(750, name: TABLET),
          ResponsiveBreakpoint.autoScale(900, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
        background: Container( color:  const Color(0xFFF5F5F5),)
      ),
      initialRoute: Routes.home,
      onGenerateRoute: ((settings) {
        return Routes.fadeThrough(settings, (context){
          switch (settings.name) {
            case Routes.home:
              return const ListPage(); 
            case Routes.post:
              return const PostPage(); 
            case Routes.style:
              return const TypographyPage() ;
            default:
              return const SizedBox.shrink();
          }
        });
      }),
    );
  }
}