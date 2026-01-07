import 'package:th.ac.ru.uSmart/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:th.ac.ru.uSmart/widget/ru_wallpaper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  final Map<String, bool> _expandedSections = {};

  @override
  void initState() {
    super.initState();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถเปิด $url ได้')),
        );
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (!await launchUrl(launchUri)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ไม่สามารถโทรออกได้')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'ติดต่อเรา',
          style: TextStyle(
            fontSize: 22,
            fontFamily: AppTheme.ruFontKanit,
            color: AppTheme.nearlyWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppTheme.ru_dark_blue,
      ),
      backgroundColor: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      body: Stack(
        children: [
          RuWallpaper(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildHeaderCard(isLightMode),
                      const SizedBox(height: 20),
                      _buildMainContactCard(isLightMode),
                      const SizedBox(height: 24),

                      // ฝ่ายรับสมัครและแนะแนวการศึกษา
                      _buildExpandableSection(
                        'ฝ่ายรับสมัครและแนะแนวการศึกษา',
                        Icons.school_rounded,
                        isLightMode,
                        [
                          {'name': 'หน่วยรับสมัคร', 'phones': ['0-2310-8615', '0-2310-8623', '0-2310-8624'], 'location': 'สวป. ชั้น 3'},
                          {'name': 'ตรวจสอบวุฒิบัตร', 'phones': ['0-2310-8000 ต่อ 4832'], 'location': 'สวป. ชั้น 3'},
                          {'name': 'แนะแนวและประชาสัมพันธ์', 'phones': ['0-2310-8614'], 'location': 'สวป. ชั้น 4'},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ฝ่ายทะเบียนประวัตินักศึกษา
                      _buildExpandableSection(
                        'ฝ่ายทะเบียนประวัตินักศึกษา',
                        Icons.person_outline_rounded,
                        isLightMode,
                        [
                          {'name': 'ทะเบียนประวัตินักศึกษา', 'phones': ['0-2310-8606'], 'location': 'สวป. ชั้น 2'},
                          {'name': 'บัตรประจำตัวนักศึกษา', 'phones': ['0-2310-8605'], 'location': 'สวป. ชั้น 2'},
                          {'name': 'กรรมวิธีข้อมูล', 'phones': ['0-2310-8619'], 'location': 'สวป. ชั้น 4'},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ฝ่ายลงทะเบียนเรียนและจัดสอบ
                      _buildExpandableSection(
                        'ฝ่ายลงทะเบียนเรียนและจัดสอบ',
                        Icons.app_registration_rounded,
                        isLightMode,
                        [
                          {'name': 'จัดตารางสอน', 'phones': ['0-2310-8610'], 'location': 'สวป. ชั้น 6'},
                          {'name': 'ลงทะเบียนเรียน', 'phones': ['0-2310-8616'], 'location': 'KLB ชั้น 1'},
                          {'name': 'ตรวจสอบและแก้ไขข้อมูล', 'phones': ['0-2310-8626'], 'location': 'สวป. ชั้น 6'},
                          {'name': 'จัดสอบ', 'phones': ['0-2310-8611'], 'location': 'สวป. ชั้น 6'},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ฝ่ายประมวลผลการศึกษาและหนังสือสำคัญ
                      _buildExpandableSection(
                        'ฝ่ายประมวลผลการศึกษา',
                        Icons.analytics_rounded,
                        isLightMode,
                        [
                          {'name': 'ประมวลและรับรองผลการศึกษา', 'phones': ['0-2310-8603'], 'location': 'สวป. ชั้น 1'},
                          {'name': 'ปริญญาบัตรและตรวจสอบวุฒิบัตร', 'phones': ['0-2310-8604'], 'location': 'สวป. ชั้น 1'},
                          {'name': 'บริการจุดเดียวเบ็ดเสร็จ', 'phones': ['0-2310-8890'], 'location': 'KLB ชั้น 1'},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // สำนักงานเลขานุการ
                      _buildExpandableSection(
                        'สำนักงานเลขานุการ',
                        Icons.business_rounded,
                        isLightMode,
                        [
                          {'name': 'บริหารและธุรการ', 'phones': ['0-2310-8617', '0-2310-8618', '0-2310-8619'], 'location': 'สวป. ชั้น 5'},
                          {'name': 'นโยบายและแผน', 'phones': ['0-2310-8608'], 'location': 'สวป. ชั้น 5'},
                          {'name': 'ประกันคุณภาพการศึกษา', 'phones': ['0-2310-8627'], 'location': 'สวป. ชั้น 5'},
                          {'name': 'คลังและพัสดุ', 'phones': ['0-2310-8609'], 'location': 'สวป. ชั้น 5'},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // งานสำนักงานอธิการบดี
                      _buildExpandableSection(
                        'งานสำนักงานอธิการบดี',
                        Icons.account_balance_rounded,
                        isLightMode,
                        [
                          {'name': 'จัดหางานและแนะแนวการศึกษา', 'phones': ['0-2310-8126']},
                          {'name': 'ทุนการศึกษา', 'phones': ['0-2310-8080']},
                          {'name': 'ตำราเรียน', 'phones': ['0-2310-8757', '0-2310-8759 ต่อ 1101, 1103']},
                          {'name': 'เทปคำบรรยาย', 'phones': ['0-2310-8703', '0-2310-8704', '0-2310-8705', '0-2310-8706']},
                          {'name': 'บริการวิชาการและทดสอบอิเล็กทรอนิกส์', 'phones': ['0-2310-8790']},
                        ],
                      ),
                      const SizedBox(height: 12),

                      // คณะต่างๆ
                      _buildExpandableSection(
                        'คณะต่างๆ',
                        Icons.domain_rounded,
                        isLightMode,
                        [
                          {'name': 'นิติศาสตร์', 'phones': ['0-2310-8170', '0-2310-8174']},
                          {'name': 'บริหารธุรกิจ', 'phones': ['0-2310-8214']},
                          {'name': 'มนุษยศาสตร์', 'phones': ['0-2310-8269']},
                          {'name': 'ศึกษาศาสตร์', 'phones': ['0-2310-8315', '0-2310-8321']},
                          {'name': 'วิทยาศาสตร์', 'phones': ['0-2310-8410', '0-2310-8411']},
                          {'name': 'รัฐศาสตร์', 'phones': ['0-2310-8466', '0-2310-8467']},
                          {'name': 'เศรษฐศาสตร์', 'phones': ['0-2310-8534']},
                          {'name': 'สื่อสารมวลชน', 'phones': ['0-2310-8980']},
                          {'name': 'พัฒนาทรัพยากรมนุษย์', 'phones': ['0-2310-8547', '0-2310-8337']},
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildSectionTitle('ช่องทางติดต่อออนไลน์', isLightMode),
                      const SizedBox(height: 12),
                      _buildSocialMediaCard(isLightMode),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.ru_dark_blue,
            AppTheme.ru_dark_blue.withValues(alpha: 0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppTheme.ru_dark_blue.withValues(alpha: 0.3),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.support_agent_rounded,
              size: 48,
              color: AppTheme.nearlyWhite,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ศูนย์ช่วยเหลือนักศึกษา',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: AppTheme.ruFontKanit,
              color: AppTheme.nearlyWhite,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ข้อมูลติดต่อครบถ้วนทุกหน่วยงาน',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppTheme.ruFontKanit,
              color: AppTheme.nearlyWhite.withValues(alpha: 0.9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContactCard(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLightMode
              ? [Colors.white, Colors.white.withValues(alpha: 0.95)]
              : [
                  AppTheme.nearlyBlack.withValues(alpha: 0.9),
                  AppTheme.nearlyBlack.withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLightMode
              ? Colors.grey.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isLightMode
                ? Colors.grey.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.3),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.location_city_rounded,
                  color: AppTheme.ru_dark_blue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'มหาวิทยาลัยรามคำแหง',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppTheme.ruFontKanit,
                    color: isLightMode ? AppTheme.nearlyBlack : AppTheme.nearlyWhite,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildContactRow(
            Icons.location_on_rounded,
            '282 ถนนรามคำแหง หัวหมาก\nบางกะปิ กรุงเทพมหานคร 10240',
            isLightMode,
            null,
          ),
          const SizedBox(height: 12),
          _buildContactRow(
            Icons.phone_rounded,
            '0-2310-8000',
            isLightMode,
            () => _makePhoneCall('0-2310-8000'),
          ),
          const SizedBox(height: 12),
          _buildContactRow(
            Icons.fax_rounded,
            '0-2310-8022',
            isLightMode,
            null,
          ),
          const SizedBox(height: 12),
          _buildContactRow(
            Icons.email_rounded,
            'saraban@ru.ac.th',
            isLightMode,
            () => _launchURL('mailto:saraban@ru.ac.th'),
          ),
          const SizedBox(height: 12),
          _buildContactRow(
            Icons.language_rounded,
            'www.ru.ac.th',
            isLightMode,
            () => _launchURL('https://www.ru.ac.th'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text, bool isLightMode, VoidCallback? onTap) {
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: isLightMode ? Colors.grey[600] : Colors.grey[400],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontFamily: AppTheme.ruFontKanit,
              color: isLightMode ? Colors.grey[800] : Colors.grey[300],
              height: 1.5,
            ),
          ),
        ),
        if (onTap != null)
          Icon(
            Icons.open_in_new_rounded,
            size: 16,
            color: AppTheme.ru_dark_blue,
          ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: content,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: content,
    );
  }

  Widget _buildSectionTitle(String title, bool isLightMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamily: AppTheme.ruFontKanit,
          color: isLightMode ? AppTheme.nearlyBlack : AppTheme.nearlyWhite,
        ),
      ),
    );
  }

  Widget _buildExpandableSection(
    String title,
    IconData icon,
    bool isLightMode,
    List<Map<String, dynamic>> items,
  ) {
    final isExpanded = _expandedSections[title] ?? false;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLightMode
              ? [Colors.white, Colors.white.withValues(alpha: 0.95)]
              : [
                  AppTheme.nearlyBlack.withValues(alpha: 0.9),
                  AppTheme.nearlyBlack.withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLightMode
              ? Colors.grey.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isLightMode
                ? Colors.grey.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.2),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _expandedSections[title] = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.ru_dark_blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: AppTheme.ru_dark_blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: AppTheme.ruFontKanit,
                            color: isLightMode
                                ? AppTheme.nearlyBlack
                                : AppTheme.nearlyWhite,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${items.length} หน่วยงาน',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: AppTheme.ruFontKanit,
                            color: isLightMode ? Colors.grey[600] : Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppTheme.ru_dark_blue,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                children: items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isLightMode
                            ? Colors.grey.withValues(alpha: 0.05)
                            : Colors.white.withValues(alpha: 0.03),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isLightMode
                              ? Colors.grey.withValues(alpha: 0.1)
                              : Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.arrow_right_rounded,
                                size: 20,
                                color: AppTheme.ru_dark_blue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppTheme.ruFontKanit,
                                    color: isLightMode
                                        ? AppTheme.nearlyBlack
                                        : AppTheme.nearlyWhite,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (item['location'] != null) ...[
                            const SizedBox(height: 6),
                            Padding(
                              padding: const EdgeInsets.only(left: 28),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.place_rounded,
                                    size: 14,
                                    color: isLightMode
                                        ? Colors.grey[600]
                                        : Colors.grey[400],
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    item['location'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: AppTheme.ruFontKanit,
                                      color: isLightMode
                                          ? Colors.grey[600]
                                          : Colors.grey[400],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          ...((item['phones'] as List<String>).map((phone) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 28, top: 4),
                              child: InkWell(
                                onTap: () => _makePhoneCall(phone),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 14,
                                        color: AppTheme.ru_dark_blue,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          phone,
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontFamily: AppTheme.ruFontKanit,
                                            color: isLightMode
                                                ? Colors.grey[700]
                                                : Colors.grey[400],
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.call_rounded,
                                        size: 14,
                                        color: AppTheme.ru_dark_blue
                                            .withValues(alpha: 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaCard(bool isLightMode) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLightMode
              ? [Colors.white, Colors.white.withValues(alpha: 0.95)]
              : [
                  AppTheme.nearlyBlack.withValues(alpha: 0.9),
                  AppTheme.nearlyBlack.withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isLightMode
              ? Colors.grey.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isLightMode
                ? Colors.grey.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.3),
            offset: const Offset(0, 6),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'ติดตามเราได้ที่',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: AppTheme.ruFontKanit,
              color: isLightMode ? AppTheme.nearlyBlack : AppTheme.nearlyWhite,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSocialButton(
                FontAwesomeIcons.facebook,
                'Facebook',
                const Color(0xFF1877F2),
                () => _launchURL('https://www.facebook.com/RamkhamhaengUniversity'),
              ),
              _buildSocialButton(
                FontAwesomeIcons.youtube,
                'YouTube',
                const Color(0xFFFF0000),
                () => _launchURL('https://www.youtube.com/user/RamkhamhaengU'),
              ),
              _buildSocialButton(
                FontAwesomeIcons.xTwitter,
                'Twitter',
                const Color(0xFF000000),
                () => _launchURL('https://twitter.com/ramkhamhaeng_u'),
              ),
              _buildSocialButton(
                FontAwesomeIcons.line,
                'LINE',
                const Color(0xFF00B900),
                () => _launchURL('https://line.me/R/ti/p/@ramkhamhaeng'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontFamily: AppTheme.ruFontKanit,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
