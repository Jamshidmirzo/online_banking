import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_banking/blocs/card/card_event.dart';
import 'package:online_banking/blocs/card/card_state.dart';
import 'package:online_banking/data/models/card.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Card> _cards = [];

  CardBloc() : super(CardInitial()) {
    on<AddCard>(_onAddCard);
    on<LoadCards>(_onLoadCards);
  }

  Future<void> _onAddCard(AddCard event, Emitter<CardState> emit) async {
    emit(CardLoading());
    try {
      await _firestore.collection('cards').add({
        'id': event.id,
        'fullname': event.fullname,
        'expireDate': event.expireDate,
        'number': event.number,
        'balance': event.balance,
      });
      add(LoadCards());
    } catch (e) {
      emit(
        CardError(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onLoadCards(LoadCards event, Emitter<CardState> emit) async {
    emit(CardLoading());
    try {
      final querySnapshot = await _firestore.collection('cards').get();
      _cards = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Card(
          id: doc.id, // Use Firestore document ID
          fullname: data['fullname'],
          expireDate: data['expireDate'],
          number: data['number'], // Updated to String
          balance: data['balance'],
        );
      }).toList();
      emit(CardLoaded(cards: _cards));
    } catch (e) {
      emit(CardError(error: e.toString()));
    }
  }
}
