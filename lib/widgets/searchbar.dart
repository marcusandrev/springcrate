import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:springcrate/blocs/get_transactions/get_transactions_bloc.dart';

class Searchbar extends StatelessWidget {
  const Searchbar(
      {super.key,
      required this.borderColor,
      required this.iconColor,
      required this.context});

  final Color borderColor;
  final Color iconColor;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, color: iconColor),
          ),
          _SearchBar()
        ],
      ),
    );
  }
}

class _SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _searchController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Search',
        ),
        onSubmitted: (query) {
          context.read<GetTransactionsBloc>().add(SearchTransactions(query));
        },
      ),
    );
  }
}
