import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownWidget extends StatelessWidget {
  final String hintText;
  final List<String> items;
  final int? value;
  final Function(int?) onChanged;
  final String? Function(int?)? validator;

  const CustomDropDownWidget({
    super.key,
    required this.hintText,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<int>(
      isExpanded: true,
      hint: Text(
        hintText,
        style: TextFontStyle.headLine14c323539InterW400.copyWith(
          color: Color(0xFF71717A).withValues(alpha: 0.7),
        ),
      ),

      items: List.generate(
        items.length,
        (index) => DropdownMenuItem(
          value: index,
          child: Text(
            items[index],
            style: TextFontStyle.headLine14c323539InterW400.copyWith(
              color: Color(0xFF71717A),
            ),
          ),
        ),
      ),

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
