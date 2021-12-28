import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpForm extends StatefulWidget {
  final GlobalKey _formKey;
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController cid;
  final TextEditingController phon;
  final TextEditingController password;
  final TextEditingController _Cpassword;

  const SignUpForm(this._formKey, this.firstName, this.lastName, this.email,
      this.cid, this.phon, this.password, this._Cpassword);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget._formKey,
      child: Column(
        children: [
          buildInputForm('เลขรหัสประจำตัวประชาชน', false, widget.cid, "number"),
          buildInputForm('ชื่อ', false, widget.firstName, "text"),
          buildInputForm('นามสกุล', false, widget.lastName, "text"),
          buildInputForm('เบอร์โทรศัพท์', false, widget.phon, "number"),
          buildInputForm('อีเมล์', false, widget.email, "email"),
          buildInputForm('รหัสผ่าน', true, widget.password, "text"),
          buildInputForm('ยืนยันรหัสผ่าน', true, widget._Cpassword, "text"),
        ],
      ),
    );
  }

  buildInputForm(String hint, bool pass, TextEditingController controllerName,
      String _typeInput) {
    return TextFormField(
      controller: controllerName,
      keyboardType:_typeInput == "number" ? TextInputType.number : TextInputType.text,inputFormatters: _typeInput == "number"
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ]
          : null,
      obscureText: pass ? _isObscure : false,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        suffix: pass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                icon: _isObscure
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility))
            : null,
      ),
      validator: (value) {
        if (_typeInput == "text" || _typeInput == "number") {
          if (value == null || value.isEmpty) {
            return 'โปรดกรอกข้อมูลให้ครบถ้วน';
          }
          return null;
        } else if (_typeInput == "email") {
          if (!((value!.contains('@')) && (value.contains('.')))) {
            return 'ตัวอย่าง you@email.com';
          }
          return null;
        }
      },
    );
  }
}