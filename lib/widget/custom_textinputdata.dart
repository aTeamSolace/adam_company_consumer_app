import 'package:adam_company_consumer_app/common/import_clases.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextInputData extends StatelessWidget {
  var hintText;
  var title;
  TextEditingController textEditingController;
  Function formFieldValidator;
  TextInputType textInputType;
  TextCapitalization textCapitalization;
  bool obsecureText;
  bool fill;
  Color filledColor;
  Widget prefix_icon;
  Color enabledborderColor;
  Color borderColor;
  Color input_text_color;
  Color titleColor;
  Color hint_text_color;
  Color error_text_color;
  double content_padding;
  double blurRadius;
  double spreadRadius;
  double left;
  double right;
  final double dy;
  final double dx;
  Widget suffix_icon;
  int maxline;
  int maxlength;
  Function onChanged;

  CustomTextInputData(
      {@required this.title,
      @required this.hintText,
      @required this.textEditingController,
      @required this.formFieldValidator,
      @required this.textInputType,
      @required this.textCapitalization,
      @required this.obsecureText,
      @required this.filledColor,
      @required this.fill,
      this.prefix_icon,
      this.maxlength,
      @required this.enabledborderColor,
      @required this.input_text_color,
      @required this.titleColor,
      @required this.hint_text_color,
      @required this.error_text_color,
      @required this.content_padding,
      @required this.borderColor,
      @required this.spreadRadius,
      @required this.blurRadius,
      @required this.right,
      @required this.left,
      @required this.dx,
      @required this.dy,
      this.suffix_icon,
      this.maxline,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Padding(
        padding: EdgeInsets.only(
          left: left,
          right: right,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(color: titleColor, fontSize: 14),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              child: CustomTextField(
                maxlength: maxlength,
                onChange: () {
                  onChanged();
                },
                maxline: maxline,
                suffix_icon: suffix_icon,
                input_text_color: input_text_color,
                filledColor: filledColor,
                fill: fill,
                prefix_icon: prefix_icon,
                obsecureText: obsecureText,
                textCapitalization: textCapitalization,
                validator: formFieldValidator,
                textEditingController: textEditingController,
                hintText: hintText,
                enabledcolor: enabledborderColor,
                bordercolor: borderColor,
                textInputType: textInputType,
                hint_text_color: hint_text_color,
                error_text_color: error_text_color,
                content_padding: content_padding,
                blurRadius: blurRadius,
                spreadRadius: spreadRadius,
                dx: dx,
                dy: dy,
              ),
//              height: 45,
            )
          ],
        ),
      ),
    );
  }
}
