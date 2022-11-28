import 'package:flutter/material.dart';

class TextInputField extends StatefulWidget {
  const TextInputField({
    Key? key,
    this.validator,
    this.inputFormatters,
    required this.hintText,
    required this.validatorText,
    this.textEditingController,
    this.leadingIcon,
    this.readonly = false,
    this.isInputPassword = false,
  }) : super(key: key);

  final dynamic validator;
  final TextEditingController? textEditingController;
  final String hintText;
  final String validatorText;
  final Widget? leadingIcon;
  final bool isInputPassword;
  final bool readonly;
  final dynamic inputFormatters;

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isInputPassword;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: TextFormField(
          readOnly: widget.readonly,
          cursorColor: const Color(0xFF327C04),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 5, right: 5),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF327C04)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF327C04)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            hintStyle: const TextStyle(color: Color(0x80000000), fontSize: 14),
            hintText: widget.hintText,
            prefixIcon: widget.leadingIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: widget.leadingIcon!,
                  ),
            suffixIcon: widget.isInputPassword
                ? IconButton(
                    onPressed: () => setState(() => obscureText = !obscureText),
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  )
                : null,
          ),
          validator: widget.validator,
          inputFormatters: widget.inputFormatters),
    );
  }
}
