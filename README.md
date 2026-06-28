# ADM (Automated Data-Goy Machine)


## ساختار پروژه

```text
adm/
├── config/              # تنظیمات سیستم و شبکه
├── docs/                # مستندات فنی (Sphinx)
│   ├── build/           # خروجی‌های تولید شده مستندات
│   ├── Makefile         # دستورات ساخت مستندات
│   ├── make.bat         # اسکریپت ویندوز برای ساخت مستندات
│   └── source/          # منابع مستندات
│       ├── conf.py      # تنظیمات پیکربندی اسفنیکس
│       ├── index.rst    # فایل اصلی مستندات
│       ├── _static/     # فایل‌های ایستا (عکس‌ها، CSS)
│       ├── _templates/  # قالب‌های سفارشی اسفنیکس
│       └── topics/      # دسته‌بندی موضوعات فنی
│           ├── architecture/
│           ├── contributing/
│           ├── deployment/
│           ├── hardware/ (assembly, fabrication, specs)
│           ├── software/ (backend, firmware, frontend)
│           └── troubleshooting/
├── hardware/            # فایل‌های طراحی و تولید سخت‌افزار
│   ├── assembly/        # نقشه‌های مونتاژ
│   └── fabrication/     # نقشه‌های ساخت بدنه (CNC/لیزر)
├── LICENSE              # لایسنس پروژه
├── logs/                # لاگ‌های عملیاتی و دیباگ
├── README.md            # معرفی پروژه
├── scripts/             # اسکریپت‌های اتوماسیون
├── src/                 # کدهای منبع
│   ├── backend/         # منطق سرور و مدیریت محتوا
│   ├── firmware/        # نرم‌افزار سیستم‌های نهفته
│   ├── frontend/        # رابط کاربری (UI)
│   └── shared/          # توابع و کتابخانه‌های مشترک
├── tests/               # تست‌های یکپارچه‌سازی و واحد
└── VERSION              # نسخه فعلی پروژه