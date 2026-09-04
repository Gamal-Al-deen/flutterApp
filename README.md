# منصة معاملات — Muamalat

> **تطبيق Flutter احترافي لخدمات المعاملات الإلكترونية الرقمية**
> تطبيق تعليمي متكامل مصمم بهوية عربية أصيلة، يدعم اللغة العربية بشكل كامل من اليمين إلى اليسار.

---

## 1. Project Overview

**Muamalat (معاملات)** is a complete, professional Flutter application that simulates an Arabic digital services and e-transactions platform. The application is built as a polished university software engineering project, demonstrating modern UI/UX, clean MVC architecture, native RTL experience, and a coherent product identity.

The name **معاملات** literally translates to *transactions* and **المعاملات والخدمات الرقمية** to *digital services and transactions*. The product is designed to feel like a real Arabic commercial application rather than a collection of disconnected demo screens.

---

## 2. Application Idea

Muamalat is a unified mobile platform that allows users to:

- Browse and discover available digital services.
- Review service details, requirements and processing steps.
- Submit electronic requests / transactions.
- Track the status of submitted transactions in real time.
- Receive notifications about state changes and updates.
- Manage their profile, preferences and settings.

This is a **UI-only simulation**: all data is local mock data, no backend, no real API, no Firebase, and no real authentication.

---

## 3. Target Users

| User | Description |
| --- | --- |
| Citizens | Individuals needing government and civil services |
| Residents | People managing official documents and licenses |
| Students | Learners applying for education-related services |
| Business owners | SMEs handling licensing and registration |

---

## 4. Main Features

- Full Arabic UI with native RTL layout
- 15 distinct screens covering splash, onboarding, auth, services, transactions, notifications and profile
- Local mock data for services, transactions, notifications and users
- Form validation for login, signup and password recovery (Arabic error messages)
- Bottom navigation with 4 sections (الرئيسية / الخدمات / معاملاتي / حسابي)
- Native splash configured through `flutter_native_splash`
- Onboarding completion state persisted with `shared_preferences`
- Favorites toggle on service details
- Transaction creation flow with step-by-step form
- Detailed transaction timeline with progress visualization
- Notification center with read/unread states
- Profile with stats, settings toggles, language and about dialog
- Logout flow that clears the session state

---

## 5. Design Philosophy

- **Product, not screens.** Every screen is part of a single coherent product with shared design language, color system, typography, components, icons and visual hierarchy.
- **Arabic-first.** Designed from the ground up for Arabic users — not an English LTR interface translated back to Arabic.
- **Modern, calm, trustworthy.** Soft blue primary color, generous spacing, consistent rounded corners, subtle shadows.
- **Information density done right.** Each screen has a distinct purpose and the right amount of information for that purpose.

---

## 6. Visual Identity

- **App name:** معاملات (Muamalat)
- **Tagline:** منصة الخدمات الإلكترونية والمعاملات الرقمية
- **Personality:** Trust · Simplicity · Technology · Organization · Speed · Professionalism
- **Logo:** Local `assets/images/logo.png`, geometric diamond inside a white circle on a deep-blue rounded square.

---

## 7. Color Palette

| Role | Token | Hex |
| --- | --- | --- |
| Primary | `AppColors.primary` | `#0F52BA` |
| Primary Dark | `AppColors.primaryDark` | `#0A3D8A` |
| Primary Light | `AppColors.primaryLight` | `#1A7ADA` |
| Secondary | `AppColors.secondary` | `#E91E63` |
| Accent | `AppColors.accent` | `#4CAF50` |
| Background | `AppColors.background` | `#F5F8FF` |
| Surface | `AppColors.surface` | `#FFFFFF` |
| Text Primary | `AppColors.textPrimary` | `#0E1B3A` |
| Text Secondary | `AppColors.textSecondary` | `#5B6B8A` |
| Text Tertiary | `AppColors.textTertiary` | `#8A99B8` |
| Border | `AppColors.border` | `#E3E9F5` |
| Success | `AppColors.success` | `#22A06B` |
| Warning | `AppColors.warning` | `#F59E0B` |
| Error | `AppColors.error` | `#E53935` |

