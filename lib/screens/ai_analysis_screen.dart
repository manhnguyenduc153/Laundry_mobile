import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import '../theme.dart';

class AIAnalysisScreen extends StatefulWidget {
  const AIAnalysisScreen({super.key});

  @override
  State<AIAnalysisScreen> createState() => _AIAnalysisScreenState();
}

class _AIAnalysisScreenState extends State<AIAnalysisScreen> {
  dynamic _image;
  Uint8List? _imageBytes;
  bool _isAnalyzing = false;
  String? _result;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: kIsWeb ? ImageSource.gallery : source,
      );
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _image = kIsWeb ? null : File(image.path);
          _imageBytes = bytes;
          _result = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi chọn ảnh: $e')),
      );
    }
  }

  Future<void> _analyzeImage() async {
    if (_imageBytes == null) return;

    setState(() => _isAnalyzing = true);

    try {
      const apiKey = 'AIzaSyBT21ctK_qfqjzfxSUj-nvwLIg043JTsqU';
      final model = GenerativeModel(
        model: 'gemini-2.5-flash',
        apiKey: apiKey,
      );
      final prompt = '''
Phân tích hình ảnh quần áo này và cung cấp thông tin sau bằng tiếng Việt:

1. Loại quần áo (áo thun, quần jean, vest, áo khoác, đầm, v.v.)
2. Chất liệu (cotton, len, lụa, polyester, da, v.v.)
3. Màu sắc chủ đạo
4. Gói dịch vụ giặt phù hợp từ danh sách sau:
   - Giặt Nước Thường (20.000đ/kg): Quần áo hằng ngày, áo thun, quần jean, đồ cotton
   - Giặt Khô Cao Cấp (50.000đ/kg): Vest, áo khoác, đầm dạ hội, đồ len, lụa
   - Ủi Hấp Chuyên Nghiệp (15.000đ/bộ): Áo sơ mi, quần tây
   - Giặt Giày Dép (50.000đ/đôi): Giày thể thao, giày da

5. Tần suất giặt khuyến nghị (mỗi tuần bao nhiêu lần)
6. Lưu ý đặc biệt khi giặt
7. Lịch giặt gợi ý (ví dụ: Thứ 2, Thứ 5 hàng tuần)

Trả lời theo format:
📦 Loại: [loại quần áo]
🧵 Chất liệu: [chất liệu]
🎨 Màu sắc: [màu]
💰 Gói dịch vụ: [tên gói] - [giá]
🔄 Tần suất: [số lần/tuần]
⚠️ Lưu ý: [lưu ý]
📅 Lịch giặt: [lịch cụ thể]
''';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', _imageBytes!),
        ])
      ];

      final response = await model.generateContent(content);
      setState(() {
        _result = response.text ?? 'Không thể phân tích ảnh';
        _isAnalyzing = false;
      });
    } catch (e) {
      setState(() {
        _result = 'Lỗi phân tích: $e\n\nVui lòng thêm API key Gemini vào code';
        _isAnalyzing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Phân Tích Quần Áo'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: AppTheme.lightPastelBlue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.pastelBlue, width: 2),
              ),
              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.memory(_imageBytes!, fit: BoxFit.cover),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 64, color: AppTheme.pastelBlue),
                          SizedBox(height: 16),
                          Text(
                            'Chụp hoặc chọn ảnh quần áo',
                            style: TextStyle(color: AppTheme.textGrey),
                          ),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (!kIsWeb)
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Chụp ảnh'),
                    ),
                  ),
                if (!kIsWeb) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text(kIsWeb ? 'Chọn ảnh' : 'Thư viện'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_imageBytes != null)
              ElevatedButton.icon(
                onPressed: _isAnalyzing ? null : _analyzeImage,
                icon: _isAnalyzing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(_isAnalyzing ? 'Đang phân tích...' : 'Phân tích bằng AI'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            if (_result != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.pastelBlue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: AppTheme.pastelBlue),
                        SizedBox(width: 8),
                        Text(
                          'Kết quả phân tích',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _result!,
                      style: const TextStyle(fontSize: 15, height: 1.6),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.lightPastelBlue.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bảng giá dịch vụ',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildPriceRow('Giặt Nước Thường', '20.000đ/kg'),
                  _buildPriceRow('Giặt Khô Cao Cấp', '50.000đ/kg'),
                  _buildPriceRow('Ủi Hấp Chuyên Nghiệp', '15.000đ/bộ'),
                  _buildPriceRow('Giặt Chăn Ga Gối', '80.000đ/bộ'),
                  _buildPriceRow('Giặt Rèm Cửa', '30.000đ/m²'),
                  _buildPriceRow('Giặt Thảm', '40.000đ/m²'),
                  _buildPriceRow('Giặt Đồ Trẻ Em', '25.000đ/kg'),
                  _buildPriceRow('Giặt Giày Dép', '50.000đ/đôi'),
                  _buildPriceRow('Giao Nhận Tận Nơi', 'Miễn phí'),
                  _buildPriceRow('Dịch Vụ Gấp (24h)', '+30%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String service, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(service, style: const TextStyle(fontSize: 14)),
          Text(
            price,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.pastelBlue,
            ),
          ),
        ],
      ),
    );
  }
}
