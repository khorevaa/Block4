﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	//{{__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
	// Данный фрагмент построен конструктором.
	// При повторном использовании конструктора, внесенные вручную изменения будут утеряны!!!

	// регистр ТоварыНаСкладах Расход
	Движения.ТоварыНаСкладах.Записывать = Истина;
	Движения.ТоварыНаСкладах.Очистить();
	Движения.ТоварыНаСкладах.Записать();
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	ПродажаТовары.Номенклатура КАК Номенклатура,
	               |	СУММА(ПродажаТовары.Количество) КАК Количество
	               |ПОМЕСТИТЬ вт
	               |ИЗ
	               |	Документ.Продажа.Товары КАК ПродажаТовары
	               |ГДЕ
	               |	ПродажаТовары.Ссылка = &Ссылка
	               |
	               |СГРУППИРОВАТЬ ПО
	               |	ПродажаТовары.Номенклатура
	               |;
	               |
	               |////////////////////////////////////////////////////////////////////////////////
	               |ВЫБРАТЬ
	               |	вт.Номенклатура КАК Номенклатура,
	               |	ТоварыНаСкладахОстатки.Партия КАК Партия,
	               |	ЕСТЬNULL(ТоварыНаСкладахОстатки.КоличествоОстаток, 0) КАК КоличествоОстаток,
	               |	вт.Количество КАК КоличествоВДокументе
	               |ИЗ
	               |	вт КАК вт
	               |		ЛЕВОЕ СОЕДИНЕНИЕ РегистрНакопления.ТоварыНаСкладах.Остатки(&МоментВремени, ) КАК ТоварыНаСкладахОстатки
	               |		ПО (ТоварыНаСкладахОстатки.Номенклатура = вт.Номенклатура)
	               |			И (ТоварыНаСкладахОстатки.Склад = &Склад)
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	Номенклатура,
	               |	Партия
	               |ИТОГИ
	               |	СУММА(КоличествоОстаток),
	               |	МАКСИМУМ(КоличествоВДокументе)
	               |ПО
	               |	Номенклатура";
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("Склад", Ссылка.Склад);
	Запрос.УстановитьПараметр("МоментВремени", Новый Граница(Ссылка.МоментВремени(), ВидГраницы.Исключая));
	Результат = Запрос.Выполнить();
	ВыборкаПоНоменклатуре = Результат.Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Номенклатура", "все");
	ТекстСообщения = "";
	Пока ВыборкаПоНоменклатуре.Следующий() Цикл
		Разница = ВыборкаПоНоменклатуре.КоличествоОстаток - ВыборкаПоНоменклатуре.КоличествоВДокументе;
		Если Разница < 0 Тогда
			ТекстСообщения = ТекстСообщения+Символы.ПС+"По номенклатуре: "+ВыборкаПоНоменклатуре.Номенклатура+" на складе нет нужного количества, не хватает: "+Разница;
			Продолжить;
		КонецЕсли; 
		Списать = ВыборкаПоНоменклатуре.КоличествоВДокументе;
		Выборка = ВыборкаПоНоменклатуре.Выбрать();
		Пока Выборка.Следующий() Цикл
			Движение = Движения.ТоварыНаСкладах.Добавить();
			Движение.ВидДвижения 	= ВидДвиженияНакопления.Расход;
			Движение.Период 		= Дата;
			Движение.Склад 			= Склад;
			Движение.Номенклатура 	= Выборка.Номенклатура;
			Движение.Партия			= Выборка.Партия;
			Движение.Количество 	= Мин(Списать, Выборка.КоличествоВДокументе);
			Списать = Списать - Движение.Количество;
			Если Списать <= 0 Тогда
				Прервать;
			КонецЕсли; 
		КонецЦикла; 
	КонецЦикла; 		
	
	Если НЕ ПустаяСтрока(ТекстСообщения) Тогда
		Отказ = Истина;
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = ТекстСообщения;
		Сообщение.Сообщить(); 
	КонецЕсли; 
	
	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