All colors are centralized in `lib/theme/colors.dart`. No raw color values are used directly inside views.

---

## 8. Typography

- **Family:** Cairo (Regular, Medium, SemiBold, Bold)
- **Direction:** RTL
- **Sizes:** 11 / 12 / 13 / 14 / 15 / 16 / 18 / 22 / 24 / 26 / 30
- Registered in `pubspec.yaml` under the `Cairo` font family and applied through the global `TextTheme` in `lib/theme/app_theme.dart`.

---

## 9. Flutter & Dart Versions

| Tool | Version |
| --- | --- |
| Flutter | 3.44.3 (target) — built and verified on 3.35.7 |
| Dart | 3.12.2 (target) — `pubspec.yaml` constraint `>=3.4.0 <4.0.0` to allow resolution on toolchains that ship earlier SDKs while remaining forward-compatible |

The required `shared_preferences: ^2.5.3` and `flutter_native_splash: ^2.4.4` are the only third-party runtime dependencies.

---

## 10. MVC Architecture

The project follows a strict **Model–View–Controller** separation:

- **Model** — Pure data classes (`ServiceModel`, `TransactionModel`, `NotificationModel`, `UserModel`, `OnboardingModel`).
- **View** — UI screens in `lib/views/` and reusable components in `lib/widgets/`. Views only describe layout and delegate logic to controllers.
- **Controller** — One controller per meaningful screen in `lib/controllers/`. Holds form state, filters, pagination, selection logic and side effects.
- **Data** — Mock data is centralized in `lib/data/` (services, transactions, notifications, users, onboarding pages).

No business logic is placed inside views, and no UI layout is placed inside models or controllers.

---

## 11. Project Structure

