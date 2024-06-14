import 'package:computer_status_reporter/model/data_controller.dart';
import 'package:computer_status_reporter/widgets/custom/custom_download_qr_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'custom/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, required this.dataController});

  final DataController dataController;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, '/settings');
          },
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildTitle(context),
              const SizedBox(height: 40),
              _buildButtons(context, constraints.maxWidth),
              const Spacer(),
              _buildFooter(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.appTitle,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildButtons(BuildContext context, double maxWidth) {
    return SizedBox(
      width: maxWidth * 0.8,
      child: Column(
        children: [
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/report');
            },
            icon: Icons.report,
            label: AppLocalizations.of(context)!.report,
            backgroundColor: const Color(0xFF8FCEED),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/view');
            },
            icon: Icons.visibility,
            label: AppLocalizations.of(context)!.view,
            backgroundColor: const Color(0xFFA5B2D7),
          ),
          const SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(context, '/scanQR');
            },
            icon: Icons.qr_code_scanner,
            label: AppLocalizations.of(context)!.scanQR,
            backgroundColor: const Color(0xFF9F61D1),
          ),
          const SizedBox(height: 20),
          CustomDownloadQr(dataController: dataController),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        AppLocalizations.of(context)!.appCopyRights,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.center,
      ),
    );
  }
}
