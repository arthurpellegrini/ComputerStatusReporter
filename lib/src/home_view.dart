import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'custom_items/custom_toast.dart';
import 'custom_items/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  void _showSuccessToast(BuildContext context) {
    CustomToast.show(
      context,
      AppLocalizations.of(context)!.reportSuccess,
      Icons.check_circle,
      Colors.green,
    );
  }

  void _showErrorToast(BuildContext context) {
    CustomToast.show(
      context,
      AppLocalizations.of(context)!.reportTransmissionFailed,
      Icons.error,
      Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.appTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: constraints.maxWidth * 0.8, // 80% of the screen width
                  child: Column(
                    children: [
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/report');
                        },
                        icon: Icons.report,
                        label: AppLocalizations.of(context)!.report,
                        backgroundColor: Colors.blue,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/view');
                        },
                        icon: Icons.visibility,
                        label: AppLocalizations.of(context)!.view,
                        backgroundColor: Colors.teal,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/scanQR');
                        },
                        icon: Icons.qr_code_scanner,
                        label: AppLocalizations.of(context)!.scanQR,
                        backgroundColor: Colors.purple,
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        onPressed: () {
                          _showSuccessToast(context);
                          _showErrorToast(context);
                        },
                        icon: Icons.bug_report,
                        label: "TODO: Remove Test Toasts Button",
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                const Spacer(), // Pushes the copyright text to the bottom
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppLocalizations.of(context)!.appCopyRights,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
