// Yeni ResultPage mimari sınıflandırma için
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class ResultPage extends StatefulWidget {
  final File imageFile;

  const ResultPage({super.key, required this.imageFile});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  Interpreter? _interpreter;
  List<String> _labels = [];
  List<double> _predictions = [];
  bool _isLoading = true;
  String _error = '';

final Map<String, String> _architectureDescriptions = {
  "Achaemenid architecture": "Antik Pers dönemine ait; büyük sütunlar ve taş kabartmalarla anıtsaldır.",
  "American Foursquare architecture": "Dörtgen planlı, sade ve pratik bir Amerikan banliyö stilidir.",
  "American craftsman style": "Ahşap işçiliği ve elde yapılmış detaylara vurgu yapan sıcak bir stildir.",
  "Ancient Egyptian architecture": "Piramitler, devasa taş yapılar ve hiyeroglif süslemelerle tanınır.",
  "Art Deco architecture": "Sert geometrik çizgiler ve parlak dekoratif unsurlarla öne çıkar.",
  "Art Nouveau architecture": "Organik kıvrımlar, çiçek motifleri ve doğadan ilham alan süslemeler içerir.",
  "Baroque architecture": "Abartılı süslemeler ve dramatik ışık-gölge oyunlarıyla tanınır.",
  "Bauhaus architecture": "Minimalist, fonksiyonu ön plana alan modernist bir yaklaşımdır.",
  "Beaux-Arts architecture": "Simetri, klasik oranlar ve heykelsi detaylar barındıran gösterişli bir tarzdır.",
  "Byzantine architecture": "Kubbe yapılar ve mozaiklerle dikkat çeker.",
  "Chicago school architecture": "Çelik iskeletli gökdelenlerin öncüsüdür; işlevselliğe odaklanır.",
  "Colonial architecture": "Avrupa etkili sade cepheler, simetri ve ahşap detaylarla öne çıkar.",
  "Deconstructivism": "Karmaşık ve parçalanmış formlar kullanılarak yapılandırılmıştır.",
  "Edwardian architecture": "Barok unsurların sadeleşmiş haliyle geniş camlar ve ferah iç mekânlar sunar.",
  "Georgian architecture": "Dengeli cephe düzeni, tuğla kullanımı ve klasik detaylarla tanımlanır.",
  "Gothic architecture": "Yüksek kemerler, vitraylar ve dikey yapı unsurları ön plandadır.",
  "Greek Revival architecture": "Antik Yunan sütunları, üçgen alınlıklar ve sade cephelerle tanınır.",
  "International style": "Süslemesiz yüzeyler ve cam-metal yapılarla karakterizedir.",
  "Novelty architecture": "Binaların kendisinin nesne veya karakter şeklinde tasarlandığı eğlenceli bir yaklaşımdır.",
  "Palladian architecture": "Simetri ve klasik sütunlar içeren Rönesans etkili bir stildir.",
  "Postmodern architecture": "Modernizme karşı ironi ve tarihsel referanslar içerir.",
  "Queen Anne architecture": "Çok katlı, kuleli ve süslü cepheli Viktorya dönemi yapı stilidir.",
  "Romanesque architecture": "Kalın duvarlar, yarım daire kemerler ve küçük pencerelerle tanınır.",
  "Russian Revival architecture": "Soğan kubbeler, canlı renkler ve geleneksel Rus motiflerini içerir.",
  "Tudor Revival architecture": "Ahşap süslemeler ve eğimli çatıları ile tanınır.",
};


  @override
  void initState() {
    super.initState();
    _loadModelAndPredict();
  }

  Future<void> _loadModelAndPredict() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/mobilenet_model.tflite');
      final labelsData = await rootBundle.loadString('assets/labels.json');
      final List<dynamic> labelsList = json.decode(labelsData);
      _labels = labelsList.cast<String>();

      await _predictArchitecture();
    } catch (e) {
      setState(() {
        _error = 'Model veya etiketler yüklenemedi: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _predictArchitecture() async {
    try {
      final bytes = await widget.imageFile.readAsBytes();
      img.Image? image = img.decodeImage(bytes);
      if (image == null) throw Exception('Görüntü okunamadı');

      // Görüntüyü 224x224 boyutuna yeniden boyutlandır
      img.Image resizedImage = img.copyResize(
        image,
        width: 224,
        height: 224,
        interpolation: img.Interpolation.linear
      );

      // Giriş tensörünü hazırla
      var input = Float32List(1 * 224 * 224 * 3);
      int pixelIndex = 0;
      
      // Görüntüyü normalize et ve tensöre dönüştür
      for (int y = 0; y < 224; y++) {
        for (int x = 0; x < 224; x++) {
          final pixel = resizedImage.getPixel(x, y);
          // RGB değerlerini normalize et
          input[pixelIndex++] = pixel.r / 255.0;
          input[pixelIndex++] = pixel.g / 255.0;
          input[pixelIndex++] = pixel.b / 255.0;
        }
      }

      // Giriş tensörünü yeniden şekillendir
      var inputTensor = input.reshape([1, 224, 224, 3]);
      
      // Çıkış tensörünü hazırla
      var output = List.filled(_labels.length, 0.0).reshape([1, _labels.length]);

      // Modeli çalıştır
      if (_interpreter == null) throw Exception('Model yüklenemedi');
      _interpreter!.run(inputTensor, output);

      // Çıktıyı işle
      _predictions = List<double>.from(output[0]);

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _error = 'Tahmin yapılamadı: $e';
        _isLoading = false;
      });
    }
  }

  String _getTopLabel() {
    if (_predictions.isEmpty || _labels.isEmpty) return 'Tanımsız';
    final maxIndex = _predictions.indexWhere((v) => v == _predictions.reduce((a, b) => a > b ? a : b));
    return _labels[maxIndex];
  }

  @override
  Widget build(BuildContext context) {
    final label = _getTopLabel();
    final explanation = _architectureDescriptions[label] ?? 'Bu mimari stil hakkında açıklama bulunamadı.';
    final probability = _predictions.isNotEmpty ? (_predictions[_labels.indexOf(label)] * 100).toStringAsFixed(1) : '--';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Archify AI'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.red)))
              : Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(widget.imageFile, height: 220, fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 32),
                      Text(label.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 28,
                            color: const Color(0xFF404040),
                          )),
                      const SizedBox(height: 8),
                      Text('$probability%', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: const Color(0xFF404040))),
                      const SizedBox(height: 24),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF404040),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          explanation,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Yeni Görsel Seç'),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
