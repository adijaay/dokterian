import 'package:dokterian/components/navbar.dart';
import 'package:dokterian/pages/home.dart';
import 'package:dokterian/pages/login.dart';
import 'package:dokterian/pages/schedule.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuthenticated = false;
  String token = '';
  String _usernameInput = '';
  String _passwordInput = '';
  String errorName = '';

  void getToken() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((value) {
      print(value.getString('token'));
      if (value.containsKey('token') && value.getString('token') != null) {
        setState(() {
          token = value.getString('token') ?? '';
          _isAuthenticated = true;
        });
      } else {
        setState(() {
          _isAuthenticated = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void _login() {
    postLogin();
  }

  void _changeUsername(value) {
    setState(() {
      _usernameInput = value;
    });
  }

  void _changePassword(String value) {
    setState(() {
      _passwordInput = value;
    });
  }

  FutureOr<void> postLogin() async {
    try {
      if (_usernameInput == '' || _passwordInput == '') {
        setState(() {
          errorName = 'Username or password cannot be empty';
        });
        return;
      }
      print(json.encode({
        'username': _usernameInput,
        'password': _passwordInput,
      }));
      final response = await http.post(
        Uri.parse('https://nexacaresys.codeplay.id/api/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': _usernameInput,
          'password': _passwordInput,
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _usernameInput = '';
          _passwordInput = '';
        });
        final dynamic dataResponse = json.decode(response.body);
        final tokenData = dataResponse["response"]["token"];
        await saveToken(tokenData);
        setState(() {
          _isAuthenticated = true;
        });
      } else {
        setState(() {
          errorName = json.decode(response.body)["metadata"]["message"];
        });
        print(errorName);
      }
    } catch (e) {
      print(e);
      setState(() {
        errorName = "Something went wrong. Please try again later.";
      });
    }
  }

  FutureOr<void> saveToken(String tokenData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', tokenData);
    setState(() {
      token = tokenData;
    });
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    setState(() {
      _isAuthenticated = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dokterian',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      home: _isAuthenticated
          ? MainPage(token: token, logout: logout)
          : LoginPage(
              onLogin: _login,
              changeUsername: _changeUsername,
              changePassword: _changePassword,
              errorName: errorName,
            ),
      routes: {
        '/main': (context) => MainPage(token: token, logout: logout),
        '/login': (context) => LoginPage(
              onLogin: _login,
              changeUsername: _changeUsername,
              changePassword: _changePassword,
              errorName: errorName,
            ),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  final String token;
  final VoidCallback logout;
  const MainPage({super.key, required this.token, required this.logout});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      HomePage(token: widget.token, logout: widget.logout),
      Schedule(token: widget.token, logout: widget.logout),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dokterian',
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: _widgetOptions[_selectedIndex],
            // body: HomePage(),
            bottomNavigationBar: Navbar(
              currentIndex: _selectedIndex,
              onItemTapped: _onItemTapped,
            )),
      ),
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
    );
  }
}
