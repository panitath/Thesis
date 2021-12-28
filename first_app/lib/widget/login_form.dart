import 'package:flutter/material.dart';

class LogInForm extends StatefulWidget {
  final TextEditingController email;
  final TextEditingController password;

  const LogInForm(this.email, this.password);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  late bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('อีเมล์', false, widget.email),
        buildInputForm('รหัสผ่าน', true, widget.password)
      ],
    );
  }

  Padding buildInputForm(
      String label, bool pass, TextEditingController controllerName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controllerName,
        keyboardType: pass ? null : TextInputType.emailAddress,
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          suffixIcon: pass
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
