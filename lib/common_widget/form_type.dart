import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormTypeDropDownWidget extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final String? value;
  final String? Function(String?)? validator;
  final Function(String?) onChanged;
  const FormTypeDropDownWidget({
    super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,

    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      hint: Text(
        hintText,
        style: TextFontStyle.headLine14c323539InterW400.copyWith(
          color: Color(0xFF71717A).withValues(alpha: 0.7),
        ),
      ),

      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextFontStyle.headLine14c323539InterW400.copyWith(
                  color: Color(0xFF71717A),
                ),
              ),
            ),
          )
          .toList(),

      value: value,
      validator: validator,
      onChanged: onChanged,

      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFFFFFFF),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xFFE4E4E7), width: 1.w),
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Color(0xFFE4E4E7), width: 1.w),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
