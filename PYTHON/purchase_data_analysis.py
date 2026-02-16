purchases = [
    {"item": "apple", "category": "fruit", "price": 1.2, "quantity": 10},
    {"item": "banana", "category": "fruit", "price": 0.5, "quantity": 5},
    {"item": "milk", "category": "dairy", "price": 1.5, "quantity": 2},
    {"item": "bread", "category": "bakery", "price": 2.0, "quantity": 3},
]

def total_revenue(purchases):

    return sum([purchase['price']*purchase['quantity'] for purchase in purchases])


def items_by_category(purchases):

    dct = {}
    for purchase in purchases:
        if purchase['category'] not in dct:
            dct[purchase['category']] = [purchase['item']]
        else:
            dct[purchase['category']].append(purchase['item'])
    return dct

def expensive_purchases(purchases, min_price):

    return [purchase for purchase in purchases if purchase['price'] >= min_price]

def average_price_by_category(purchases):

    prices_by_category = {}
    for purchase in purchases:
        category = purchase['category']
        price = purchase['price']

        if category not in prices_by_category:
            prices_by_category[category] = [price]
        else:
            prices_by_category[category].append(price)

    avg_prices = {}
    for category, prices in prices_by_category.items():
        avg_prices[category] = sum(prices) / len(prices)

    return avg_prices


def most_frequent_category(purchases):

    quantity_by_category = {}

    for purchase in purchases:
        category = purchase['category']
        quantity = purchase['quantity']

        if category not in quantity_by_category:
            quantity_by_category[category] = quantity
        else:
            quantity_by_category[category] += quantity

    max_category = None
    max_quantity = -1

    for category, total_quantity in quantity_by_category.items():
        if total_quantity > max_quantity:
            max_quantity = total_quantity
            max_category = category

    return max_category

min_price = 1.2

total = total_revenue(purchases)
by_category = items_by_category(purchases)
expensive = expensive_purchases(purchases, min_price)
avg_prices = average_price_by_category(purchases)
frequent_category = most_frequent_category(purchases)

print(f"Общая выручка: {total}")
print(f"Товары по категориям: {by_category}")
print(f"Покупки дороже {min_price}: {expensive}")
print(f"Средняя цена по категориям: {avg_prices}")
print(f"Категория с наибольшим количеством проданных товаров: {frequent_category}")