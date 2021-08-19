import 'package:flutter/material.dart';
import 'package:myads_app/Constants/colors.dart';
import 'package:myads_app/Constants/dimens.dart';
import 'package:myads_app/Constants/styles.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key key,
      this.labelText,
      this.isPwdType = false,
      this.controller,
      this.errorText,
      this.suffixImage,
      this.maxLines = 1,
      this.minLines = 1,
      this.prefix,
      this.isEnabled = true,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType = TextInputType.text,
      this.inputFormatter,
      this.inputAction = TextInputAction.go,
      this.focusNode,
      this.onChange,
      this.onFieldSubmit,
      this.prefixImage,
      this.helperText,
      this.validator,
      this.onSave,
      this.onClick,
      this.iconButton});

  final String labelText;
  final String prefix;
  final bool isPwdType;
  final String errorText;
  final bool isEnabled;
  final String suffixImage;
  final String prefixImage;
  final String helperText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int maxLines;
  final int minLines;
  final inputFormatter;
  final textCapitalization;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final void Function(String) onChange;
  final void Function(String) onFieldSubmit;
  final void Function(String) validator;
  final void Function(String) onSave;
  final VoidCallback onClick;
  final IconButton iconButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              labelText,
              style: MyStyles.robotoMedium16.copyWith(
                  letterSpacing: Dimens.letterSpacing_14,
                  color: MyColors.primaryLightColor,
                  fontWeight: FontWeight.w100),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              // height: 50.0,
              width: 300.0,
              child: TextFormField(
                controller: controller,
                obscureText: isPwdType,
                inputFormatters: inputFormatter,
                keyboardType: keyboardType,
                enabled: isEnabled,
                textCapitalization: textCapitalization,
                maxLines: maxLines,
                minLines: minLines,
                textInputAction: inputAction,
                focusNode: focusNode,
                onChanged: onChange,
                validator: validator,
                onSaved: onSave,
                onTap: onClick,
                onFieldSubmitted: onFieldSubmit,
                decoration: InputDecoration(
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  fillColor: MyColors.colorLight,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                    // fillColor: Color(0xfff3f3f4),
                    // filled: true
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors.textColor1b1c20,
                    ),),
                  suffixIcon: iconButton,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
    );
  }
}
