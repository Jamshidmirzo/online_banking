// ignore_for_file: public_member_api_docs, sort_constructors_first

class Card {
  String id;
  String fullname;
  int expireDate;
  String number;
  int balance;
  Card({
    required this.number,
    required this.id,
    required this.fullname,
    required this.expireDate,
    required this.balance,
  });
}
