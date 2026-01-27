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
      routes: {
        '/publicacion': (context) => PublicacionPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Define provinces
  final List<String> provincias = [
    'madrid',
    'barcelona',
    'valencia',
    'sevilla',
    'bilbao',
    'malaga',
  ];

  // Define categories
  final List<String> categorias = [
    'alquiler',
    'venta',
    'compartir',
  ];

  String? selectedOption;

  // Generate combined options
  List<Map<String, String>> getCombinedOptions() {
    List<Map<String, String>> options = [];
    for (var provincia in provincias) {
      for (var categoria in categorias) {
        options.add({
          'value': '$provincia-$categoria',
          'label': '${provincia.toUpperCase()} - ${categoria.toUpperCase()}',
          'provincia': provincia,
          'categoria': categoria,
        });
      }
    }
    return options;
  }

  void navigateToPublicacion(String? optionValue) {
    if (optionValue == null) return;

    // Parse the selected option
    final parts = optionValue.split('-');
    if (parts.length == 2) {
      final provincia = parts[0];
      final categoria = parts[1];

      // Navigate to the publicacion page with parameters
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PublicacionPage(
            provincia: provincia,
            categoria: categoria,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final combinedOptions = getCombinedOptions();

    return Scaffold(
      appBar: AppBar(
        title: Text('Zoomubik'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenida a Zoomubik',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Text(
                'Selecciona tu provincia y categoría:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: selectedOption,
                  hint: Text('Seleccionar provincia y categoría'),
                  isExpanded: true,
                  underline: Container(),
                  items: combinedOptions.map((option) {
                    return DropdownMenuItem<String>(
                      value: option['value'],
                      child: Text(option['label']!),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue;
                    });
                    navigateToPublicacion(newValue);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PublicacionPage extends StatelessWidget {
  final String? provincia;
  final String? categoria;

  const PublicacionPage({
    Key? key,
    this.provincia,
    this.categoria,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicar Inmueble'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (provincia != null && categoria != null) ...[
              Card(
                color: Colors.indigo.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Formulario Filtrado',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Provincia: ${provincia!.toUpperCase()}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Categoría: ${categoria!.toUpperCase()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
            ],
            Text(
              'Datos del Inmueble',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Precio (€)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: provincia != null && categoria != null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Publicación creada en ${provincia!.toUpperCase()} para ${categoria!.toUpperCase()}',
                            ),
                          ),
                        );
                      }
                    : null,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Publicar',
                    style: TextStyle(fontSize: 16),
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
