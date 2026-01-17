import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../theme/app_gap.dart';

class LabeledDropdown extends StatelessWidget {
  final String? title;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  // Shared style parameters
  final double textSize;
  final Color textColor;
  final FontWeight textWeight;

  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final Color backgroundColor;

  // Hint text style
  final Color hintTextColor;
  final double hintTextSize;
  final FontWeight hintTextWeight;

  // Dropdown item style
  final double itemTextSize;
  final Color itemTextColor;
  final FontWeight itemTextWeight;

  final double height;

  const LabeledDropdown({
    super.key,
    this.title,
    required this.hintText,
    required this.items,
    this.value,
    required this.onChanged,
    this.textSize = 14,
    this.textColor = AppColors.secondaryText,
    this.textWeight = FontWeight.w500,
    this.borderColor = AppColors.secondaryText,
    this.focusedBorderColor = AppColors.secondaryText,
    this.borderRadius = 8,
    this.backgroundColor = Colors.transparent,
    this.hintTextColor = AppColors.secondaryText,
    this.hintTextSize = 14,
    this.hintTextWeight = FontWeight.w400,
    this.itemTextSize = 16,
    this.itemTextColor = Colors.black,
    this.itemTextWeight = FontWeight.w500,
    this.height = 48, // default height
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title!.isNotEmpty) ...[
            Text(
              title!,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: textWeight,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
          ],
          SizedBox(
            height: height,
            child: DropdownButtonFormField<String>(
              initialValue: value,
              isExpanded: true,
              style: TextStyle(
                fontSize: itemTextSize,
                fontWeight: itemTextWeight,
                color: itemTextColor,
              ),
              
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: hintTextSize,
                  color: hintTextColor,
                  fontWeight: hintTextWeight,
                  overflow: TextOverflow.ellipsis,
                ),
                
                filled: true,
                fillColor: backgroundColor,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: (height - textSize) / 2 - 6,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide(color: focusedBorderColor, width: 2),
                ),
              ),
              items: items
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        style: TextStyle(
                          fontSize: itemTextSize,
                          fontWeight: itemTextWeight,
                          color: itemTextColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class LabeledTextField extends StatefulWidget {
  final String? title;
  final String? hintText;

  // Text styles
  final double textSize;
  final Color textColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final double borderRadius;
  final Color backgroundColor;

  // Hint text style
  final Color hintTextColor;
  final double hintTextSize;
  final FontWeight hintTextWeight;

  final double height;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  // Password field
  final bool isPassword;

  // Prefix icon
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final double prefixIconSize;
  final EdgeInsets prefixIconPadding;

  const LabeledTextField({
    super.key,
    this.title,
    this.hintText,
    this.textSize = 18,
    this.textColor = AppColors.white,
    this.borderColor = AppColors.textFieldBorder,
    this.focusedBorderColor = AppColors.white,
    this.borderRadius = 12,
    this.backgroundColor = Colors.transparent,
    this.hintTextColor = AppColors.textFieldTextiHint,
    this.hintTextSize = 18,
    this.hintTextWeight = FontWeight.w400,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.isPassword = false,
    this.height = 48,
    this.prefixIcon,
    this.prefixIconColor = Colors.grey,
    this.prefixIconSize = 28,
    this.prefixIconPadding = const EdgeInsets.symmetric(horizontal: 8),
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null && widget.title!.isNotEmpty) ...[
            Text(
              widget.title!,
              style: TextStyle(
                fontSize: widget.textSize,
                fontWeight: FontWeight.w500,
                color: widget.textColor,
              ),
            ),
            Gap.h8,
          ],
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            maxLines: widget.isPassword ? 1 : widget.maxLines,
            obscureText: widget.isPassword ? _obscureText : false,
            validator: widget.validator,
            onChanged: widget.onChanged,
            style: TextStyle(
              fontSize: widget.textSize,
              color: widget.textColor,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: widget.hintTextSize,
                color: widget.hintTextColor,
                fontWeight: widget.hintTextWeight,
              ),
              filled: true,
              fillColor: widget.backgroundColor,

              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: (widget.height - widget.textSize) / 2.2,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(color: widget.borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide: BorderSide(
                  color: widget.focusedBorderColor,
                  width: 2,
                ),
              ),

              // 👇 Prefix Icon
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                      padding: widget.prefixIconPadding,
                      child: Icon(
                        widget.prefixIcon,
                        color: widget.prefixIconColor,
                        size: widget.prefixIconSize,
                      ),
                    )
                  : null,

              // 👇 Password Toggle
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

// example of uses

// LabeledTextField(
//   title: "Email",
//   hintText: "Enter your email",
//   prefixIcon: Icons.email,
//   prefixIconColor: Colors.blue,
//   prefixIconSize: 22,
// )

// LabeledTextField(
//   title: "Password",
//   hintText: "Enter your password",
//   isPassword: true,
//   prefixIcon: Icons.lock,
//   prefixIconColor: Colors.red,
//   prefixIconSize: 18,
// )
