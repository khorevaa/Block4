﻿//начало текста модуля

///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯПодготавливаюОкружение()","ЯПодготавливаюОкружение","Допустим я Подготавливаю окружение");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ПроверитьСообщениеПользователю()","ПроверитьСообщениеПользователю","Тогда Проверить сообщение пользователю");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////

&НаКлиенте
Функция ПолучитьПутьКФайлОтносительноКаталогоFeatures(ИмяФайлаСРасширением)
	ПутьКФайлу = "";
	
	СостояниеVanessaBehavior = Ванесса.ПолучитьСостояниеVanessaBehavior();
	
	ПутьКТекущемуFeatureФайлу = СостояниеVanessaBehavior.ТекущаяФича.ПолныйПуть;
	
	ПутьКФайлу = Лев(ПутьКТекущемуFeatureФайлу, СтрНайти(ПутьКТекущемуFeatureФайлу, "features") - 1) + ИмяФайлаСРасширением;
	
	Возврат ПутьКФайлу;
КонецФункции

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакета(ИмяМакета)
	Ванесса.ЗапретитьВыполнениеШагов();
	
	НачальноеИмяФайла = ПолучитьПутьКФайлОтносительноКаталогоFeatures("tools\Выгрузка и загрузка данных XML.epf");
	
	Адрес = "";
	
	НачатьПомещениеФайла(Новый ОписаниеОповещения("ЗагрузитьFixtureИзМакетаЗавершение", ЭтотОбъект, ИмяМакета), Адрес, НачальноеИмяФайла, Ложь);
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьFixtureИзМакетаЗавершение(УдалосьПоместитьФайл, Адрес, ВыбранноеИмяФайла, ИмяМакета) Экспорт
	ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета);
	
	Ванесса.ПродолжитьВыполнениеШагов();
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьFixtureИзМакетаЗавершениеНаСервере(Адрес, ИмяМакета)
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	ДвоичныеДанные = ПолучитьИзВременногоХранилища(Адрес);
	ДвоичныеДанные.Записать(ИмяВременногоФайла);
	
	ВнешняяОбработка = ВнешниеОбработки.Создать(ИмяВременногоФайла, Ложь);
	
	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
	
	Текст = РеквизитФормыВЗначение("Объект").ПолучитьМакет(ИмяМакета).ПолучитьТекст();
	
	ВременныйДокумент = Новый ТекстовыйДокумент;
	ВременныйДокумент.УстановитьТекст(Текст);
	ВременныйДокумент.Записать(ИмяВременногоФайла, КодировкаТекста.UTF8);

	ВнешняяОбработка.ВыполнитьЗагрузку(ИмяВременногоФайла);
КонецПроцедуры

///////////////////////////////////////////////////

&НаСервере
Процедура УдалитьПродажиVanessa()
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	               |	Продажа.Ссылка
	               |ИЗ
	               |	Документ.Продажа КАК Продажа
	               |ГДЕ
	               |	Продажа.Комментарий ПОДОБНО &Комментарий";
				   
	Запрос.УстановитьПараметр("Комментарий", "vanessa");
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл
		ДокОбъект = Выборка.Ссылка.ПолучитьОбъект();
		ДокОбъект.УстановитьПометкуУдаления(Истина);
	КонецЦикла; 	
КонецПроцедуры
 
&НаКлиенте
//Допустим я Подготавливаю окружение
//@ЯПодготавливаюОкружение()
Процедура ЯПодготавливаюОкружение() Экспорт
	УдалитьПродажиVanessa();
	ЗагрузитьFixtureИзМакета("Поступления");
КонецПроцедуры

&НаКлиенте
//Тогда Проверить сообщение пользователю
//@ПроверитьСообщениеПользователю()
Процедура ПроверитьСообщениеПользователю() Экспорт
	ТестовоеПриложение = "";
	ОкноПриложенияПродажаСозданиеКнопкаOKВыбратьСообщениеПользователю(ТестовоеПриложение);
КонецПроцедуры


&НаКлиенте
Процедура ОкноПриложенияПродажаСозданиеКнопкаOKВыбратьСообщениеПользователю(ТестовоеПриложение)

	ОкноПриложенияПродажаСоздание = КонтекстСохраняемый.ТестовоеПриложение.НайтиОбъект(Тип("ТестируемоеОкноКлиентскогоПриложения"), "Продажа (создание) *", , 30);
	ОкноПриложенияПродажаСоздание.ВыбратьСообщениеПользователю(" По номенклатуре: Ручка шариковая на складе нет нужного количества, не хватает: -30");

КонецПроцедуры


//окончание текста модуля