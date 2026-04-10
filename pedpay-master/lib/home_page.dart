import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'theme.dart';
import 'chatbot_widget.dart'; // Import for Chatbot

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildHeroSection(context),
          _buildPlatformIntro(),
          _buildUserRoles(),
          _buildHowItWorks(),
          _buildPartners(),
          _buildCTASection(context),
          _buildFooter(),
        ],
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.pastelGreen, AppColors.white],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Harnessing blockchain technology to empower blue carbon initiatives',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.darkerGreen,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          const Text(
            'Transparent, verifiable carbon credit ecosystem for mangrove conservation and restoration projects',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.textLight),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.playCircle),
                label: const Text('EXPLORE'),
              ),
              const SizedBox(width: 10),
              // This button would trigger the chatbot state change
             ElevatedButton.icon(
  onPressed: () {
    // 1. We removed the SnackBar and added showDialog
    showDialog(
      context: context,
      builder: (context) => ChatbotWindow(), // Removed 'const' here
    );
  },
  icon: const Icon(Icons.smart_toy),
  label: const Text('ASK PEDBOT'),
)
            ],
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              'https://picsum.photos/900/400?random=1', // Placeholder for cover_img.png
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformIntro() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.white,
      child: Column(
        children: [
          Text(
            'Meet the blue carbon intelligence platform that streamlines your carbon journey',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: AppColors.darkerGreen),
          ),
          const SizedBox(height: 50),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _FeatureCard(
                icon: FontAwesomeIcons.tree,
                title: 'Register',
                description: 'Easily register mangrove plantations with species, location, and planting date',
              ),
              _FeatureCard(
                icon: FontAwesomeIcons.camera,
                title: 'Monitor',
                description: 'Upload geo-tagged photos and track growth with our AI-powered tools',
              ),
              _FeatureCard(
                icon: FontAwesomeIcons.checkCircle,
                title: 'Verify',
                description: 'Experts validate your data and approve carbon credit issuance',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserRoles() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.white, AppColors.pastelGreen],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Designed for all stakeholders in the carbon ecosystem',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: AppColors.darkerGreen),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _RoleCard(
                icon: FontAwesomeIcons.user,
                title: 'Community/NGO',
                features: ['Sign up & Mobile number verification', 'Upload plantation details', 'Track survival & growth', 'Earn carbon credits'],
              ),
              _RoleCard(
                icon: FontAwesomeIcons.search,
                title: 'Verifier/Admin',
                features: ['Validate uploaded data', 'Approve/reject projects', 'Issue carbon credits'],
              ),
              _RoleCard(
                icon: FontAwesomeIcons.building,
                title: 'Company/Buyer',
                features: ['Browse verified credits', 'Buy tokenized credits', 'Receive offset certificate'],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorks() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      color: AppColors.white,
      child: Column(
        children: [
          Text(
            'How PedPe Works',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: AppColors.darkerGreen),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _StepCard(number: 1, title: 'Register', description: 'Create account and add project details'),
              _StepCard(number: 2, title: 'Upload', description: 'Submit geo-tagged photos and data'),
              _StepCard(number: 3, title: 'Verify', description: 'Experts validate your submission'),
              _StepCard(number: 4, title: 'Tokenize', description: 'Receive carbon credits on blockchain'),
              _StepCard(number: 5, title: 'Monetize', description: 'Sell credits on our marketplace'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartners() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      color: AppColors.pastelGreen,
      child: Column(
        children: [
          Text(
            'Supported by leading organizations',
            style: TextStyle(fontSize: 20, color: AppColors.darkerGreen),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 30,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: const [
              _PartnerLogo(text: 'NCCR'),
              _PartnerLogo(text: 'UNDP'),
              _PartnerLogo(text: 'World Bank'),
              _PartnerLogo(text: 'MetaMask'),
              _PartnerLogo(text: 'WalletConnect'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.darkGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'Ready to join the blue carbon revolution?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: AppColors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          const Text(
            'Start your carbon credit journey today with our easy-to-use platform designed for NGO\'s, verifiers, and buyers alike.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: AppColors.white),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () {
              // Navigate or perform action
            },
            icon: const Icon(FontAwesomeIcons.rocket, color: AppColors.white),
            label: const Text('GET STARTED NOW', style: TextStyle(color: AppColors.white)),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.white),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      color: AppColors.darkerGreen,
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Wrap(
            spacing: 40,
            runSpacing: 30,
            alignment: WrapAlignment.start,
            children: const [
              _FooterColumn(
                title: 'PedPe',
                links: ['About Us', 'Our Mission', 'Careers', 'Contact'],
              ),
              _FooterColumn(
                title: 'Platform',
                links: ["For NGO's", 'For Verifiers', 'For Companies', 'Pricing'],
              ),
              _FooterColumn(
                title: 'Resources',
                links: ['Documentation', 'Blog', 'Guides', 'Webinars'],
              ),
              _FooterColumn(
                title: 'Connect',
                isSocial: true,
                socialIcons: [FontAwesomeIcons.twitter, FontAwesomeIcons.linkedin, FontAwesomeIcons.facebook, FontAwesomeIcons.instagram],
                socialLabels: ['Twitter', 'LinkedIn', 'Facebook', 'Instagram'],
              ),
            ],
          ),
          const Divider(color: Colors.white10, height: 40),
          const Text(
            'Copyright © 2025 PedPe, Inc. All rights reserved.',
            style: TextStyle(color: Color(0xFFA5D6A7), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

// --- Reusable Home Page Widgets ---

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureCard({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.primaryGreen, width: 4),
      ),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, size: 30, color: AppColors.darkerGreen),
            ),
            const SizedBox(height: 20),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
            const SizedBox(height: 10),
            Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.textLight)),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<String> features;

  const _RoleCard({required this.icon, required this.title, required this.features});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.primaryGreen, width: 4),
      ),
      child: Container(
        width: 350,
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.darkerGreen),
                const SizedBox(width: 10),
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
              ],
            ),
            const SizedBox(height: 20),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    children: [
                      const Icon(FontAwesomeIcons.check, size: 14, color: AppColors.primaryGreen),
                      const SizedBox(width: 10),
                      Flexible(child: Text(f, style: const TextStyle(color: AppColors.textDark))),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int number;
  final String title;
  final String description;

  const _StepCard({required this.number, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.pastelGreen,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        border: const Border(top: BorderSide(color: AppColors.primaryGreen, width: 4)),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: AppColors.primaryGreen,
            child: Text('$number', style: TextStyle(color: AppColors.darkerGreen, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
          const SizedBox(height: 5),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: AppColors.textLight)),
        ],
      ),
    );
  }
}

class _PartnerLogo extends StatelessWidget {
  final String text;

  const _PartnerLogo({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
        border: Border.all(color: AppColors.primaryGreen),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkerGreen)),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;
  final bool isSocial;
  final List<IconData>? socialIcons;
  final List<String>? socialLabels;

  const _FooterColumn({
    required this.title,
    this.links = const [],
    this.isSocial = false,
    this.socialIcons,
    this.socialLabels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, color: AppColors.primaryGreen, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        if (!isSocial)
          ...links.map((link) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Text(link, style: const TextStyle(color: AppColors.white)),
              )),
        if (isSocial)
          ...List.generate(socialIcons!.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(socialIcons![index], size: 16, color: AppColors.white),
                  const SizedBox(width: 8),
                  Text(socialLabels![index], style: const TextStyle(color: AppColors.white)),
                ],
              ),
            );
          }),
      ],
    );
  }
}