```text
muamalat/
├── android/                          # Android project
├── ios/                              # iOS project
├── assets/
│   ├── fonts/
│   │   ├── Cairo-Regular.ttf
│   │   ├── Cairo-Medium.ttf
│   │   ├── Cairo-SemiBold.ttf
│   │   └── Cairo-Bold.ttf
│   └── images/
│       ├── logo.png
│       ├── splash.png
│       └── onboarding/
│           ├── onboarding_1.png
│           ├── onboarding_2.png
│           └── onboarding_3.png
├── lib/
│   ├── main.dart                     # App entry point
│   ├── app/
│   │   ├── app.dart                  # MaterialApp + theme + route generation
│   │   └── routes.dart               # Centralized route names
│   ├── controllers/                  # One controller per meaningful screen
│   │   ├── splash_controller.dart
│   │   ├── onboarding_controller.dart
│   │   ├── login_controller.dart
│   │   ├── signup_controller.dart
│   │   ├── forgot_password_controller.dart
│   │   ├── home_controller.dart
│   │   ├── services_controller.dart
│   │   ├── service_details_controller.dart
│   │   ├── create_transaction_controller.dart
│   │   ├── transactions_controller.dart
│   │   ├── transaction_details_controller.dart
│   │   ├── notifications_controller.dart
│   │   └── profile_controller.dart
│   ├── data/                         # Centralized mock data
│   │   ├── services_data.dart
│   │   ├── transactions_data.dart
│   │   ├── notifications_data.dart
│   │   ├── users_data.dart
│   │   └── onboarding_data.dart
│   ├── models/
│   │   ├── service_model.dart
│   │   ├── transaction_model.dart
│   │   ├── notification_model.dart
│   │   ├── user_model.dart
│   │   └── onboarding_model.dart
│   ├── views/                        # 15 separate View files
│   │   ├── splash_view.dart
│   │   ├── onboarding_one_view.dart
│   │   ├── onboarding_two_view.dart
│   │   ├── onboarding_three_view.dart
│   │   ├── login_view.dart
│   │   ├── signup_view.dart
│   │   ├── forgot_password_view.dart
│   │   ├── main_shell.dart           # Bottom-nav container hosting 4 sub-screens
│   │   ├── home_view.dart
│   │   ├── services_view.dart
│   │   ├── service_details_view.dart
│   │   ├── create_transaction_view.dart
│   │   ├── transactions_view.dart
│   │   ├── transaction_details_view.dart
│   │   ├── notifications_view.dart
│   │   ├── profile_view.dart
│   │   └── edit_profile_sheet.dart   # Modal bottom sheet (not a screen)
│   ├── widgets/                      # Reusable components
│   │   ├── app_logo.dart
│   │   ├── app_button.dart
│   │   ├── app_text_field.dart
│   │   ├── service_card.dart
│   │   ├── transaction_card.dart
│   │   ├── notification_card.dart
│   │   ├── section_header.dart
│   │   ├── category_chip.dart
│   │   ├── info_row.dart
│   │   ├── empty_state.dart
│   │   └── onboarding_scaffold.dart
│   ├── theme/
│   │   ├── colors.dart
│   │   └── app_theme.dart
│   └── utils/
│       └── constants.dart
├── test/
│   ├── routes_test.dart
│   └── mock_data_test.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

---

## 12. Screen Inventory (15 Screens)

| # | Screen | View file | Purpose |
| --- | --- | --- | --- |
| 1 | Native Splash | `splash_view.dart` | App branding + onboarding/auth routing |
| 2 | Onboarding — تعريف التطبيق | `onboarding_one_view.dart` | Introduces the platform |
| 3 | Onboarding — اكتشاف الخدمات | `onboarding_two_view.dart` | Highlights service discovery |
| 4 | Onboarding — متابعة المعاملات | `onboarding_three_view.dart` | Highlights transaction tracking + final CTA |
| 5 | تسجيل الدخول | `login_view.dart` | Email + password login with validation |
| 6 | إنشاء حساب | `signup_view.dart` | Full registration with terms acceptance |
| 7 | استعادة كلمة المرور | `forgot_password_view.dart` | Email-based recovery simulation |
| 8 | الرئيسية | `home_view.dart` | Personalized dashboard (greeting, search, quick actions, featured services, categories, recent transactions) |
| 9 | الخدمات | `services_view.dart` | Service discovery (search, categories, grid) |
| 10 | تفاصيل الخدمة | `service_details_view.dart` | Description, requirements, steps, fees, primary CTA |
| 11 | إنشاء معاملة | `create_transaction_view.dart` | Step-by-step form to submit a new transaction |
| 12 | معاملاتي | `transactions_view.dart` | List of all user transactions with status filters |
| 13 | تفاصيل المعاملة | `transaction_details_view.dart` | Full transaction details, progress, timeline |
| 14 | الإشعارات | `notifications_view.dart` | Notification center with read/unread states |
| 15 | الملف الشخصي / الإعدادات | `profile_view.dart` | Profile, settings, preferences, logout |

> The bottom navigation shell (`main_shell.dart`) and the edit-profile bottom sheet (`edit_profile_sheet.dart`) are auxiliary containers, not separate primary screens.

---

## 13. Navigation Flow

```text
Splash
  ├─ first launch  → Onboarding (3 pages)  → ابدأ الآن → Login
  └─ next launch   → Login ──→ (Signup / Forgot Password) ──→ Main Shell
                                                                 │
                                                                 ├─ Home
                                                                 │    ├─ Service Details ──→ Create Transaction ──→ Transaction Details
                                                                 │    ├─ Notifications
                                                                 │    └─ Profile ──→ Edit Profile / Logout
                                                                 │
                                                                 ├─ Services ──→ Service Details ──→ Create Transaction
                                                                 ├─ Transactions ──→ Transaction Details
                                                                 └─ Profile ──→ Edit Profile
