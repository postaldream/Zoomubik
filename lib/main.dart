import 'package:flutter/material.dart';

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

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Simulated user state - in a real app, this would come from authentication
  bool _isLoggedIn = false;
  
  // Keys for scrolling to specific widgets
  final GlobalKey _contentKey = GlobalKey();
  final GlobalKey _formKey = GlobalKey();
  
  // ScrollController for managing scroll position
  final ScrollController _scrollController = ScrollController();
  
  // Height of the sticky footer (will be calculated dynamically)
  static const double footerHeight = 72.0;
  
  /// Handles the "Publicar" button press
  void _handlePublicarPress() {
    print('Publicar button pressed');
    
    if (!_isLoggedIn) {
      // User is not logged in - show login modal
      print('User not logged in - showing login modal');
      _showLoginModal();
    } else {
      // User is logged in - scroll to target content
      print('User logged in - scrolling to target content');
      _scrollToTarget();
    }
  }
  
  /// Shows the login modal dialog
  void _showLoginModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Iniciar Sesión'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                // Simulate login
                setState(() {
                  _isLoggedIn = true;
                });
                Navigator.of(context).pop();
                print('User logged in successfully');
                // After login, scroll to target
                Future.delayed(Duration(milliseconds: 300), () {
                  _scrollToTarget();
                });
              },
              child: Text('Ingresar'),
            ),
          ],
        );
      },
    );
  }
  
  /// Scrolls to the target content with proper offset for sticky footer
  void _scrollToTarget() {
    // Validate that target exists before attempting to scroll
    final RenderBox? targetBox = _formKey.currentContext?.findRenderObject() as RenderBox?;
    
    if (targetBox == null) {
      print('ERROR: Target form/content not found in DOM');
      print('Cannot scroll to target - widget does not exist');
      return;
    }
    
    print('Target widget found - calculating scroll position');
    
    try {
      // Get the position of the target widget
      final targetPosition = targetBox.localToGlobal(Offset.zero);
      final targetHeight = targetBox.size.height;
      
      print('Target position: ${targetPosition.dy}');
      print('Target height: $targetHeight');
      print('Footer height: $footerHeight');
      
      // Calculate scroll position accounting for:
      // 1. Current scroll offset
      // 2. Target position
      // 3. Sticky footer height (to prevent overlapping)
      // 4. Additional padding for better UX
      final currentScrollPosition = _scrollController.offset;
      final targetScrollPosition = currentScrollPosition + targetPosition.dy - footerHeight - 20;
      
      print('Current scroll: $currentScrollPosition');
      print('Target scroll position: $targetScrollPosition');
      
      // Animate scroll to target position
      _scrollController.animateTo(
        targetScrollPosition,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ).then((_) {
        print('Scroll completed successfully');
        // Simulate interaction (focus) on the target widget
        _simulateInteraction();
      });
    } catch (e) {
      print('ERROR: Failed to scroll to target - $e');
    }
  }
  
  /// Simulates user interaction with the target widget (focus/click)
  void _simulateInteraction() {
    // In a real app, this would focus on a form field or trigger specific behavior
    print('Simulating interaction with target content');
    
    // Could add visual feedback here, like highlighting the target
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Listo para publicar'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoomubik'),
        actions: [
          // Toggle login state for testing
          IconButton(
            icon: Icon(_isLoggedIn ? Icons.logout : Icons.login),
            onPressed: () {
              setState(() {
                _isLoggedIn = !_isLoggedIn;
              });
              print('Login state toggled: $_isLoggedIn');
            },
            tooltip: _isLoggedIn ? 'Cerrar Sesión' : 'Iniciar Sesión',
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome section
              Container(
                key: _contentKey,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Icon(Icons.explore, size: 64, color: Colors.indigo),
                    SizedBox(height: 16),
                    Text(
                      'Bienvenida a Zoomubik',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tu plataforma de publicación',
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Spacer content to enable scrolling
              Container(
                height: 400,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Contenido de ejemplo\n\nDesplázate hacia abajo para ver el formulario',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
              // Target form/content that "Publicar" button will scroll to
              Container(
                key: _formKey,
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.indigo, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Formulario de Publicación',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Título',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Descripción',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        print('Submit form');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Formulario enviado')),
                        );
                      },
                      icon: Icon(Icons.send),
                      label: Text('Enviar'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(16),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Extra space to ensure footer doesn't overlap content
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
      // Sticky footer with "Publicar" button
      bottomNavigationBar: Container(
        height: footerHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: ElevatedButton.icon(
            onPressed: _handlePublicarPress,
            icon: Icon(Icons.publish, size: 24),
            label: Text(
              'Publicar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
          ),
        ),
      ),
    );
  }
}
