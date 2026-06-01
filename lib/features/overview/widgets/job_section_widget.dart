import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobSection extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color iconColor;

  const JobSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  State<JobSection> createState() => _JobSectionState();
}

class _JobSectionState extends State<JobSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF7F7F5),
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.1,
            color: Colors.black.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ExpansionTile(
        leading: Icon(widget.icon, color: widget.iconColor),
        title: Text(
          widget.title,
          style: TextFontStyle.headLine16c141414InterW400.copyWith(
            fontSize: 14.sp,
          ),
        ),
        subtitle: _isExpanded && widget.subtitle != null
            ? Text(
                widget.subtitle!,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              )
            : null,
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
      ),
    );
  }
}
