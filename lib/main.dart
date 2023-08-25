import 'package:flutter/material.dart';
import 'alphabets_grid.dart';
import 'grid_search.dart';
import 'home_page.dart';
import 'splash_screen.dart';

void main() {
  runApp( const MyApp());
}

final ValueNotifier<Map<String,dynamic>> screens =
ValueNotifier({});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> _splashScreenTimer() async {
    await Future.delayed(const Duration(seconds: 2));

    return true;
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _splashScreenTimer(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return  ValueListenableBuilder(valueListenable: screens,
            builder: (BuildContext context,Map<String,dynamic> value, Widget? child) {


              // print(value['screen_name']=='gridInput');

              if(value['screen_name']=='gridInput'){

               return AlphabetsGrid(rows: value['rows'], columns: value['columns']);

              }else if(value['screen_name']=='gridSearch'){

               return AlphabetsGridSearch(row: value['rows'], column: value['columns'], text: value['inputString']);

              }

              return const HomePage();

            },);
          } else {
            return SplashScreen();
          }
        },
      ),
    );
  }
}


