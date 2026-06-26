part of '../controllers/kyc_tier2_controller.dart';

abstract class KycTier2ControllerContract {
  AccountType get accountType;

  // Fields
  TextEditingController get addressController;
  TextEditingController get bvnController;

  bool get bvnObscured;
  bool get dismissedWarning;
  bool get isLoading;
  bool get isIndividual;

  List<DocUploadState> get individualDocs;
  List<DocUploadState> get corporateDocs;

  bool get canSubmit;

  // Actions
  void onToggleBvnObscured();
  void onDismissWarning();
  void onSimulateUpload(DocUploadState doc);
  void onRemoveDoc(DocUploadState doc);
  Future<void> onSubmit();
  void onBack();
}

abstract class KycTier2ViewContract extends BaseViewContract {
  Widget build(BuildContext context);
}
