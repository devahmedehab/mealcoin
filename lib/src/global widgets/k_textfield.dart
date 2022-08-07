import 'package:flutter/material.dart';

import 'package:chefsandmeals_customer/src/style/k_color.dart';
import 'package:chefsandmeals_customer/src/style/k_size.dart';

class KTextField extends StatefulWidget {
  final String? hintText;
  final bool isPasswordField;
  final TextEditingController? controller;
  final TextInputType? type;

  const KTextField({
    Key? key,
    this.hintText,
    this.isPasswordField = false,
    this.controller,
    this.type,
  }) : super(key: key);

  @override
  _KTextFieldState createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: KSize.getHeight(context, 54),
      decoration: BoxDecoration(
          color: KColor.white, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: TextField(
          keyboardType: widget.type,
          controller: widget.controller,
          obscureText: _obscureText,
          textAlignVertical:
              widget.isPasswordField ? TextAlignVertical.center : null,
          decoration: InputDecoration(
              suffixIcon: widget.isPasswordField
                  ? InkWell(
                      onTap: () {
                        _toggle();
                      },
                      child: _obscureText
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KSize.getWidth(context, 14),
                                  vertical: KSize.getHeight(context, 14)),
                              child: Image.asset(
                                'assets/images/eye.png',
                                height: KSize.getHeight(context, 13),
                                width: KSize.getWidth(context, 16.37),
                                scale: 1.5,
                                fit: BoxFit.scaleDown,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: KSize.getWidth(context, 14),
                                  vertical: KSize.getHeight(context, 14)),
                              child: Image.asset(
                                'assets/images/eye2.png',
                                height: KSize.getHeight(context, 13),
                                width: KSize.getWidth(context, 16.37),
                                fit: BoxFit.scaleDown,
                                scale: 1.5,
                              ),
                            ))
                  : null,
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: 'Poppins',
              )),
        ),
      ),
    );
  }
}
