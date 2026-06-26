import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../data/kyc_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/contract.dart';
import '../views/kyc_pending.dart';


part '../contracts/kyc_tier2_contract.dart';
part '../views/kyc_tier2.dart';
part '../widgets/kyc_document_upload.dart';

class KycTier2Screen extends StatefulWidget {
  static const String route = 'kyc_tier2';

  final AccountType accountType;
  const KycTier2Screen({super.key, required this.accountType});

  @override
  State<KycTier2Screen> createState() => _KycTier2ScreenState();
}

class _KycTier2ScreenState extends State<KycTier2Screen>
    implements KycTier2ControllerContract {
  late final KycTier2ViewContract view;
  final _addressController = TextEditingController();
  final _bvnController = TextEditingController();
  bool _bvnObscured = true;
  bool _dismissedWarning = false;
  bool _isLoading = false;

  bool get _isIndividual =>
      widget.accountType == AccountType.individual;

  // Public contract implementations
  @override
  AccountType get accountType => widget.accountType;

  @override
  TextEditingController get addressController => _addressController;

  @override
  TextEditingController get bvnController => _bvnController;

  @override
  bool get bvnObscured => _bvnObscured;

  @override
  bool get dismissedWarning => _dismissedWarning;

  @override
  bool get isLoading => _isLoading;

  @override
  bool get isIndividual => _isIndividual;

  @override
  List<DocUploadState> get individualDocs => _individualDocs;

  @override
  List<DocUploadState> get corporateDocs => _corporateDocs;

  @override
  bool get canSubmit => _canSubmit;

  // Individual docs
  late final List<DocUploadState> _individualDocs = [
    DocUploadState(
      id: 'gov_id',
      label: 'Valid Government Issued ID',
      hint: 'NIN, Passport, or Driver\'s License (Max 5MB)',
      icon: Icons.badge_outlined,
    ),
  ];

  // Corporate docs
  late final List<DocUploadState> _corporateDocs = [
    DocUploadState(
      id: 'cac',
      label: 'CAC Certificate',
      hint: 'Certificate of Incorporation',
      icon: Icons.description_outlined,
    ),
    DocUploadState(
      id: 'board',
      label: 'Board Resolution',
      hint: 'Letter authorizing the account',
      icon: Icons.people_outline_rounded,
    ),
    DocUploadState(
      id: 'address',
      label: 'Proof of Business Address',
      hint: 'Utility bill or Tenancy agreement',
      icon: Icons.location_on_outlined,
    ),
    DocUploadState(
      id: 'signatories',
      label: 'Authorized Signatories',
      hint: 'List of individuals with ID',
      icon: Icons.draw_outlined,
    ),
  ];

  bool get _canSubmit {
    if (_isIndividual) {
      return _addressController.text.isNotEmpty &&
          _bvnController.text.length == 11 &&
          _individualDocs.every((d) => d.isUploaded);
    } else {
      return _corporateDocs.every((d) => d.isUploaded);
    }
  }

  void _onSimulateUpload(DocUploadState doc) async {
    setState(() {
      doc.status = DocUploadStatus.uploading;
      doc.uploadProgress = 0;
    });
    // Simulate progress
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      if (!mounted) return;
      setState(() => doc.uploadProgress = i / 10);
    }
    setState(() {
      doc.status = DocUploadStatus.uploaded;
      doc.fileName = '${doc.id}_document.pdf';
    });
  }

  void _onRemoveDoc(DocUploadState doc) {
    setState(() {
      doc.status = DocUploadStatus.empty;
      doc.fileName = null;
      doc.uploadProgress = 0;
    });
  }

  // Expose actions via the contract
  @override
  void onSimulateUpload(DocUploadState doc) => _onSimulateUpload(doc);

  @override
  void onRemoveDoc(DocUploadState doc) => _onRemoveDoc(doc);

  @override
  Future<void> onSubmit() => _onSubmit();

  @override
  void onToggleBvnObscured() => setState(() => _bvnObscured = !_bvnObscured);

  @override
  void onDismissWarning() => setState(() => _dismissedWarning = true);

  @override
  void onBack() => context.pop();

  Future<void> _onSubmit() async {
    if (!_canSubmit || _isLoading) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    setState(() => _isLoading = false);
    context.goNamed(
      KycPendingScreen.route,
      extra: {'tier': 2},
    );
  }

  @override
  void initState() {
    super.initState();
    // Rebuild view when address or BVN text changes so `canSubmit` is re-evaluated
    _addressController.addListener(_onTextChanged);
    _bvnController.addListener(_onTextChanged);

    view = KycTier2View(controller: this);
  }

  @override
  void dispose() {
    // Remove listeners before disposing controllers
    _addressController.removeListener(_onTextChanged);
    _bvnController.removeListener(_onTextChanged);

    _addressController.dispose();
    _bvnController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    // Trigger a rebuild so the view can pick up changes to `canSubmit`.
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      view.build(context);
}

// class KycPendingScreen { static const String route = 'kyc_pending'; }