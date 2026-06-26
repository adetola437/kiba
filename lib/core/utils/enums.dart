enum InvestorType { individual, corporate }

enum QuickAction { fund, withdraw, invest, history }

enum ProfileMenuRoute {
  referAndEarn,
  promoCodes,
  personalInfo,
  linkedBanks,
  documents,
  kyc,
  notifications,
  biometrics,
  helpCenter,
  contactSupport,
  about,
}

enum InvestCategory { all, savings, fixedIncome, government }

enum TransactionFilter { all, fundings, investments, withdrawals }

enum TransactionStatus { successful, locked, accrued, completed, pending, failed }

enum ContributionMode { manual, autoDebit }

enum ClubGroupStatus { open, active, completed }
 
enum ClubMemberStatus { paid, pending, defaulted, upcoming }
 
enum ContributionStatus { successful, pending, failed }

enum StockSector { technology, finance, energy, consumer, health, telecoms, all }

enum StockOrderType { buy, sell }

enum StockOrderMode { market, limit }