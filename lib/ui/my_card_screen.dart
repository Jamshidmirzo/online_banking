import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_banking/blocs/card/card_bloc.dart';
import 'package:online_banking/blocs/card/card_event.dart';
import 'package:online_banking/blocs/card/card_state.dart';

class MyCardScreen extends StatelessWidget {
  MyCardScreen({super.key});

  final fullnameController = TextEditingController();
  final dateController = TextEditingController();
  final balanceController = TextEditingController();
  final numberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<CardBloc>(context).add(AddCard(
        id: '', // Generate a unique ID if necessary
        fullname: fullnameController.text,
        expireDate: int.parse(dateController.text),
        number: numberController.text, // Updated to String
        balance: int.parse(balanceController.text),
      ));
      Navigator.pop(context);
    }
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () => submit(context),
              child: Text("Done"),
            ),
          ],
          content: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: fullnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input your name please';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Input your fullname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: numberController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input your card number please';
                      }
                      if (value.length < 16) {
                        return 'Please enter at least 16 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Input your card number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: dateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input your date please';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Input your date',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: balanceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input your balance please';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Input your balance',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber.shade100,
        onPressed: () => openDialog(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber.shade100,
        title: const Text("Novvot bank 🍬"),
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CardLoaded) {
            return ListView.builder(
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                final card = state.cards[index];
                return Card(
                  child: ListTile(
                    title: Text(card.fullname),
                    subtitle: Text(
                        'Number: ${card.number} | Balance: ${card.balance}'),
                  ),
                );
              },
            );
          } else if (state is CardError) {
            return Center(child: Text('Error: ${state.error}'));
          } else {
            return const Center(child: Text('No cards available.'));
          }
        },
      ),
    );
  }
}
