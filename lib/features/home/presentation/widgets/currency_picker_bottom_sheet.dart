import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_converter/features/home/data/models/currency_model.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_converter/features/home/presentation/cubit/currency_state.dart';

class CurrencyPickerBottomSheet extends StatefulWidget {
  const CurrencyPickerBottomSheet({super.key});

  @override
  State<CurrencyPickerBottomSheet> createState() =>
      _CurrencyPickerBottomSheetState();
}

class _CurrencyPickerBottomSheetState extends State<CurrencyPickerBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<CurrencyModel> _allCurrencies = [];
  List<CurrencyModel> _filteredCurrencies = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearch(String query) {
    setState(() {
      _filteredCurrencies = _allCurrencies
          .where(
            (currency) =>
                currency.name.toLowerCase().contains(query.toLowerCase()) ||
                currency.isoCode.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            controller: _searchController,
            onChanged: _filterSearch,
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<CurrencyCubit, CurrencyState>(
              builder: (context, state) {
                if (state is CurrencyListLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                }
                if (state is CurrencyListSuccess) {
                  if (_allCurrencies.isEmpty &&
                      _searchController.text.isEmpty) {
                    _allCurrencies = state.currencies;
                    _filteredCurrencies = _allCurrencies;
                  }
                  return ListView.builder(
                    itemCount: _filteredCurrencies.length,
                    itemBuilder: (context, index) {
                      final currency = _filteredCurrencies[index];
                      return ListTile(
                        title: Text(
                          currency.isoCode,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                        subtitle: Text(
                          currency.name,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        onTap: () => Navigator.pop(context, currency),
                      );
                    },
                  );
                }
                return const Center(child: Text("Failed to load options."));
              },
            ),
          ),
        ],
      ),
    );
  }
}
