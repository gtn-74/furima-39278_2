## usersテーブル

| Column              | Type       | Options                        |
| ------------------  | ---------- | ------------------------------ |
| nickname            | string     | null: false                    |
| email               | string     | null: false  unique: true      |
| encrypted_password  | string     | null: false                    |
| family_name         | string     | null: false                    |
| first_name          | string     | null: false                    |
| family_name_kana    | string     | null: false                    |
| first_name_kana     | string     | null: false                    |
| birth_day           | date       | null: false                    |

### Association
- has_many :items
- has_many :orders

## itemsテーブル
| Column              | Type       | Options                        |
| ------------------  | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| content             | text       | null: false                    |
| category_id         | integer    | null: false                    |
| sale_id             | integer    | null: false                    |
| shopping_id         | integer    | null: false                    |
| prefecture_id       | integer    | null: false                    |
| shopping_day_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false  foreign_key: true |

### Association
- belongs_to :user
- has_one :order

## ordersテーブル
| Column              | Type       | Options                        |
| ------------------  | ---------- | ------------------------------ |
| item                | references | null: false  foreign_key: true |
| user                | references | null: false  foreign_key: true |

### Association
- belongs_to :item
- belongs_to :user
- has_one :address


## addressesテーブル
| Column              | Type       | Options                        |
| ------------------  | ---------- | ------------------------------ |
| order               | references | null: false  foreign_key: true |
| postal_code         | string     | null: false                    |
| prefecture_id       | integer    | null: false                    |
| city                | string     | null: false                    |
| address             | string     | null: false                    |
| building_name       | string     |                                |
| phone_number        | string     | null: false                    |

### Association
- belongs_to :order