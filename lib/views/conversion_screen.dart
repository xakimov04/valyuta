import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  final Map<String, dynamic> currency;

  const ConversionScreen({super.key, required this.currency});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final _amountController = TextEditingController();
  double? _convertedAmount;

  void _convertCurrency() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null) {
      setState(() {
        _convertedAmount = amount * double.parse(widget.currency['Rate']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert ${widget.currency['CcyNm_UZ']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter amount in UZS',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _convertCurrency,
                child: const Text('Convert'),
              ),
            ),
            const SizedBox(height: 20),
            if (_convertedAmount != null)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  key: ValueKey<double>(_convertedAmount!),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Converted Amount: $_convertedAmount ${widget.currency['Ccy']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Hero(
                  tag: 'currency_${widget.currency['Ccy']}',
                  child: CircleAvatar(
                    radius: 50,
                    child: Text(
                      widget.currency['Ccy'][0],
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
