﻿# encoding: utf-8
# language: ru

@tree

Функционал: Продажа товара
	Как Продавец
	Хочу фиксировать факты продажи товара покупателям
	Чтобы иметь информацию по продажам

Контекст: 
	Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий


Сценарий: Заполнение обязательных реквизитов документа Продажа
	Допустим я создал новый документ "Продажа"
		Когда Я нажимаю кнопку командного интерфейса "Продажа"
		Тогда открылось окно "Продажа"
		И     я нажимаю на кнопку "Создать"
		Тогда открылось окно "Продажа (создание)"

	Я заполняю шапку
		И     я открываю выпадающий список "Контрагент"
		И     я выбираю значение реквизита "Контрагент" из формы списка
		Тогда открылось окно "Контрагенты"
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Наименование' |
		| '2Контрагент'  |
		И     В форме "Контрагенты" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		
		И     я открываю выпадающий список "Склад"
		И     я выбираю значение реквизита "Склад" из формы списка
		Тогда открылось окно "Склады"
		И     В форме "Склады" в таблице "Список" я перехожу к строке:
		| 'Наименование'   |
		| 'Склад отгрузки' |
		И     В форме "Склады" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
	
	
	
Сценарий: остатка на складе хватает
	Допустим я Подготавливаю окружение
	Когда Я нажимаю кнопку командного интерфейса "Продажа"
	Тогда открылось окно "Продажа"
	И     я нажимаю на кнопку "Создать"
	Заполнение шапки
		Тогда открылось окно "Продажа (создание)"
		И     я открываю выпадающий список "Контрагент"
		И     я выбираю значение реквизита "Контрагент" из формы списка
		Тогда открылось окно "Контрагенты"
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000001' | 'Контрагент1'  |
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000002' | '2Контрагент'  |
		И     В форме "Контрагенты" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     я открываю выпадающий список "Склад"
		И     я выбираю значение реквизита "Склад" из формы списка
		Тогда открылось окно "Склады"
		И     В форме "Склады" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000002' | 'Склад отгрузки' |
		И     В форме "Склады" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     в поле "Комментарий" я ввожу текст "vanessa"
	Заполнение ТабЧасти
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'    |
		| '000000004' | 'Ручка шариковая' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "10,000"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "10,00"
		И     я перехожу к следующему реквизиту
		И     В форме "Продажа * от *" в ТЧ "Товары" я завершаю редактирование строки
		И     я нажимаю на кнопку "Провести и закрыть"
		Тогда открылось окно "Продажа"
		
Сценарий: остатка на складе не хватает
	Допустим я Подготавливаю окружение
	Когда Я нажимаю кнопку командного интерфейса "Продажа"
	Тогда открылось окно "Продажа"
	И     я нажимаю на кнопку "Создать"
	Заполнение шапки
		Тогда открылось окно "Продажа (создание)"
		И     я открываю выпадающий список "Контрагент"
		И     я выбираю значение реквизита "Контрагент" из формы списка
		Тогда открылось окно "Контрагенты"
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000001' | 'Контрагент1'  |
		И     В форме "Контрагенты" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование' |
		| '000000002' | '2Контрагент'  |
		И     В форме "Контрагенты" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     я открываю выпадающий список "Склад"
		И     я выбираю значение реквизита "Склад" из формы списка
		Тогда открылось окно "Склады"
		И     В форме "Склады" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'   |
		| '000000002' | 'Склад отгрузки' |
		И     В форме "Склады" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     в поле "Комментарий" я ввожу текст "vanessa"
	Заполнение ТабЧасти
		И     в ТЧ "Товары" я нажимаю на кнопку "Добавить"
		И     в ТЧ "Товары" я выбираю значение реквизита "Номенклатура" из формы списка
		Тогда открылось окно "Номенклатура"
		И     В форме "Номенклатура" в таблице "Список" я перехожу к строке:
		| 'Код'       | 'Наименование'    |
		| '000000004' | 'Ручка шариковая' |
		И     В форме "Номенклатура" в ТЧ "Список" я выбираю текущую строку
		Тогда открылось окно "Продажа (создание) *"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Количество"
		И     в ТЧ "Товары" в поле "Количество" я ввожу текст "40,000"
		И     я перехожу к следующему реквизиту
		И     в ТЧ "Товары" я активизирую поле "Цена"
		И     в ТЧ "Товары" в поле "Цена" я ввожу текст "10,00"
		И     я перехожу к следующему реквизиту
		И     В форме "Продажа * от *" в ТЧ "Товары" я завершаю редактирование строки
		И     я нажимаю на кнопку "Провести и закрыть"
	Тогда Проверить сообщение пользователю
	
