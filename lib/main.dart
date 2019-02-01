import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './config.dart' as config;
import './pages/login_page.dart';
import './pages/main_page.dart';
import './pages/edit_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String _apikey;

  void changeApikey(String toSavedKey) {
    setState(() {
      _apikey = toSavedKey;
    });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Client> client = ValueNotifier(
      Client(
        endPoint: '${config.endPoint}',
        cache: InMemoryCache(),
        apiToken: _apikey
      ),
    );

    return GraphqlProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          // debugShowMaterialGrid: true,
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.red,
            accentColor: Colors.redAccent,
            buttonColor: Colors.white70,
          ),
          // home: AuthPage(),
          routes: {
            '/': (BuildContext context) => LoginPage(changeApikey),
            '/main': (BuildContext context) => MainPage(_apikey),
            '/edit': (BuildContext context) => EditPage(_apikey),
          },
        ),
      ),
    );
  }
}
