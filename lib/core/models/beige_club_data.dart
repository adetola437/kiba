// Beige Club — subscribed member data models & mock data

import '../utils/enums.dart';



// ── Models ─────────────────────────────────────────────────────────────────────

class ClubGroup {
  final String id;
  final String groupCode;
  final double monthlyAmount;
  final int totalMembers;
  final int filledSlots;
  final DateTime startDate;
  final DateTime endDate;
  final ClubGroupStatus status;
  final double ratePercent;

  const ClubGroup({
    required this.id,
    required this.groupCode,
    required this.monthlyAmount,
    required this.totalMembers,
    required this.filledSlots,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.ratePercent,
  });

  int get openSlots => totalMembers - filledSlots;
  bool get isFull => openSlots == 0;
}

class ClubMember {
  final int position;       // 1–12, rotation order
  final String label;       // "You" or "Member N"
  final bool isUser;
  final ClubMemberStatus status;
  final DateTime? payoutMonth; // null if not yet paid out

  const ClubMember({
    required this.position,
    required this.label,
    required this.isUser,
    required this.status,
    this.payoutMonth,
  });
}

class ContributionRecord {
  final String id;
  final DateTime date;
  final double amount;
  final ContributionStatus status;
  final int month; // 1–12

  const ContributionRecord({
    required this.id,
    required this.date,
    required this.amount,
    required this.status,
    required this.month,
  });
}

class ActiveClubSubscription {
  final ClubGroup group;
  final int userPosition;           // user's slot number
  final double totalContributed;
  final double accruedInterest;
  final int contributionsMade;      // months paid so far
  final DateTime nextContributionDue;
  final bool isNextContributionDue;
  final List<ClubMember> members;
  final List<ContributionRecord> contributionHistory;

  const ActiveClubSubscription({
    required this.group,
    required this.userPosition,
    required this.totalContributed,
    required this.accruedInterest,
    required this.contributionsMade,
    required this.nextContributionDue,
    required this.isNextContributionDue,
    required this.members,
    required this.contributionHistory,
  });

  double get monthlyAmount => group.monthlyAmount;
  double get targetTotal => group.monthlyAmount * group.totalMembers;
  double get progressPercent => totalContributed / targetTotal;
  DateTime get payoutMonth {
    final start = group.startDate;
    return DateTime(
      start.year + ((start.month + userPosition - 2) ~/ 12),
      ((start.month + userPosition - 2) % 12) + 1,
    );
  }
  int get monthsRemaining =>
      group.totalMembers - contributionsMade;
}

// ── Available groups (mock) ────────────────────────────────────────────────────

final kAvailableGroups = [
  ClubGroup(
    id: 'g1',
    groupCode: 'BGC-2026-01',
    monthlyAmount: 50000,
    totalMembers: 12,
    filledSlots: 12,
    startDate: DateTime(2026, 1, 1),
    endDate: DateTime(2026, 12, 31),
    status: ClubGroupStatus.active,
    ratePercent: 16.0,
  ),
  ClubGroup(
    id: 'g2',
    groupCode: 'BGC-2026-02',
    monthlyAmount: 50000,
    totalMembers: 12,
    filledSlots: 8,
    startDate: DateTime(2026, 2, 1),
    endDate: DateTime(2027, 1, 31),
    status: ClubGroupStatus.open,
    ratePercent: 16.0,
  ),
  ClubGroup(
    id: 'g3',
    groupCode: 'BGC-2026-03',
    monthlyAmount: 100000,
    totalMembers: 12,
    filledSlots: 3,
    startDate: DateTime(2026, 3, 1),
    endDate: DateTime(2027, 2, 28),
    status: ClubGroupStatus.open,
    ratePercent: 16.0,
  ),
  ClubGroup(
    id: 'g4',
    groupCode: 'BGC-2026-04',
    monthlyAmount: 200000,
    totalMembers: 12,
    filledSlots: 0,
    startDate: DateTime(2026, 4, 1),
    endDate: DateTime(2027, 3, 31),
    status: ClubGroupStatus.open,
    ratePercent: 16.0,
  ),
];

// ── User's active subscription (mock) ──────────────────────────────────────────

final kActiveSubscription = ActiveClubSubscription(
  group: kAvailableGroups[0],
  userPosition: 9,
  totalContributed: 250000,
  accruedInterest: 6575.34,
  contributionsMade: 5,
  nextContributionDue: DateTime(2026, 6, 1),
  isNextContributionDue: true,
  members: List.generate(12, (i) {
    final pos = i + 1;
    final isUser = pos == 9;
    final ClubMemberStatus status;
    DateTime? payoutMonth;

    if (pos <= 5) {
      status = ClubMemberStatus.paid;
      payoutMonth = DateTime(2026, pos);
    } else if (pos == 6) {
      status = ClubMemberStatus.pending;
    } else {
      status = ClubMemberStatus.upcoming;
    }

    return ClubMember(
      position: pos,
      label: isUser ? 'You' : 'Member $pos',
      isUser: isUser,
      status: status,
      payoutMonth: payoutMonth,
    );
  }),
  contributionHistory: [
    ContributionRecord(id: 'c5', date: DateTime(2026, 5, 1),
        amount: 50000, status: ContributionStatus.successful, month: 5),
    ContributionRecord(id: 'c4', date: DateTime(2026, 4, 1),
        amount: 50000, status: ContributionStatus.successful, month: 4),
    ContributionRecord(id: 'c3', date: DateTime(2026, 3, 1),
        amount: 50000, status: ContributionStatus.successful, month: 3),
    ContributionRecord(id: 'c2', date: DateTime(2026, 2, 1),
        amount: 50000, status: ContributionStatus.successful, month: 2),
    ContributionRecord(id: 'c1', date: DateTime(2026, 1, 1),
        amount: 50000, status: ContributionStatus.successful, month: 1),
  ],
);