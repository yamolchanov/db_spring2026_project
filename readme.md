# Информационная система ГИБДД

Реляционная база данных для автоматизации учёта нарушений ПДД, штрафов и транспортных средств в подразделениях ГИБДД.

---

## Структура проекта

```
.
├── build_db.sh             # Скрипт развёртывания БД
├── data/
│   ├── db.sql               # Создание всех таблиц
│   └── synthetic_data.sql   # Синтетические тестовые данные
├── base_part/
│   └── scripts/             # SQL-запросы
│       ├── README.md
│       ├── top_violators.sql
│       ├── top_articles.sql
│       ├── expired_license.sql
│       ├── unpaid_fines.sql
│       ├── officer_activity.sql
│       ├── violations_by_city.sql
│       ├── vehicle_violation_story.sql
│       ├── disputed_fines.sql
│       ├── fines_by_month.sql
│       └── dep_summary.sql
├── advanced_part/
│   ├── indexes/
│   │   ├── indexes.sql
│   │   └── README.md
│   ├── procedure/
│   │   ├── driver_summary.sql
│   │   ├── expire_licenses.sql
│   │   ├── record_violation.sql
│   │   └── README.md
│   ├── triggers/
│   │   ├── license_expire.sql
│   │   ├── violation_license.sql
│   │   └── README.md
│   ├── views/
│   │   ├── open_fines.sql
│   │   ├── dept_monthly_stats.sql
│   │   └── README.md
├── schemas/
│   ├── concept_schema.png   # Концептуальная схема БД
│   ├── logic_scheme.png     # Логическая схема
│   └── physics_scheme.png   # Физическая схема
└── prompt.md                # Промпт для генерации синтетических данных
```

---

## Схема базы данных

База данных содержит 9 таблиц:

| Таблица | Описание |
|---|---|
| `persons` | Физические лица: водители и сотрудники |
| `driving_license` | Водительские удостоверения (категория, срок, статус) |
| `departments` | Подразделения ГИБДД |
| `legal_entity` | Юридические лица — владельцы транспорта |
| `vehicle` | Транспортные средства |
| `registration` | Регистрационные данные (госномер, отдел) |
| `officers` | Инспекторы ГИБДД |
| `article` | Статьи КоАП (код, описание, диапазон штрафа) |
| `violation` | Зафиксированные нарушения |
| `fine` | Штрафы по нарушениям |

Статусы водительских прав: `active` / `expired` / `suspended`  
Статусы штрафов: `paid` / `unpaid` / `disputed`

---

## Скрипт для развёртывания

Чтобы быстро создать БД и загрузить данные, используйте скрипт:

```bash
./build_db.sh
```

Он создаёт базу `traffic_violations`: применяет [data/db.sql], настраивает индексы, триггеры, процедуры, представления и загружает тестовые данные из [data/synthetic_data.sql](data/synthetic_data.sql).

---

## Запросы

| Файл | Что показывает |
|---|---|
| `top_violators.sql` | Топ нарушителей по сумме штрафов |
| `top_articles.sql` | Самые частые статьи КоАП |
| `expired_license.sql` | Нарушения с просроченными или аннулированными правами |
| `unpaid_fines.sql` | Неоплаченные штрафы с контактами и госномером |
| `officer_activity.sql` | Активность каждого инспектора |
| `violations_by_city.sql` | Нарушения и суммы штрафов по городам |
| `vehicle_violation_story.sql` | История нарушений по каждому ТС |
| `disputed_fines.sql` | Оспариваемые штрафы с деталями |
| `fines_by_month.sql` | Динамика штрафов по месяцам |
| `dep_summary.sql` | Сводка по отделам: инспекторы, нарушения, сборы |

---

## Тестовые данные

Синтетические данные (`data/synthetic_data.sql`) содержат по 10 записей в каждой таблице.

---