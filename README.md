# Tabor Chat

Ай-нане-нане!! Табор уходит в небо.


### Кодогенерация

Кодогенерация: `flutter pub run build_runner build --delete-conflicting-outputs`

### Генераторы для натива
---
`flutter pub pub run flutter_native_splash:create` - Генерация сплеш скрина

`flutter pub run flutter_launcher_icons:main` - Генерация логотипа

---

### Генератор иконок

---

Установка: `pub global activate icon_font_generator`

Структура в проекте

```
project
└── icons   # Иконки для генерации
│   ├── icon1.svg
│   └── icon2.svg
└───lib     # Класс иконок для импорта
│   └── core
│       └── resources
│            └── ui_icons.g.dart
└── assets  # Ресурс иконок
    └── icons
        └── ui_icons.ttf
```

Запуск:
`icon_font_generator --from=resources/icons --class-name=UiIcons --out-font=assets/icons/ui_icons.ttf --out-flutter=lib/core/resources/ui_icons.g.dart`

---

### Генератор ресурсов

Активация: `pub global activate flutter_asset_generator`

```
project
└── assets  # Генерирует класс из всех папок в assets
│   └── folder1...N
└───lib     # Класс для ресурсов
│   └── src
│       └── resources
│            └── resource.g.dart
```

Запуск: `fgen --no-watch --no-preview --output lib\core\resources\resource.g.dart`
---

### Локализации

```
project
└── assets  
│   └── translations # папка с локализациями
└───lib     # Класс для ресурсов
│   └── core
│       └── localization
│            └── locale_keys.g.dart # Кодогенированные ключи локалей
```

Запуск генерации ключей локализации:
`flutter pub run easy_localization:generate --format keys --source-dir "assets/translations" --source-file "ru.json" --output-dir "lib/core/localization" --output-file "locale_keys.g.dart"`