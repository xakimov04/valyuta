import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency_bloc.dart';
import '../bloc/currency_state.dart';
import 'conversion_screen.dart';

class CurrencyListScreen extends StatelessWidget {
  const CurrencyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildContent(state),
          );
        },
      ),
    );
  }

  Widget _buildContent(CurrencyState state) {
    if (state is CurrencyInitial || state is CurrencyLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CurrencyLoaded) {
      return ListView.builder(
        key: const ValueKey('list_view'),
        itemCount: state.currencies.length,
        itemBuilder: (context, index) {
          final currency = state.currencies[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            elevation: 5,
            child: ListTile(
              leading: Hero(
                tag: 'currency_${currency['Ccy']}',
                child: CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Text(
                    currency['Ccy'][0],
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              title: Text(
                currency['CcyNm_UZ'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Rate: ${currency['Rate']}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversionScreen(currency: currency),
                  ),
                );
              },
            ),
          );
        },
      );
    } else if (state is CurrencyError) {
      return const Center(child: Text('Failed to load currencies'));
    }
    return Container();
  }
}
