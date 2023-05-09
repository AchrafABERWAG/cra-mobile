import 'package:committer_cra/nav_bar.dart';
import 'package:committer_cra/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget _buildColumnData(String label, var icon,
      TextEditingController controller, TextInputType dataType, bool isPwd) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      height: 60.0,
      child: TextField(
        controller: controller,
        obscureText: isPwd,
        keyboardType: dataType,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            icon,
            color: Colors.black87,
          ),
          hintText: label,
          hintStyle: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          signInWithEmailAndPassword(
              emailController.text, passwordController.text);
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ));
        },
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.only(right: 0.0),
        ),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      height: 100.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async {
          Text('email: ${emailController.text}');
          Text('password: ${passwordController.text}');
          int statusCode = await signInWithEmailAndPassword(
              emailController.text, passwordController.text);
          if (statusCode >= 200 && statusCode <= 299) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyStatefulWidget(
                          title: '',
                        )));
          } else {}
        },
        child: const Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 2,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'User or Password Is Incorrect ',
            style: TextStyle(
              color: Colors.red,
              fontSize: 8.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => const Text('Sign Up Button Pressed'),
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Card(
          child: Stack(
            children: <Widget>[
              const SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/images/committer-rocket.svg",
                        width: 100,
                      ),
                      const SizedBox(height: 10.0),
                      const Text("COMMITTER CRA",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 3,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(height: 50.0),
                      _buildColumnData('Enter your Email', Icons.email,
                          emailController, TextInputType.emailAddress, false),
                      const SizedBox(
                        height: 50.0,
                      ),
                      _buildColumnData('Enter your password', Icons.lock,
                          passwordController, TextInputType.text, true),
                      _buildForgotPasswordBtn(),
                      _buildLoginBtn(),
                      _buildSignupBtn(),
                      _buildErrorMessage(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
