import 'package:equatable/equatable.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class AddCard extends CardEvent {
  final String id;
  final String fullname;
  final int expireDate;
  final String number; 
  final int balance;

  const AddCard({
    required this.id,
    required this.fullname,
    required this.expireDate,
    required this.number, 
    required this.balance,
  });

  @override
  List<Object> get props => [id, fullname, expireDate, number, balance];
}

class LoadCards extends CardEvent {}
