import 'package:flutter/material.dart';
import '../theme.dart';
import '../services/api_service.dart';
import '../data/dummy_data.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteController = TextEditingController();
  bool _isLoading = false;
  String? _selectedShop;
  String? _selectedService;

  final List<String> _services = [
    'Giặt ủi',
    'Giặt khô',
    'Giặt nhanh 24h',
    'Giặt vest',
    'Giặt áo dài',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      final success = await ApiService.createContact({
        'shopId': int.parse(_selectedShop!),
        'name': _nameController.text,
        'phone': _phoneController.text,
        'address': _addressController.text,
        'description': _noteController.text,
        'serviceType': _selectedService!,
      });
      setState(() => _isLoading = false);
      
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đặt dịch vụ thành công! Chúng tôi sẽ liên hệ sớm.'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
        _formKey.currentState!.reset();
        _nameController.clear();
        _phoneController.clear();
        _addressController.clear();
        _noteController.clear();
        setState(() {
          _selectedShop = null;
          _selectedService = null;
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Gửi thất bại. Vui lòng thử lại.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đặt dịch vụ'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.local_laundry_service,
                size: 80,
                color: AppTheme.pastelBlue,
              ),
              const SizedBox(height: 16),
              const Text(
                'Đặt dịch vụ giặt ủi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Vui lòng điền thông tin bên dưới',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.textGrey,
                ),
              ),
              const SizedBox(height: 32),
              DropdownButtonFormField<String>(
                value: _selectedShop,
                decoration: const InputDecoration(
                  labelText: 'Chọn tiệm giặt',
                  prefixIcon: Icon(Icons.store),
                ),
                items: DummyData.stores.map((store) {
                  return DropdownMenuItem(
                    value: store.id,
                    child: Text(store.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedShop = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn tiệm giặt';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedService,
                decoration: const InputDecoration(
                  labelText: 'Chọn loại dịch vụ',
                  prefixIcon: Icon(Icons.cleaning_services),
                ),
                items: _services.map((service) {
                  return DropdownMenuItem(
                    value: service,
                    child: Text(service),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedService = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng chọn loại dịch vụ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Họ và tên',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập họ tên';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Số điện thoại',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Địa chỉ nhận đồ',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập địa chỉ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Ghi chú',
                  prefixIcon: Icon(Icons.note_outlined),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 32),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Đặt dịch vụ'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
