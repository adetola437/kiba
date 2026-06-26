part of '../controllers/kyc_tier2_controller.dart';

class KycTier2View extends StatelessWidget implements KycTier2ViewContract {
  const KycTier2View({super.key, required this.controller});

  final KycTier2ControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final isIndividual = controller.isIndividual;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: controller.onBack,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 22.r,
            color: colorScheme.onSurface,
          ),
        ),
        title: Text(
          'Tier 2 Verification',
          style: textTheme.titleLarge,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.fromLTRB(20, 12, 20, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!controller.dismissedWarning) ...[
              Container(
                padding: REdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: colorScheme.outlineVariant.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Please ensure your documents are clear and all information matches your ID. Processing may take up to 48 hours.',
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.tertiary,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: controller.onDismissWarning,
                      child: Icon(
                        Icons.close,
                        size: 18.r,
                        color: AppColors.charcoalGrey,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18.h),
            ],

            if (isIndividual) ...[
              Text(
                'Personal details',
                style: textTheme.titleSmall,
              ),
              SizedBox(height: 10.h),
              TextFormField(
                controller: controller.addressController,
                decoration: const InputDecoration(
                  labelText: 'Residential address',
                ),
              ),
              SizedBox(height: 12.h),
              TextFormField(
                controller: controller.bvnController,
                obscureText: controller.bvnObscured,
                decoration: InputDecoration(
                  labelText: 'BVN',
                  suffix: GestureDetector(
                    onTap: controller.onToggleBvnObscured,
                    child: Icon(
                      controller.bvnObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      size: 18.r,
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 18.h),
            ],

            Text(
              'Required Documents',
              style: textTheme.titleSmall,
            ),
            SizedBox(height: 10.h),

            // Document upload list
            ...(isIndividual
                    ? controller.individualDocs
                    : controller.corporateDocs)
                .map(
              (d) => Padding(
                padding: REdgeInsets.only(bottom: 12),
                child: KycDocumentUpload(
                  state: d,
                  onUpload: () => controller.onSimulateUpload(d),
                  onRemove: () => controller.onRemoveDoc(d),
                ),
              ),
            ),

            SizedBox(height: 18.h),

            GestureDetector(
              onTap: controller.canSubmit && !controller.isLoading
                  ? controller.onSubmit
                  : null,
              child: Container(
                width: double.infinity,
                height: 48.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.canSubmit
                      ? colorScheme.primary
                      : colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: controller.isLoading
                    ? CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                      )
                    : Text(
                        'Submit for review',
                        style: textTheme.labelMedium?.copyWith(
                          color: controller.canSubmit
                              ? colorScheme.onPrimary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}