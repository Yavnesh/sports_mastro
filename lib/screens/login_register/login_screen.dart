import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_gurukul/controllers/auth/auth_controller.dart';
import 'package:sports_gurukul/screens/login_register/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 100.0),
            Stack(
              children: <Widget>[
                Positioned(
                  left: 20.0,
                  top: 15.0,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    width: 70.0,
                    height: 20.0,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 32.0),
                  child: Text(
                    "Sign In",
                    style:
                    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    labelText: "Email", floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 32, vertical: 8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    labelText: "Password", floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
            ),
            Container(
                padding: const EdgeInsets.only(right: 16.0),
                alignment: Alignment.centerRight,
                child: const Text("Forgot your password?")),
            const SizedBox(height: 120.0),
            Align(
              alignment: Alignment.centerRight,
              child: RaisedButton(
                padding: const EdgeInsets.fromLTRB(40.0, 16.0, 30.0, 16.0),
                color: Colors.yellow,
                elevation: 0,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0))),
                onPressed: () async {
                   AuthController().signIn(_emailController.text.trim(), _passwordController.text.trim());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Sign In".toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    const SizedBox(width: 40.0),
                    const Icon(
                      Icons.arrow_forward,
                      size: 18.0,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            const Center(child: Text("Don't have an account?", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10.0),
            const Center(child: Text("Create one", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30.0,
                  ),
                  // color: Colors.red,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.red),
                  ),
                  highlightColor: Colors.red,
                  textColor: Colors.red,
                  onPressed: () {
                    Get.to(const RegisterScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.g_mobiledata,
                        size: 18.0,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "Google".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40.0),
                RaisedButton(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 30.0,
                  ),
                  // color: Colors.indigo,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: const BorderSide(color: Colors.indigo),
                  ),
                  highlightColor: Colors.indigo,
                  textColor: Colors.indigo,
                  onPressed: () {
                    Get.to(const RegisterScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.facebook,
                        size: 18.0,
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        "Facebook".toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                // OutlineButton.icon(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 8.0,
                //     horizontal: 30.0,
                //   ),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20.0)),
                //   borderSide: BorderSide(color: Colors.red),
                //   color: Colors.red,
                //   highlightedBorderColor: Colors.red,
                //   textColor: Colors.red,
                //   icon: Icon(
                //     FontAwesomeIcons.googlePlusG,
                //     size: 18.0,
                //   ),
                //   label: Text("Google"),
                //   onPressed: () {},
                // ),
                // const SizedBox(width: 10.0),
                // OutlineButton.icon(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 8.0,
                //     horizontal: 30.0,
                //   ),
                //   shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(20.0)),
                //   highlightedBorderColor: Colors.indigo,
                //   borderSide: BorderSide(color: Colors.indigo),
                //   color: Colors.indigo,
                //   textColor: Colors.indigo,
                //   icon: Icon(
                //     FontAwesomeIcons.facebookF,
                //     size: 18.0,
                //   ),
                //   label: Text("Facebook"),
                //   onPressed: () {},
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
