import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../controllers/verduras_controller.dart';
import '../models/verdura.dart';
import '../theme/app_theme.dart';
import 'inicio_view.dart';
import '../main.dart';  // Importamos main.dart para usar ThemeProvider

class VerdurasListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Verduras'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode
              ? AppTheme.iconDarkColor
              : AppTheme.iconLightColor,
        ),
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            ],
          ),
        ),
        child: Consumer<VerdurasController>(
          builder: (context, controller, child) {
            if (controller.verduras.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 16),
                    Text('Cargando verduras...', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
              );
            }
            return AnimationLimiter(
              child: ListView.builder(
                itemCount: controller.verduras.length,
                padding: EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final verdura = controller.verduras[index];
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 375),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: _buildVerduraCard(context, controller, verdura),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showVerduraDialog(
          context,
          Provider.of<VerdurasController>(context, listen: false),
          null,
        ),
        label: Text('Añadir Verdura'),
        icon: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.eco,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Menú Principal',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.home,
              title: 'Inicio',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => InicioView()),
                );
              },
            ),
            _buildDrawerItem(
              context: context,
              icon: Icons.eco,
              title: 'Gestión de Verduras',
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListTile(
      leading: Icon(
        icon,
        color: themeProvider.isDarkMode
            ? AppTheme.iconDarkColor
            : AppTheme.iconLightColor,
      ),
      title: Text(title, style: Theme.of(context).textTheme.bodyLarge),
      onTap: onTap,
      hoverColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
    );
  }


  Widget _buildVerduraCard(
      BuildContext context,
      VerdurasController controller,
      Verdura verdura,
      ) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showVerduraDialog(context, controller, verdura),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.primary.withOpacity(0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.eco,
                    color: themeProvider.isDarkMode
                        ? AppTheme.iconDarkColor
                        : AppTheme.iconLightColor,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      verdura.descripcion,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Código: ${verdura.codigo}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Precio: \$${verdura.precio.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: themeProvider.isDarkMode
                      ? AppTheme.iconDarkColor
                      : AppTheme.iconLightColor,
                ),
                onPressed: () => _showVerduraDialog(context, controller, verdura),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _showDeleteConfirmationDialog(
                  context,
                  controller,
                  verdura,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context,
      VerdurasController controller,
      Verdura verdura,
      ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text('Confirmar eliminación'),
        content: Text('¿Está seguro que desea eliminar ${verdura.descripcion}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.deleteVerdura(verdura.codigo);
              Navigator.of(context).pop();
              _showToast(context, 'Verdura eliminada exitosamente', Colors.redAccent);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _showVerduraDialog(
      BuildContext context,
      VerdurasController controller,
      Verdura? verdura,
      ) {
    final isEditing = verdura != null;
    final codigoController = TextEditingController(
      text: isEditing ? verdura.codigo.toString() : '',
    );
    final descripcionController = TextEditingController(
      text: isEditing ? verdura.descripcion : '',
    );
    final precioController = TextEditingController(
      text: isEditing ? verdura.precio.toString() : '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Text(
          isEditing ? 'Editar Verdura' : 'Añadir Verdura',
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codigoController,
                decoration: InputDecoration(
                  labelText: 'Código',
                  prefixIcon: Icon(Icons.tag),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: precioController,
                decoration: InputDecoration(
                  labelText: 'Precio',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final newVerdura = Verdura(
                codigo: int.parse(codigoController.text),
                descripcion: descripcionController.text,
                precio: double.parse(precioController.text),
              );
              if (isEditing) {
                controller.updateVerdura(newVerdura);
                _showToast(context, 'Verdura actualizada exitosamente', Colors.green);
              } else {
                controller.addVerdura(newVerdura);
                _showToast(context, 'Verdura agregada exitosamente', Colors.green);
              }
              Navigator.of(context).pop();
            },
            child: Text(isEditing ? 'Actualizar' : 'Añadir'),
          ),
        ],
      ),
    );
  }
  void _showToast(BuildContext context, String message, Color color) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(child: Text(message, style: TextStyle(color: Colors.white)))),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    Future.delayed(Duration(seconds: 2), () => overlayEntry.remove());
  }
}