```

All routes are centralized in `lib/app/routes.dart` and resolved through `MaterialApp.onGenerateRoute` in `lib/app/app.dart`. No hard-coded route strings are scattered across the project.

---

## 14. RTL Support

The application is fully RTL:

- The root `MaterialApp.builder` wraps every page in a `Directionality(textDirection: TextDirection.rtl)`.
- All text alignment flows from right to left.
- Back arrows, chevrons and navigation icons are flipped automatically.
- Bottom navigation, list rows, form rows and step indicators respect RTL.
- The `EdgeInsetsDirectional` API is used where directional padding is required.

---

## 15. Arabic UI

All visible text is Arabic. Examples:

```text
تسجيل الدخول
إنشاء حساب
الخدمات
معاملاتي
الإشعارات
الملف الشخصي
الإعدادات
متابعة الطلب
تفاصيل الخدمة
إرسال الطلب
```

---

## 16. Mock Data

Mock data lives entirely in `lib/data/`:

- `services_data.dart` — 10 services across 8 categories (documents, licenses, civil, education, health, vehicles, housing, business).
- `transactions_data.dart` — 5 transactions in different states (pending, processing, completed, approved, rejected).
- `notifications_data.dart` — 6 notifications in different categories and read states.
- `users_data.dart` — Demo user used across the app.
- `onboarding_data.dart` — 3 onboarding page contents.

No data is hard-coded inside views.

---

## 17. Reusable Widgets

- `AppLogo` — the brand mark
- `AppButton` — primary / ghost button with optional icon and loading state
- `AppTextField` — consistent form input with label, hint, prefix and suffix icons
- `ServiceCard` — vertical and horizontal variants
- `TransactionCard` — including `StatusChip`
- `NotificationCard` — read/unread states
- `SectionHeader` — used to introduce each section with optional action
- `CategoryChip` — selectable category with optional count
- `InfoRow` — used in details and profile screens
- `EmptyState` — unified empty state component

No duplicated UI between screens.

---

## 18. Form Validation

- **Email:** `RegExp(r'^[\w\.\-+]+@[\w\-]+(\.[\w\-]+)+$')` with Arabic error messages.
- **Password:** required, minimum 6 characters, confirmation must match.
- **Name:** required, minimum 3 characters.
- **Phone:** required, minimum 8 digits.

Validation messages are written in Arabic (e.g. `يرجى إدخال البريد الإلكتروني`, `البريد الإلكتروني غير صحيح`, `كلمة المرور يجب أن تكون 6 أحرف على الأقل`, `كلمتا المرور غير متطابقتين`).

---

## 19. SharedPreferences

`shared_preferences` is used to persist:

- Onboarding completion (`onboarding_completed`)
- Login state (`is_logged_in`)
- User name and email (`user_name`, `user_email`)
- Dark mode preference (`dark_mode`)
- Notification preference (`notif_enabled`)
- Language preference (`language`)

It is **not** used as a database, authentication system, or backend.

---

## 20. Native Splash

Native splash is configured through `flutter_native_splash` in `pubspec.yaml`:

```yaml
flutter_native_splash:
  color: "#0F52BA"
  image: assets/images/logo.png
  android: true
  ios: true
  android_12:
    color: "#0F52BA"
    image: assets/images/logo.png
  web: false
```

The native splash is real, not a fake Flutter screen. To regenerate native splash images after changing the configuration:

```bash
flutter pub run flutter_native_splash:create
```

---

## 21. Responsive Design

- Layouts use `MediaQuery`, `SafeArea`, `Expanded`, `Flexible`, `SingleChildScrollView`, `LayoutBuilder`.
- No fixed `height` / `width` style layouts inside views.
- Bottom navigation and bottom action bars respect safe-area insets.
- `Padding(EdgeInsetsDirectional.only(...))` is used where directional spacing is required.

---

## 22. Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  cupertino_icons: ^1.0.8
  shared_preferences: ^2.5.3
  flutter_native_splash: ^2.4.4

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

No HTTP, no REST, no Firebase, no cloud services, no real database. Every additional dependency has a clear purpose and was added consciously.

---

## 23. Installation & Running

```bash
# 1. Extract the project
unzip muamalat_flutter_project.zip
cd muamalat

