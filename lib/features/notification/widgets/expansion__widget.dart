import 'package:artneidich_app/constants/text_font_style.dart';
import 'package:artneidich_app/features/notification/data/rx_get_all/model/all_notification_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExpansionTileWidget extends StatefulWidget {
  final Datum data;
  const ExpansionTileWidget({super.key, required this.data});

  @override
  State<ExpansionTileWidget> createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),

      leading: Icon(Icons.notifications, color: Colors.black, size: 20.sp),

      title: Text(
        widget.data.title ?? "",
        style: TextFontStyle.headLine14c323539InterW400.copyWith(
          color: Colors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      // show subtitle only when expanded
      subtitle: _isExpanded
          ? Text(
              widget.data.body ?? "",
              style: TextStyle(
                color: Color(0xFFB3B3B3),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          : null,

      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
    );
  }
}
