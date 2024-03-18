import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_textfield.dart';
import 'package:frontend/constants/global_variables.dart';
import 'package:frontend/constants/utils.dart';
import 'package:frontend/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({
    super.key,
    required this.totalAmount,
  });

  final String totalAmount;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _flatBuildingController = TextEditingController();
  final _areaController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();

  var _addressToBeUsed = "";

  final _addressFormKey = GlobalKey<FormState>();

  final List<PaymentItem> _paymentItems = [];

  void _onApplePayResult(res) {}
  void _onGooglePayResult(res) {}

  void _payPressed(String addressFromProvider) {
    _addressToBeUsed = "";

    bool isForm = _flatBuildingController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        _addressToBeUsed =
            "${_flatBuildingController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception('Please enter all the values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      _addressToBeUsed = addressFromProvider;
    } else {
      showSnackbar(context, 'ERROR');
    }
  }

  @override
  void initState() {
    super.initState();
    _paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    // Name input
                    CustomTextfield(
                      controller: _flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),

                    // Email input
                    CustomTextfield(
                      controller: _areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),

                    // Password input
                    CustomTextfield(
                      controller: _pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),

                    // Password input
                    CustomTextfield(
                      controller: _cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              ApplePayButton(
                width: double.infinity,
                height: 50,
                style: ApplePayButtonStyle.whiteOutline,
                type: ApplePayButtonType.buy,
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                  GlobalVariables.defaultApplePay,
                ),
                paymentItems: _paymentItems,
                onPaymentResult: _onApplePayResult,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () => _payPressed(address),
              ),
              const SizedBox(height: 10),
              GooglePayButton(
                paymentConfiguration: PaymentConfiguration.fromJsonString(
                  GlobalVariables.defaultGooglePay,
                ),
                paymentItems: _paymentItems,
                onPaymentResult: _onGooglePayResult,
                width: double.infinity,
                theme: GooglePayButtonTheme.dark,
                type: GooglePayButtonType.buy,
                height: 50,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
                onPressed: () => _payPressed(address),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _flatBuildingController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }
}
