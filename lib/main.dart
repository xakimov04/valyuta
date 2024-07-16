import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/currency_bloc.dart';
import 'bloc/currency_event.dart';
import 'bloc/currency_state.dart';
import 'service/currency_service.dart';
import 'views/conversion_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => CurrencyBloc(currencyService: CurrencyService())
          ..add(FetchCurrencies()),
        child: const CurrencyListScreen(),
      ),
    );
  }
}


class CurrencyListScreen extends StatelessWidget {
  const CurrencyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            return ListView.builder(
              itemCount: state.currencies.length,
              itemBuilder: (context, index) {
                final currency = state.currencies[index];
                return ListTile(
                  title: Text(currency['CcyNm_UZ']),
                  subtitle: Text('Rate: ${currency['Rate']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ConversionScreen(currency: currency),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is CurrencyError) {
            return const Center(child: Text('Failed to load currencies'));
          }
          return Container();
        },
      ),
    );
  }
}