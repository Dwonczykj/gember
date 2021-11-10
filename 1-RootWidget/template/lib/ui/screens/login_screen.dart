import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:template/ui/models/models.dart';
import '../../data/user_dao.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  static MaterialPage page() {
    return MaterialPage(
      name: TemplatePages.loginPath,
      key: ValueKey(TemplatePages.loginPath),
      child: const Login(),
    );
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // 1
  final _emailController = TextEditingController();
  // 2
  final _passwordController = TextEditingController();
  // 3
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // 4
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1
    final userDao = Provider.of<UserDao>(context, listen: false);
    return Scaffold(
      // 2
      appBar: AppBar(
        title: const Text('Gember'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        // 3
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: [
                  const SizedBox(height: 80),
                  Expanded(
                    // 1
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Email Address',
                      ),
                      autofocus: false,
                      // 2
                      keyboardType: TextInputType.emailAddress,
                      // 3
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      // 4
                      controller: _emailController,
                      // 5
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Required';
                        }
                        //
                        var reg = RegExp(
                            r"/^w+[+.w-]*@([w-]+.)*w+[w-]*.([a-z]{2,4}|d+)$/i"); //https://www.formget.com/regular-expression-for-email/
                        if (!reg.hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(), hintText: 'Password'),
                      autofocus: false,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      controller: _passwordController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 1
                        userDao.login(
                            _emailController.text, _passwordController.text);
                      },
                      child: const Text('Login'),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  const SizedBox(height: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // 2
                        userDao.signup(
                            _emailController.text, _passwordController.text);
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../models/models.dart';

// class LoginScreen extends StatelessWidget {
//   static MaterialPage page() {
//     return MaterialPage(
//       name: TemplatePages.loginPath,
//       key: ValueKey(TemplatePages.loginPath),
//       child: const LoginScreen(),
//     );
//   }

//   final String? username;

//   const LoginScreen({
//     Key? key,
//     this.username,
//   }) : super(key: key);

//   final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);
//   final TextStyle focusedStyle = const TextStyle(color: Colors.green);
//   final TextStyle unfocusedStyle = const TextStyle(color: Colors.grey);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 200,
//                 child: Image(
//                   image: AssetImage(
//                     'assets/template_assets/rw_logo.png',
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               buildTextfield(username ?? '🍔 username'),
//               const SizedBox(height: 16),
//               buildTextfield('🎹 password'),
//               const SizedBox(height: 16),
//               buildButton(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildButton(BuildContext context) {
//     return SizedBox(
//       height: 55,
//       child: MaterialButton(
//         color: rwColor,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: const Text(
//           'Login',
//           style: TextStyle(color: Colors.white),
//         ),
//         onPressed: () async {
//           Provider.of<AppStateManager>(context, listen: false)
//               .login('mockUsername', 'mockPassword');
//         },
//       ),
//     );
//   }

//   Widget buildTextfield(String hintText) {
//     return TextField(
//       cursorColor: rwColor,
//       decoration: InputDecoration(
//         border: const OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//             width: 1.0,
//           ),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(
//             color: Colors.green,
//           ),
//         ),
//         hintText: hintText,
//         hintStyle: const TextStyle(height: 0.5),
//       ),
//     );
//   }
// }
