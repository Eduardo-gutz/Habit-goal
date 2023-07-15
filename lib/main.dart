import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:habit_goal/src/bloc/hg_bloc.dart';
import 'package:habit_goal/src/components/auth/auth_guard.dart';
import 'package:habit_goal/src/provider/locale_provider.dart';
import 'package:habit_goal/src/screens/auth/login/login.dart';
import 'package:habit_goal/src/screens/auth/signup/signup.dart';
import 'package:habit_goal/src/screens/habits/new_habit/new_habit.dart';
import 'package:habit_goal/src/screens/home/home.dart';
import 'package:habit_goal/src/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        builder: (context, child) {
          final provider = Provider.of<LocaleProvider>(context);
          return HGBlocsProvider(
            child: MaterialApp(
              title: 'Habit Goal',
              locale: provider.locale,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('es'),
              ],
              debugShowCheckedModeBanner: false,
              theme: mainTheme,
              home: const LoginScreen(),
              routes: <String, WidgetBuilder>{
                '/login': (BuildContext context) => const LoginScreen(),
                '/signup': (BuildContext context) => const SignupScreen(),
                '/home': (BuildContext context) => const AuthGuard(
                      child: HomeScreen(),
                    ),
                '/newHabit': (BuildContext context) => const AuthGuard(
                      child: NewHabitScreen(),
                    ),
              },
            ),
          );
        });
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
