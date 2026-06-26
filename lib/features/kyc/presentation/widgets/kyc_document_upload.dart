part of '../controllers/kyc_tier2_controller.dart';

class KycDocumentUpload extends StatelessWidget {
  const KycDocumentUpload({
    super.key,
    required this.state,
    required this.onUpload,
    required this.onRemove,
  });

  final DocUploadState state;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              state.icon,
              size: 18.r,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.label,
                  style: textTheme.titleSmall,
                ),
                SizedBox(height: 4.h),
                Text(
                  state.hint,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          if (state.status == DocUploadStatus.empty) ...[
            GestureDetector(
              onTap: onUpload,
              child: Icon(
                Icons.upload_file_outlined,
                color: colorScheme.primary,
              ),
            ),
          ] else if (state.status == DocUploadStatus.uploading) ...[
            SizedBox(
              width: 60.r,
              child: LinearProgressIndicator(
                value: state.uploadProgress,
                color: colorScheme.primary,
                backgroundColor: colorScheme.surfaceVariant,
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.delete_outline,
                color: colorScheme.error,
              ),
            ),
          ]
        ],
      ),
    );
  }
}