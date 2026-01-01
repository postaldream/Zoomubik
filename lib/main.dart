import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(ZoomubikApp());

class ZoomubikApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoomubik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoomubik'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Bienvenida a Zoomubik',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          FooterWidget(),
        ],
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth <= 768;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(
          top: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
      ),
      child: isMobile
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFooterLink(
                    '¿Cómo funciona Zoomubik?',
                    'https://zoomubik.com/como-funciona-zoomubik/',
                  ),
                  SizedBox(height: 8),
                  _buildFooterLink(
                    'RGPD',
                    'https://zoomubik.com/rgpd/',
                  ),
                  SizedBox(height: 8),
                  _buildFooterLink(
                    'Blog',
                    'https://zoomubik.com/blog/',
                  ),
                ],
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildFooterLink(
                  '¿Cómo funciona Zoomubik?',
                  'https://zoomubik.com/como-funciona-zoomubik/',
                ),
                SizedBox(width: 20),
                _buildFooterLink(
                  'RGPD',
                  'https://zoomubik.com/rgpd/',
                ),
                SizedBox(width: 20),
                _buildFooterLink(
                  'Blog',
                  'https://zoomubik.com/blog/',
                ),
              ],
            ),
    );
  }

  Widget _buildFooterLink(String text, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        onTap: () => _launchURL(url),
        hoverColor: Colors.indigo[50],
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.indigo[700],
              fontSize: 14,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}
