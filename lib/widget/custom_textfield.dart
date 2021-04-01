import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {this.fieldKey,
      // this.maxLength,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.textEditingController,
      this.textInputType,
      this.bordercolor,
      this.enabledcolor,
      this.textCapitalization,
      this.obsecureText,
      this.filledColor,
      this.fill,
      this.prefix_icon,
      @required this.input_text_color,
      @required this.error_text_color,
      @required this.content_padding,
      @required this.hint_text_color,
      this.suffix_icon,
      @required this.blurRadius,
      @required this.spreadRadius,
      @required this.dx,
      @required this.dy,
      this.maxline,
      this.maxlength,
      this.onChange});

  final Key fieldKey;

  // final int maxLength;
  var hintText;
  var labelText;
  var helperText;
  final FormFieldSetter<String> onSaved;
  final Function validator;
  final Function onChange;
  final ValueChanged<String> onFieldSubmitted;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final Color bordercolor;
  final Color enabledcolor;
  final TextCapitalization textCapitalization;
  final bool obsecureText;
  final Color filledColor;
  final bool fill;
  final Widget prefix_icon;
  final Color input_text_color;
  final Color error_text_color;
  final double content_padding;
  final Color hint_text_color;
  final Widget suffix_icon;
  final double blurRadius;
  final double spreadRadius;
  final double dy;
  final double dx;
  int maxline;
  int maxlength;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: widget.blurRadius,
            spreadRadius: widget.spreadRadius,
            offset: Offset(widget.dx, widget.dy))
      ]),
      child: TextFormField(
        maxLength: widget.maxlength,
        onChanged: (value) {
          widget.onChange();
        },
        obscureText: widget.obsecureText,
        textCapitalization: widget.textCapitalization,
        controller: widget.textEditingController,
        keyboardType: widget.textInputType,
        validator: widget.validator,
        style:
            GoogleFonts.poppins(color: widget.input_text_color, fontSize: 16),
        maxLines: widget.maxline,
        decoration: InputDecoration(
          counterText: "",
          fillColor: widget.filledColor,
          filled: widget.fill,
          prefixIcon: widget.prefix_icon,
          suffixIcon: widget.suffix_icon,
          errorStyle:
              GoogleFonts.poppins(color: widget.error_text_color, fontSize: 14),
          contentPadding: EdgeInsets.all(widget.content_padding),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.bordercolor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.enabledcolor),
          ),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          hintText: widget.hintText,
          hintStyle:
              GoogleFonts.poppins(color: widget.hint_text_color, fontSize: 14),
        ),
      ),
    );
  }
}
