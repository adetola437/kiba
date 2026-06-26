import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
 
import '../../../../core/theme/app_text_styles.dart';
 
class RegistrationInputField extends StatefulWidget {
  const RegistrationInputField({
    super.key,
    required this.label,
    required this.controller,
    this.hint = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixWidget,
    this.helperText,
    this.textInputAction = TextInputAction.next,
    this.optional = false,
    this.validatorType,
    this.customValidator,
  });
 
  final String label;
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixWidget;
  final String? helperText;
  final TextInputAction textInputAction;
  final bool optional;
  final ValidatorType? validatorType;
  final String? Function(String?)? customValidator;
 
  @override
  State<RegistrationInputField> createState() => _RegistrationInputFieldState();
}
 
enum ValidatorType { email, password, phone, name }
 
class _RegistrationInputFieldState extends State<RegistrationInputField> {
  String? _errorMessage;
  late FocusNode _focusNode;
 
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onBlur);
  }
 
  @override
  void dispose() {
    _focusNode.removeListener(_onBlur);
    _focusNode.dispose();
    super.dispose();
  }
 
  void _onBlur() {
    if (!_focusNode.hasFocus) _validate();
  }
 
  String? _getValidator() {
    if (widget.customValidator != null) {
      return widget.customValidator!(widget.controller.text);
    }
 
    switch (widget.validatorType) {
      case ValidatorType.email:
        return ValidationBuilder(optional: widget.optional)
            .email('Enter a valid email address')
            .build()(widget.controller.text);
      case ValidatorType.password:
        return ValidationBuilder(optional: widget.optional)
            .minLength(8)
            .build()(widget.controller.text);
      case ValidatorType.phone:
        return ValidationBuilder(optional: widget.optional)
            .phone('Enter a valid phone number')
            .build()(widget.controller.text);
      case ValidatorType.name:
        return ValidationBuilder(optional: widget.optional)
            .minLength(2, 'Name must be at least 2 characters')
            .build()(widget.controller.text);
      default:
        return ValidationBuilder(optional: widget.optional)
            .build()(widget.controller.text);
    }
  }
 
  void _validate() {
    _errorMessage = _getValidator();
    if (mounted) setState(() {});
  }
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = _errorMessage != null && _errorMessage!.isNotEmpty;
    final hasContent = widget.controller.text.isNotEmpty;
 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ──────────────────────────────────────────────────────────
        Row(
          children: [
            Text(
              widget.label,
              style: AppTextStyles.labelMedium.copyWith(
                color: colorScheme.onSurfaceVariant,
                letterSpacing: 0.4,
              ),
            ),
            if (widget.optional) ...[
              SizedBox(width: 4.w),
              Text(
                '(optional)',
                style: AppTextStyles.labelSmall.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                ),
              ),
            ],
          ],
        ),
 
        SizedBox(height: 8.h),
 
        // ── Input container ────────────────────────────────────────────────
        Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: hasError
                  ? colorScheme.error.withOpacity(0.5)
                  : hasContent
                      ? colorScheme.primary.withOpacity(0.35)
                      : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              if (widget.prefixWidget != null) widget.prefixWidget!,
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  keyboardType: widget.keyboardType,
                  obscureText: widget.obscureText,
                  textInputAction: widget.textInputAction,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    hintStyle: AppTextStyles.bodyMedium.copyWith(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: REdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    suffixIcon: widget.suffixIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
 
        // ── Error message ──────────────────────────────────────────────────
        if (hasError) ...[
          SizedBox(height: 6.h),
          Text(
            _errorMessage!,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.error,
            ),
          ),
        ],
 
        // ── Helper text ────────────────────────────────────────────────────
        if (widget.helperText != null && !hasError) ...[
          SizedBox(height: 6.h),
          Text(
            widget.helperText!,
            style: AppTextStyles.bodySmall.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ),
        ],
      ],
    );
  }
}