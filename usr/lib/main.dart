import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Research Paper',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const ResearchPaperScreen(),
      },
    );
  }
}

class ResearchPaperScreen extends StatelessWidget {
  const ResearchPaperScreen({super.key});

  final String title = "A Study On Investment Portfolio Optimization Using AI Tools";

  Future<void> _generateAndPrintPdf(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                title,
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.SizedBox(height: 20),
            _buildPdfSection('1. Abstract', abstractText),
            _buildPdfSection('2. Introduction', introText),
            _buildPdfSection('3. Role of AI in Portfolio Optimization', roleText),
            _buildPdfSection('4. Key AI Tools and Algorithms', toolsText),
            _buildPdfSection('5. Conclusion', conclusionText),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'AI_Portfolio_Optimization_Study.pdf',
    );
  }

  pw.Widget _buildPdfSection(String header, String content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          header,
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          content,
          style: const pw.TextStyle(fontSize: 12, lineSpacing: 1.5),
        ),
        pw.SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Research Paper Viewer'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            tooltip: 'Download PDF',
            onPressed: () => _generateAndPrintPdf(context),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Research Study',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(height: 40, thickness: 1.5),
                    _buildUiSection(context, '1. Abstract', abstractText),
                    _buildUiSection(context, '2. Introduction', introText),
                    _buildUiSection(context, '3. Role of AI in Portfolio Optimization', roleText),
                    _buildUiSection(context, '4. Key AI Tools and Algorithms', toolsText),
                    _buildUiSection(context, '5. Conclusion', conclusionText),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _generateAndPrintPdf(context),
        icon: const Icon(Icons.download),
        label: const Text('Generate PDF'),
      ),
    );
  }

  Widget _buildUiSection(BuildContext context, String header, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  // Content strings for the research paper
  static const String abstractText =
      "This study explores the integration of Artificial Intelligence (AI) and Machine Learning (ML) algorithms in optimizing investment portfolios. Traditional models like Markowitz's Modern Portfolio Theory (MPT) are compared with AI-driven approaches to demonstrate how machine learning can improve risk-adjusted returns and dynamic asset allocation.";

  static const String introText =
      "The financial landscape has witnessed a paradigm shift with the advent of Artificial Intelligence (AI). Traditional portfolio optimization, heavily reliant on historical variance and covariance, often struggles with the dynamic and non-linear nature of modern financial markets. This study investigates how AI tools can enhance portfolio allocation, risk management, and return prediction by processing vast amounts of structured and unstructured data.";

  static const String roleText =
      "• Predictive Analytics: AI models analyze vast datasets, including historical prices, news sentiment, and macroeconomic indicators, to forecast asset returns with higher accuracy.\n\n• Risk Assessment: Machine learning algorithms can identify hidden correlations and tail risks that traditional matrices might miss.\n\n• Dynamic Rebalancing: Reinforcement learning agents can continuously adapt portfolio weights in real-time based on changing market conditions.";

  static const String toolsText =
      "• Artificial Neural Networks (ANNs): Used for pattern recognition in asset price movements.\n\n• Genetic Algorithms (GAs): Employed to solve complex, multi-objective optimization problems (e.g., maximizing returns while minimizing risk and transaction costs).\n\n• Natural Language Processing (NLP): Utilized to gauge market sentiment from financial news and social media, integrating qualitative data into quantitative models.";

  static const String conclusionText =
      "The integration of AI tools in investment portfolio optimization offers a significant competitive advantage. By leveraging advanced algorithms, investors can achieve better risk-adjusted returns and build portfolios that are resilient to market shocks. However, challenges such as model interpretability (the 'black-box' nature of AI) and data overfitting must be carefully managed to ensure long-term success.";
}
