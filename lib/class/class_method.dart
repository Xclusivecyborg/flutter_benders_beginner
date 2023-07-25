void main() {
  final Bank bank = Bank(
      bankName: 'Zenith Bank',
      accountNumber: '2117318425',
      accountBalance: 10,
      accountName: "Hillary");

  bank.getAccountBalance();
  final deposit = bank.deposit(50);
  print(deposit);
  bank.getAccountBalance();
  final withdraw = bank.withdraw(5);
  print(withdraw);
  bank.getAccountBalance();
}

//class bank
class Bank {
  //properties
  final String bankName;
  String accountNumber;
  double accountBalance;
  final String? accountName;

  Bank(
      {required this.bankName,
      required this.accountNumber,
      required this.accountBalance,
      this.accountName});

  // methods
  String withdraw(double amount) {
    accountBalance -= amount;
    return 'you have sucessfully withdraw \$$amount';
  }

  String deposit(double amount) {
    accountBalance += amount;

    return 'you have sucesfully depoisted \$$amount';
  }

  void getAccountBalance() {
    print(
        'Dear $accountName with the account number $accountNumber your account balance is \$ $accountBalance');
  }
}
