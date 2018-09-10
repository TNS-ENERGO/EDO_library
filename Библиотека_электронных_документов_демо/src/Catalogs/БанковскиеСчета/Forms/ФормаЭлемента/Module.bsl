#Область ОписаниеПеременных

&НаКлиенте
Перем УстановкаОсновногоБанковскогоСчетаВыполнена;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Объект.Владелец) Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(
			НСтр("ru = 'Не указан владелец банковского счета.'"),,,, Отказ);
		Возврат;
	КонецЕсли;
	
	Если ТипЗнч(Объект.Владелец) = Тип("СправочникСсылка.Контрагенты") Тогда
		
		Элементы.Владелец.Заголовок = НСтр("ru = 'Контрагент'");
		
	ИначеЕсли ТипЗнч(Объект.Владелец) = Тип("СправочникСсылка.Организации") Тогда
		
		ИспользуетсяНесколькоОрганизаций = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийЭД");
		
		Элементы.Владелец.Видимость = ИспользуетсяНесколькоОрганизаций;
		
	КонецЕсли;
	
	ИспользуетсяБанкДляРасчетов = ЗначениеЗаполнено(Объект.БанкДляРасчетов);
	
	Если Параметры.Ключ.Пустая() Тогда
		Если ЗначениеЗаполнено(Параметры.ЗначениеКопирования) Тогда
			Объект.Наименование = "";
			УстановитьНаименованиеСчета(ЭтотОбъект);
		Иначе
			АвтоНаименование = СокрЛП(Объект.Наименование);
			Если ПустаяСтрока(Объект.НомерСчета) И НЕ ПустаяСтрока(АвтоНаименование)
				И СтроковыеФункцииКлиентСервер.ТолькоЦифрыВСтроке(АвтоНаименование) Тогда
				Объект.НомерСчета = АвтоНаименование;
			Иначе
				Объект.Наименование = "";
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
	НаименованиеВладельца = "";
	Если ЗначениеЗаполнено(Объект.Владелец) Тогда 
		НаименованиеВладельца = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Владелец, "Наименование");
	КонецЕсли;
	
	УправлениеФормойНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "УстановкаОсновногоБанковскогоСчетаВыполнена" Тогда
		
		УстановкаОсновногоБанковскогоСчетаВыполнена = Истина;
		
	ИначеЕсли ИмяСобытия = "ИзмененаНастройкаОбмена" Тогда
		
		ОтобразитьНастройкуОбменаСБанком();
		
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	Если ЗначениеЗаполнено(Объект.НомерСчета) И ЗначениеЗаполнено(Объект.Банк)
		И СтрДлина(СокрЛП(Объект.НомерСчета)) < 20 Тогда
		ТекстСообщения = НСтр("ru = 'Номер счета должен состоять из 20 цифр'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,,"Объект.НомерСчета",,Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПередЗаписьюНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если Не ИспользуетсяБанкДляРасчетов Тогда
		ТекущийОбъект.БанкДляРасчетов = Неопределено;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
		
	Если Справочники.БанковскиеСчета.КоличествоБанковскихСчетовОрганизации(Объект.Владелец) = 1 Тогда
		ПараметрыЗаписи.Вставить("ЭтоЕдинственныйБанковскийСчет");
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПараметрОповещения = Новый Структура("Ссылка, Владелец", Объект.Ссылка, Объект.Владелец);
	
	Оповестить("ИзмененБанковскийСчет", ПараметрОповещения);
	
	Если ПараметрыЗаписи.Свойство("ЭтоЕдинственныйБанковскийСчет") Тогда
		
		УстановкаОсновногоБанковскогоСчетаВыполнена = Ложь;
		
		СтруктураПараметров = Новый Структура();
		СтруктураПараметров.Вставить("Владелец", Объект.Владелец);
		СтруктураПараметров.Вставить("ОсновнойБанковскийСчет", Объект.Ссылка);
		
		Оповестить("УстановкаОсновногоБанковскогоСчетаПриЗаписи", СтруктураПараметров);
		
		// Если форма владельца закрыта, то запишем основной банковский счет самостоятельно.
		Если НЕ УстановкаОсновногоБанковскогоСчетаВыполнена Тогда
			УстановитьОсновнойБанковскийСчет(СтруктураПараметров);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработкаПроверкиЗаполненияНаСервере(Отказ, ПроверяемыеРеквизиты)
	
	Если Не СтрДлина(Объект.НомерСчета) = 20 Тогда 
		
		ТекстОшибки = НСтр("ru = 'Длина номера счета должна быть 20 символов.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Объект.Ссылка, "НомерСчета", "Объект", Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура БанкПриИзменении(Элемент)
	
	НаименованиеБанка = "";
	Если ЗначениеЗаполнено(Объект.Банк) Тогда
		НаименованиеБанка = Строка(Объект.Банк);
	КонецЕсли;
	
	УстановитьНаименованиеСчета(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ИспользуетсяБанкДляРасчетовПриИзменении(Элемент)
	
	Элементы.БанкДляРасчетов.Доступность = ИспользуетсяБанкДляРасчетов;
	
КонецПроцедуры

&НаКлиенте
Процедура ДекорацияНастройкаОбменаНажатие(Элемент)
	
	Если ЗначениеЗаполнено(НастройкаОбменаСБанком) Тогда
		ПоказатьЗначение(, НастройкаОбменаСБанком);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаОбменаПодключитьНажатие(Элемент)
	
	Если Не ЗначениеЗаполнено(Объект.Ссылка) Или Модифицированность Тогда
		Если ПроверитьЗаполнение() Тогда
			Записать();
		Иначе
			Возврат;
		КонецЕсли;
	КонецЕсли;
	
	// ЭлектронноеВзаимодействие.ОбменСБанками
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ОбменСБанками") Тогда
		Обработчик = Новый ОписаниеОповещения("ПослеСозданияНастройкиОбмена", ЭтотОбъект);
		МодульОбменСБанкамиКлиент = ОбщегоНазначенияКлиент.ОбщийМодуль("ОбменСБанкамиКлиент");
		МодульОбменСБанкамиКлиент.ОткрытьСоздатьНастройкуОбмена(Объект.Владелец, Объект.Банк, Объект.НомерСчета, Обработчик);
	КонецЕсли;
	// Конец ЭлектронноеВзаимодействие.ОбменСБанками
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеСозданияНастройкиОбмена(НастройкаОбмена, Параметры) Экспорт
	
	Если ЗначениеЗаполнено(НастройкаОбмена) Тогда
		ОтобразитьНастройкуОбменаСБанком();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура УправлениеФормойНаСервере()
	
	Элементы.БанкДляРасчетов.Доступность = ИспользуетсяБанкДляРасчетов;
	ОтобразитьНастройкуОбменаСБанком();
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура УстановитьНаименованиеСчета(Форма, ИзменениеНомераСчета = Ложь)
	
	Объект = Форма.Объект;
	
	Если ПустаяСтрока(Объект.Наименование) ИЛИ Объект.Наименование = Форма.АвтоНаименование Тогда
		Форма.АвтоНаименование = СформироватьАвтоНаименование(Форма);
		Если НЕ ПустаяСтрока(Форма.АвтоНаименование) И Форма.АвтоНаименование <> Объект.Наименование Тогда
			Объект.Наименование = Форма.АвтоНаименование;
		КонецЕсли;
	Иначе
		Если ИзменениеНомераСчета И НЕ ПустаяСтрока(Форма.НомерСчетаТекущий) Тогда
			Объект.Наименование = СтрЗаменить(Объект.Наименование, Форма.НомерСчетаТекущий, СокрЛП(Объект.НомерСчета));
		КонецЕсли;
		
		Форма.АвтоНаименование = СформироватьАвтоНаименование(Форма, Объект.Наименование);
	КонецЕсли;
	
	Форма.НомерСчетаТекущий = СокрЛП(Объект.НомерСчета);
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Функция СформироватьАвтоНаименование(Форма, Знач Текст = "")
	
	Элементы = Форма.Элементы;
	Объект   = Форма.Объект;
	
	ПредставлениеБанка = "";
	Если ЗначениеЗаполнено(Объект.Банк) Тогда
		ПредставлениеБанка = СокрЛП(Форма.НаименованиеБанка);
	КонецЕсли;
	
	ПредставлениеВладельца = "";
	Если ЗначениеЗаполнено(Объект.Владелец) Тогда
		ПредставлениеВладельца = СокрЛП(Форма.НаименованиеВладельца);
	КонецЕсли;
	
	Элементы.Наименование.СписокВыбора.Очистить();
	
	СтрокаНаименования1 = КлиентЭДОКлиентСервер.НаименованиеБанковскогоСчетаПоУмолчанию(
		Объект.НомерСчета,
		ПредставлениеБанка,
		ПредставлениеВладельца,
		1); // Вариант по умолчанию выводим последним
	
	Если НЕ ПустаяСтрока(СтрокаНаименования1) Тогда
		Элементы.Наименование.СписокВыбора.Добавить(СокрЛП(СтрокаНаименования1));
	КонецЕсли;
	
	СтрокаНаименования2 = КлиентЭДОКлиентСервер.НаименованиеБанковскогоСчетаПоУмолчанию(
		Объект.НомерСчета,
		ПредставлениеБанка,
		ПредставлениеВладельца,
		2);
	
	Строки1и2НеРавны = СокрЛП(СтрокаНаименования2) <> "(" + СтрокаНаименования1 + ")";
	Если СтрокаНаименования2 <> "" И Строки1и2НеРавны
			И Элементы.Наименование.СписокВыбора.НайтиПоЗначению(СтрокаНаименования2) = Неопределено Тогда
		Элементы.Наименование.СписокВыбора.Добавить(СокрЛП(СтрокаНаименования2));
	КонецЕсли;
	
	СтрокаНаименования = КлиентЭДОКлиентСервер.НаименованиеБанковскогоСчетаПоУмолчанию(
		Объект.НомерСчета,
		ПредставлениеБанка,
		ПредставлениеВладельца);
		
	Если НЕ ПустаяСтрока(СтрокаНаименования) И Элементы.Наименование.СписокВыбора.НайтиПоЗначению(СтрокаНаименования) = Неопределено Тогда
		Элементы.Наименование.СписокВыбора.Добавить(СокрЛП(СтрокаНаименования));
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(Текст) И Элементы.Наименование.СписокВыбора.НайтиПоЗначению(Текст) = Неопределено Тогда
		Элементы.Наименование.СписокВыбора.Добавить(СокрЛП(Текст));
	КонецЕсли;
	
	Возврат СтрокаНаименования;
	
КонецФункции

&НаКлиенте
Процедура НаименованиеПриИзменении(Элемент)
	
	СформироватьАвтоНаименование(ЭтотОбъект, Объект.Наименование);
	
КонецПроцедуры

&НаКлиенте
Процедура НомерСчетаПриИзменении(Элемент)
	
	УстановитьНаименованиеСчета(ЭтотОбъект, Истина);
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УстановитьОсновнойБанковскийСчет(СтруктураПараметров)
	
	Справочники.БанковскиеСчета.УстановитьОсновнойБанковскийСчет(
		СтруктураПараметров.Владелец, 
		СтруктураПараметров.ОсновнойБанковскийСчет);
	
КонецПроцедуры

&НаСервере
Процедура ОтобразитьНастройкуОбменаСБанком()
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ОбменСБанками") Тогда
		Элементы.ГруппаОбменСБанками.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(Объект.Банк)
		ИЛИ ТипЗнч(Объект.Владелец) <> Тип("СправочникСсылка.Организации") Тогда
		Элементы.ГруппаОбменСБанками.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	Элементы.ГруппаОбменСБанками.Видимость = Истина;
	
	МодульОбменСБанками = ОбщегоНазначения.ОбщийМодуль("ОбменСБанками");
	НастройкаОбменаСБанком = МодульОбменСБанками.НастройкаОбмена(Объект.Владелец, Объект.Банк);
	
	Если ЗначениеЗаполнено(НастройкаОбменаСБанком) Тогда
		Элементы.ГруппаНастройкаОбменаСБанком.Видимость = МодульОбменСБанками.ИспользуетсяСервисДиректБанк();
		Элементы.ГруппаРекламаДиректБанк.Видимость = Ложь;
	Иначе
		Элементы.ГруппаНастройкаОбменаСБанком.Видимость = Ложь;
		БИКБанка = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Объект.Банк, "Код");
		Элементы.ГруппаРекламаДиректБанк.Видимость = МодульОбменСБанками.ВозможенПрямойОбменСБанком(БИКБанка, "1");
	КонецЕсли
	
КонецПроцедуры

#КонецОбласти
