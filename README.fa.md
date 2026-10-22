<div dir="rtl" align="right">

[English](README.md) | [فارسی](README.fa.md)

# محاسبه‌گر BMI

یک اپ ساده با Flutter و رابط فارسی برای محاسبهٔ شاخص تودهٔ بدنی. وزن و قد را وارد کنید و روی «محاسبه کن» بزنید تا مقدار BMI، پیام وضعیت وزن و دو نشانگر رنگی را ببینید.

[![Flutter](https://img.shields.io/badge/Flutter-SDK-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart SDK](https://img.shields.io/badge/Dart-%5E3.12.0-0175C2?logo=dart&logoColor=white)](pubspec.yaml)
[![License: MIT](https://img.shields.io/badge/License-MIT-green)](LICENSE)

نام پکیج `bmi_calculator` و نسخهٔ پروژه `1.0.0+1` است. فایل‌های اجرای Android، وب و Windows در مخزن وجود دارند؛ فایل‌های اجرای iOS، macOS و Linux هنوز اضافه نشده‌اند.

## تصاویر برنامه

| صفحهٔ محاسبه | کمبود وزن | وزن نرمال | اضافه‌وزن |
| :---: | :---: | :---: | :---: |
| <img src="assets/screenshots/main-screen.png" width="200" alt="صفحهٔ محاسبه قبل از وارد کردن وزن و قد"/> | <img src="assets/screenshots/Malnutrition.png" width="200" alt="نتیجهٔ کمبود وزن با BMI برابر با 17.04"/> | <img src="assets/screenshots/Normal%20weight.png" width="200" alt="نتیجهٔ وزن نرمال با BMI برابر با 23.67"/> | <img src="assets/screenshots/Overweight.png" width="200" alt="نتیجهٔ اضافه‌وزن با BMI برابر با 37.87"/> |

این‌ها همان تصاویر موجود در پوشهٔ `assets/screenshots/` هستند. نام اصلی تصویر کمبود وزن، یعنی `Malnutrition.png`، حفظ شده است؛ خود برنامه فقط می‌گوید وزن کمتر از حد نرمال است. تصاویر برای مستندات استفاده می‌شوند و جزو تصاویر بسته‌بندی‌شدهٔ اپ نیستند.

## قابلیت‌ها

- ورود وزن و قد در یک صفحه، با درخواست کیبورد عددی.
- محاسبهٔ BMI و نمایش نتیجه تا دو رقم اعشار.
- پیام‌های فارسی برای کمبود وزن، وزن نرمال و اضافه‌وزن.
- دو نوار قرمز و سبز که عرضشان با توجه به نتیجه تغییر می‌کند.
- فونت داخلی `dana`، رنگ‌های مشترک و رابط Material با امکان اسکرول.
- محاسبه داخل خود اپ، بدون حساب کاربری، بک‌اند، درخواست شبکه یا ذخیرهٔ تاریخچه.

## روش استفاده

وزن را بر حسب **کیلوگرم** و قد را بر حسب **متر** وارد کنید. مثلاً با وارد کردن `75` و `1.78` و زدن «محاسبه کن»، نتیجه `23.67` می‌شود. قد مستقیم در فرمول استفاده می‌شود؛ پس `1.78` وارد کنید، نه `178`.

<div dir="ltr" align="left">

```text
BMI = weight_kg / (height_m * height_m)
```

</div>

بازه‌های تعریف‌شده در کد فعلی:

- کمتر از `18.5`: کمبود وزن.
- از `18.5` تا `25`، با احتساب هر دو مقدار: وزن نرمال.
- بیشتر از `25`: اضافه‌وزن.

این بازه‌ها رفتار فعلی برنامه را توضیح می‌دهند، نه یک دسته‌بندی کامل پزشکی. دستهٔ جداگانه‌ای برای چاقی وجود ندارد و BMI به‌تنهایی تشخیص پزشکی نیست.

اعتبارسنجی ورودی هنوز پیاده‌سازی نشده است. عدد مثبت، رقم‌های انگلیسی (`0–9`) و نقطه برای اعشار وارد کنید. ورودی خالی یا غیرعددی می‌تواند خطای تبدیل عدد ایجاد کند؛ صفر و عدد منفی هم رد نمی‌شوند. فیلدها برچسب واحد ندارند و قد را از سانتی‌متر به متر تبدیل نمی‌کنند.

## تکنولوژی‌ها و معماری

پروژه ساختار ساده‌ای بر اساس صفحه‌ها دارد و از Clean Architecture یا MVVM استفاده نمی‌کند. کلاس `Application`، ویجت `MaterialApp` و تم فونت را می‌سازد. کنترلرهای ورودی، محاسبه، متن نتیجه و عرض نشانگرها در `HomeScreen` قرار دارند. برای State Management از `StatefulWidget` و `setState` خود Flutter استفاده شده و لایه‌ای مثل BLoC، Provider یا Riverpod وجود ندارد.

<div dir="ltr" align="left">

```text
lib/
├── main.dart                         # App entry point and theme
├── constants/
│   └── constants.dart                # Shared colors built with HexColor
├── screens/
│   └── home_screen.dart              # Inputs, BMI logic, and local state
└── widgets/
    ├── background_shape_left.dart    # Green positive indicator
    └── background_shape_right.dart   # Red negative indicator

assets/
├── fonts/
│   └── dm.ttf                        # Registered as the dana font family
└── screenshots/                      # README screenshots

test/
└── widget_test.dart                   # Original counter-template test
```

</div>

در این ساختار، `main.dart` نقطهٔ شروع اپ و محل تنظیم تم است. پوشهٔ `constants/` رنگ‌های مشترک را نگه می‌دارد، `screens/` شامل صفحهٔ محاسبه و وضعیت آن است و `widgets/` دو نشانگر سبز و قرمز را جدا می‌کند. فونت در `assets/fonts/` و تصاویر README در `assets/screenshots/` قرار دارند. فایل تست هم هنوز همان تست اولیهٔ شمارنده است.

### وابستگی‌ها

نسخه‌های زیر محدودیت‌های تعریف‌شده در `pubspec.yaml` هستند؛ نسخه‌های نصب‌شده در `pubspec.lock` ثبت شده‌اند.

- **`flutter` از SDK:** ویجت‌های Material، تم و اجرای اپ.
- **`hexcolor: ^3.1.3`:** ساخت رنگ‌های مشترک رابط از کدهای هگز.
- **`cupertino_icons: ^1.0.8`:** مجموعهٔ آیکون‌های در دسترس؛ صفحهٔ فعلی محاسبه از آن استفاده نمی‌کند.
- **`flutter_test` از SDK، برای توسعه:** ابزارهای تست ویجت.
- **`flutter_lints: ^6.0.0`، برای توسعه:** قوانین lint که از طریق `analysis_options.yaml` فعال شده‌اند.

پکیجی برای شبکه، ذخیره‌سازی محلی، State Management خارجی یا تولید کد وجود ندارد.

## راه‌اندازی پروژه

### ۱. آماده‌سازی Flutter

[Flutter SDK](https://docs.flutter.dev/install) را نصب کنید و پوشهٔ `bin` آن را به `PATH` اضافه کنید. پروژه به Dart با محدودیت **`^3.12.0`** نیاز دارد؛ یعنی نسخهٔ `3.12.0` یا بالاتر و کمتر از `4.0.0`. نسخه‌ای از Flutter را انتخاب کنید که Dart سازگار با این محدودیت را همراه داشته باشد. Dart همراه Flutter نصب می‌شود و نیازی به نصب جداگانه نیست.

<div dir="ltr" align="left">

```bash
flutter --version
flutter doctor
```

</div>

برای Android، به Android SDK و یک شبیه‌ساز یا دستگاه متصل نیاز دارید. برای اجرای وب از Chrome استفاده کنید. برای اجرای دسکتاپ Windows، نرم‌افزار Visual Studio را با ورک‌لود **Desktop development with C++** نصب کنید. وجود فایل‌های اجرای هر پلتفرم به معنی تست‌شدن برنامه روی همهٔ آن‌ها نیست.

### ۲. دریافت مخزن

<div dir="ltr" align="left">

```bash
git clone https://github.com/mehrshadkhv/BMI_Calculator.git
cd BMI_Calculator
```

</div>

اگر پروژه را از قبل روی سیستم دارید، کافی است ترمینال را در ریشهٔ همان پوشه باز کنید.

### ۳. نصب وابستگی‌ها

<div dir="ltr" align="left">

```bash
flutter pub get
```

</div>

فونت از قبل در `pubspec.yaml` تعریف شده است. پروژه وابستگی `build_runner` ندارد و نیازی به اجرای دستور تولید کد نیست. کلید API، فایل تنظیمات محیطی یا راه‌اندازی بک‌اند هم لازم نیست.

### ۴. اجرای برنامه

<div dir="ltr" align="left">

```bash
flutter devices
flutter run
```

</div>

برای انتخاب یک دستگاه مشخص، شناسهٔ آن را به دستور بدهید:

<div dir="ltr" align="left">

```bash
flutter run -d <device-id>
```

</div>

برای فایل‌های اجرای وب یا Windows که در پروژه وجود دارند:

<div dir="ltr" align="left">

```bash
flutter run -d chrome
flutter run -d windows
```

</div>

## بررسی‌های توسعه

<div dir="ltr" align="left">

```bash
flutter analyze
flutter test
```

</div>

فایل `test/widget_test.dart` هنوز تست اولیهٔ شمارندهٔ Flutter است. این تست دنبال متن شمارنده و دکمهٔ افزودن می‌گردد که در محاسبه‌گر وجود ندارند؛ بنابراین باید جایگزین شود تا بتوان به تست‌ها به‌عنوان پوشش رفتار محاسبه‌گر تکیه کرد. فعلاً تست اختصاصی برای BMI نوشته نشده است.

## آمار زبان‌های مخزن در GitHub

فایل [`.gitattributes`](.gitattributes) در ریشهٔ پروژه، فایل‌های پایهٔ Android، iOS، وب، Linux، macOS و Windows را از آمار زبان‌های GitHub Linguist کنار می‌گذارد. فایل‌های `*.g.dart` و `*.freezed.dart` هم به‌عنوان کد تولیدشده علامت‌گذاری شده‌اند. به این ترتیب آمار روی کد Dart دست‌نویس متمرکز می‌شود، بدون اینکه فایل‌های پلتفرم حذف شوند یا روش بیلد اپ تغییر کند. GitHub بعد از commit و push و هنگام محاسبهٔ دوبارهٔ آمار مخزن، این تنظیمات را اعمال می‌کند.

## مجوز

پروژه با [مجوز MIT](LICENSE) منتشر شده است. حق نشر © ۲۰۲۶ متعلق به مهرشاد خدویردی‌زاده (Mehrshad Khodavirdizadeh) است.

</div>
