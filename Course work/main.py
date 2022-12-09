import numpy as np
from scipy.stats import hypergeom, nhypergeom
import matplotlib.pyplot as plt

# Тема курсової роботи - Negative hypergeometric distribution.
# Припустимо що у нас є колекція з 20 тварин 7 з яких - собаки.
# Якщо ми хочемо дізнатися ймовірність знаходження певноЇ кількості собак (successes) у вибірці з рівно 12 тваринами
# які не є собаками (failures) - ми можемо ініціалізувати заморожений розподіл
# і побудувати графік функції маси ймовірності:

M, n, r = [20, 7, 12]
rv = nhypergeom(M, n, r)
x = np.arange(0, n+2)
pmf_dogs = rv.pmf(x)

fig = plt.figure()
ax = fig.add_subplot(111)
ax.plot(x, pmf_dogs, 'bo')
ax.vlines(x, 0, pmf_dogs, lw=2)
ax.set_xlabel('# собак у нашій групі з 12 невдачами')
ax.set_ylabel('Функція маси ймовірності НГР')
plt.show()

# Замість використання замороженого розподілу ми також можемо
# безпосередньо використовувати негативний гіпергеометричний розподіл.
# Наприклад щоб отримати функцію маси ймовірності, використовуємо:

prb = nhypergeom.pmf(x, M, n, r)
print(f"Функцію маси ймовірності: {prb}\n")

# А щоб генерувати випадкові числа:

R = nhypergeom.rvs(M, n, r, size=10)
print(f"Випадкові числа: {R}\n")

# Перевірка зв’язку між гіпергеометричним і негативним гіпергеометричним розподілами

M, n, r = 45, 13, 8
k = 6
print("Зв’язок між гіпергеометричним розподілом і негативним гіпергеометричним розподілом")
print(nhypergeom.pmf(k, M, n, r))
print(hypergeom.pmf(k, M, n, k+r-1) * (M - n - (r-1)) / (M - (k+r-1)))