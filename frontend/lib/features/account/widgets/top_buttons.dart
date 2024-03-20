import 'package:flutter/material.dart';
import 'package:frontend/features/account/services/account_service.dart';
import 'package:frontend/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  void _logOut(BuildContext context) {
    AccountService().logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: 'Your Order',
              onTap: () {},
            ),
            AccountButton(
              text: 'Turn Seller',
              onTap: () {},
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            AccountButton(
              text: 'Log Out',
              onTap: () => _logOut(context),
            ),
            AccountButton(
              text: 'Your Wish List',
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
