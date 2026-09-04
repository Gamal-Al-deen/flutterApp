import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServicesData {
  ServicesData._();

  static const List<ServiceModel> all = [
    ServiceModel(
      id: 'srv_001',
      title: 'إصدار جواز سفر',
      shortDescription: 'تجديد وإصدار جوازات السفر الإلكترونية',
      description:
          'تتيح لك هذه الخدمة إصدار أو تجديد جواز السفر إلكترونياً دون الحاجة إلى مراجعة المكاتب. يتم إصدار الطلب خلال فترة قصيرة بعد استكمال المتطلبات ودفع الرسوم المحددة.',
      category: ServiceCategory.documents,
      icon: Icons.badge_rounded,
      color: Color(0xFF0F52BA),
      estimatedDays: 7,
      fee: 150.0,
      rating: 4.8,
      isFeatured: true,
      requirements: [
        'الهوية الوطنية سارية المفعول',
        'صور شخصية حديثة بخلفية بيضاء',
        'إثبات الإقامة',
        'سداد الرسوم',
      ],
      steps: [
        'تعبئة نموذج الطلب',
        'إرفاق المتطلبات',
        'سداد الرسوم إلكترونياً',
        'انتظار مراجعة الطلب',
        'استلام الجواز',
      ],
    ),
    ServiceModel(
      id: 'srv_002',
      title: 'تجديد الهوية الوطنية',
      shortDescription: 'تجديد بطاقة الهوية الوطنية إلكترونياً',
      description:
          'تجديد بطاقة الهوية الوطنية بطريقة سهلة وسريعة عبر المنصة، مع إمكانية متابعة حالة الطلب لحظياً.',
      category: ServiceCategory.civil,
      icon: Icons.account_balance_rounded,
      color: Color(0xFF1E88E5),
      estimatedDays: 5,
      fee: 60.0,
      rating: 4.7,
      isFeatured: true,
      requirements: [
        'الهوية القديمة',
        'صور شخصية حديثة',
        'إثبات العنوان',
      ],
      steps: [
        'تقديم طلب التجديد',
        'رفع المرفقات',
        'مراجعة الطلب',
        'استلام البطاقة',
      ],
    ),
    ServiceModel(
      id: 'srv_003',
      title: 'إصدار رخصة قيادة',
      shortDescription: 'إصدار وتجديد رخص القيادة',
      description:
          'خدمة شاملة لإصدار وتجديد رخص القيادة بمختلف أنواعها، مع توفير الفحص الطبي الإلكتروني.',
      category: ServiceCategory.licenses,
      icon: Icons.directions_car_rounded,
      color: Color(0xFFE91E63),
      estimatedDays: 10,
      fee: 200.0,
      rating: 4.5,
      isFeatured: true,
      requirements: [
        'الهوية الوطنية',
        'فحص طبي معتمد',
        'صور شخصية',
        'إثبات العمر المطلوب',
      ],
      steps: [
        'تقديم الطلب',
        'إجراء الفحص الطبي',
        'سداد الرسوم',
        'اجتياز الاختبار النظري',
        'استلام الرخصة',
      ],
    ),
    ServiceModel(
      id: 'srv_004',
      title: 'نقل ملكية مركبة',
      shortDescription: 'نقل ملكية المركبات بين الأفراد',
      description:
          'خدمة نقل ملكية المركبات بطريقة إلكترونية متكاملة، تشمل التحقق من بيانات البائع والمشتري.',
      category: ServiceCategory.vehicles,
      icon: Icons.swap_horiz_rounded,
      color: Color(0xFF4CAF50),
      estimatedDays: 3,
      fee: 120.0,
      rating: 4.6,
      isFeatured: true,
      requirements: [
        'هوية البائع والمشتري',
        'استمارة المركبة',
        'تقرير فحص المركبة',
        'بوليصة التأمين',
      ],
      steps: [
        'تقديم طلب النقل',
        'التحقق من البيانات',
        'دفع الرسوم',
        'إصدار الاستمارة الجديدة',
      ],
    ),
    ServiceModel(
      id: 'srv_005',
      title: 'شهادة ميلاد',
      shortDescription: 'طلب وإصدار شهادات الميلاد',
      description: 'خدمة إصدار شهادات الميلاد الرسمية بطريقة سريعة وموثوقة.',
      category: ServiceCategory.civil,
      icon: Icons.child_care_rounded,
      color: Color(0xFF9C27B0),
      estimatedDays: 2,
      fee: 30.0,
      rating: 4.9,
      isFeatured: false,
      requirements: [
        'هوية ولي الأمر',
        'تقرير الميلاد من المستشفى',
      ],
      steps: [
        'تقديم الطلب',
        'مراجعة البيانات',
        'استلام الشهادة',
      ],
    ),
    ServiceModel(
      id: 'srv_006',
      title: 'طلب سجل تجاري',
      shortDescription: 'إصدار وتجديد السجلات التجارية',
      description: 'إصدار السجل التجاري للأفراد والمنشآت إلكترونياً.',
      category: ServiceCategory.business,
      icon: Icons.business_center_rounded,
      color: Color(0xFFFF9800),
      estimatedDays: 4,
      fee: 250.0,
      rating: 4.4,
      isFeatured: false,
      requirements: [
        'الهوية الوطنية',
        'عقد التأسيس',
        'إثبات مقر النشاط',
      ],
      steps: [
        'تقديم طلب السجل',
        'رفع الوثائق',
        'سداد الرسوم',
        'استلام السجل',
      ],
    ),
    ServiceModel(
      id: 'srv_007',
      title: 'إثبات قيد دراسي',
      shortDescription: 'إصدار وثائق إثبات القيد من المدارس',
      description: 'الحصول على وثيقة إثبات القيد الدراسي للطلاب بمختلف المراحل.',
      category: ServiceCategory.education,
      icon: Icons.school_rounded,
      color: Color(0xFF00BCD4),
      estimatedDays: 1,
      fee: 0.0,
      rating: 4.7,
      isFeatured: false,
      requirements: [
        'رقم الطالب',
        'إثبات هوية ولي الأمر',
      ],
      steps: [
        'تقديم الطلب',
        'مراجعة المدرسة',
        'إصدار الوثيقة',
      ],
    ),
    ServiceModel(
      id: 'srv_008',
      title: 'تقرير طبي',
      shortDescription: 'إصدار التقارير والفحوصات الطبية',
      description: 'الحصول على تقارير طبية رسمية معتمدة إلكترونياً.',
      category: ServiceCategory.health,
      icon: Icons.medical_services_rounded,
      color: Color(0xFFE53935),
      estimatedDays: 2,
      fee: 50.0,
      rating: 4.3,
      isFeatured: false,
      requirements: [
        'الهوية الوطنية',
        'حجز مسبق في المنشأة الصحية',
      ],
      steps: [
        'حجز موعد',
        'إجراء الفحص',
        'استلام التقرير',
      ],
    ),
    ServiceModel(
      id: 'srv_009',
      title: 'دعم سكني',
      shortDescription: 'طلب الحصول على دعم السكن الحكومي',
      description: 'تقديم طلبات الدعم السكني للأسر المستحقة وفق الضوابط المعتمدة.',
      category: ServiceCategory.housing,
      icon: Icons.home_work_rounded,
      color: Color(0xFF673AB7),
      estimatedDays: 14,
      fee: 0.0,
      rating: 4.6,
      isFeatured: false,
      requirements: [
        'الهوية الوطنية',
        'إثبات الدخل',
        'إثبات الأسرة',
        'صكوك العقارات',
      ],
      steps: [
        'تسجيل البيانات',
        'رفع المرفقات',
        'دراسة الأهلية',
        'إصدار القرار',
      ],
    ),
    ServiceModel(
      id: 'srv_010',
      title: 'رخصة بناء',
      shortDescription: 'إصدار رخص البناء والترميم',
      description: 'الحصول على رخص البناء والترميم للمباني السكنية والتجارية.',
      category: ServiceCategory.housing,
      icon: Icons.architecture_rounded,
      color: Color(0xFF795548),
      estimatedDays: 21,
      fee: 500.0,
      rating: 4.1,
      isFeatured: false,
      requirements: [
        'صك الملكية',
        'المخطط الهندسي',
        'هوية المالك',
        'رفع مساحي',
      ],
      steps: [
        'تقديم الطلب',
        'مراجعة المخططات',
        'التفتيش الميداني',
        'إصدار الرخصة',
      ],
    ),
  ];

  static List<ServiceModel> get featured =>
      all.where((s) => s.isFeatured).toList();

  static List<ServiceModel> byCategory(ServiceCategory category) =>
      all.where((s) => s.category == category).toList();

  static ServiceModel? findById(String id) {
    try {
      return all.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  static List<ServiceCategory> get categories => ServiceCategory.values;
}
