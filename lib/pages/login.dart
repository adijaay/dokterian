import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onLogin;
  final Function(String) changeUsername;
  final Function(String) changePassword;
  final String errorName;

  const LoginPage(
      {required this.onLogin,
      Key? key,
      required this.changeUsername,
      required this.changePassword,
      required this.errorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.asset(
                  'assets/images/nexa-icon.png',
                  height: 200,
                  width: 200,
                ),
              ),
              Text(
                'Kesehatan adalah aset berharga',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 24),
              if (errorName != '')
                Text(
                  errorName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              const SizedBox(height: 24),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: (value) => changeUsername(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(10, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)),
                    labelText: 'Username',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/profile.svg',
                        height: 4,
                        width: 4,
                      ),
                    )),
              ),
              const SizedBox(height: 24),
              TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                onChanged: (value) => changePassword(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(10, 0, 0, 0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Password',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/icons/icon-key.svg',
                        height: 4,
                        width: 4,
                      ),
                    )),
              ),
              const SizedBox(height: 100),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff63b4ff),
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                onPressed: onLogin,
                child: Text(
                  'Masuk',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