# 2. Install dependencies
flutter pub get

# 3. Generate native splash (optional, already configured)
dart run flutter_native_splash:create

# 4. Run the app
flutter run
```

Tested with Flutter 3.35.7 (Dart 3.9.2) on Android.

---

## 24. Testing

```bash
flutter analyze
flutter test
```

Both commands should complete without errors. The current state:

- `flutter analyze` → **No issues found**
- `flutter test` → **7/7 tests passing**

Tests cover:

- App constants and route definitions
- Mock data integrity (services, transactions, notifications, users)

---

## 25. Development Process

| Step | Activity |
| --- | --- |
| 1 | Selecting the application concept (منصة معاملات) |
| 2 | Defining target users (citizens, residents, students, business owners) |
| 3 | Creating the information architecture |
| 4 | Creating the 15-screen map |
| 5 | Creating the brand identity (logo, colors, typography) |
| 6 | Creating the logo (geometric diamond in a circle on brand blue) |
| 7 | Selecting the color palette (deep blue + soft surface + accent) |
| 8 | Selecting Cairo typography (Regular / Medium / SemiBold / Bold) |
| 9 | Organizing assets (images, fonts, splash) |
| 10 | Implementing MVC (Models, Views, Controllers, Data) |
| 11 | Creating Models |
| 12 | Creating mock Data |
| 13 | Creating Controllers |
| 14 | Creating individual Views (one file per screen) |
| 15 | Creating reusable Widgets |
| 16 | Creating centralized Theme |
| 17 | Implementing routing |
| 18 | Implementing onboarding |
| 19 | Implementing SharedPreferences |
| 20 | Implementing form validation |
| 21 | Testing responsiveness |
| 22 | Running `flutter analyze` |
| 23 | Fixing issues |
| 24 | Performing final UI/UX review |
| 25 | Packaging the project as `muamalat_flutter_project.zip` |

---

## 26. Final Verification Checklist

- [x] Exactly 15 screens (1 splash + 3 onboarding + 11 application/auth)
- [x] Every screen in its own View file
- [x] No multiple screens inside one Dart file
- [x] Controllers properly separated
- [x] MVC clearly implemented
- [x] Arabic UI throughout
- [x] RTL support
- [x] Cairo font (Regular, Medium, SemiBold, Bold)
- [x] Professional typography and branding
- [x] Local logo + local images + local onboarding images
- [x] Native splash (flutter_native_splash)
- [x] SharedPreferences (onboarding state, login state, preferences)
- [x] Login / Signup / Forgot Password with validation
- [x] Bottom Navigation with 4 items
- [x] Services + Service Details + Create Transaction + Transactions + Transaction Details
- [x] Notifications + Profile
- [x] Mock data centralized in `lib/data/`
- [x] Reusable widgets in `lib/widgets/`
- [x] Centralized colors in `lib/theme/colors.dart`
- [x] Centralized theme in `lib/theme/app_theme.dart`
- [x] Responsive UI (no fixed hard-coded sizes)
- [x] No backend, no API, no Firebase, no database
- [x] No unnecessary dependencies
- [x] `flutter pub get` succeeds
- [x] `flutter analyze` clean
- [x] `flutter test` passing
- [x] Assets verified (logo, splash, onboarding_1/2/3, fonts)
- [x] RTL reviewed
- [x] UI reviewed
- [x] README created
- [x] Final architecture reviewed
- [x] Complete ZIP created

---

## 27. License

This is a university-level educational project. The mock data, branding and design are original work intended for academic demonstration.
