#Область ПрограммныйИнтерфейс

// См. ОбменСКонтрагентамиКлиентПереопределяемый.ОткрытьФормуВыбораПользователей.
Процедура ОткрытьФормуВыбораПользователей(ВладелецФормы, ТекущийПользователь) Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("Ключ",                    ТекущийПользователь);
	Параметры.Вставить("РежимВыбора",             Истина);
	Параметры.Вставить("ТекущаяСтрока",           ТекущийПользователь);
	Параметры.Вставить("ВыборГруппПользователей", Ложь);
	ОткрытьФорму("Справочник.Пользователи.ФормаВыбора", Параметры, ВладелецФормы);
	
КонецПроцедуры

// См. ОбменСКонтрагентамиКлиентПереопределяемый.СопоставлятьНоменклатуруПередЗаполнениемДокумента.
Процедура СопоставлятьНоменклатуруПередЗаполнениемДокумента(СопоставлятьНоменклатуру) Экспорт
	
	СопоставлятьНоменклатуру = Истина;
	
КонецПроцедуры

// См. ОбменСКонтрагентамиКлиентПереопределяемый.ОткрытьЭлементНоменклатурыПоставщика.
Процедура ОткрытьЭлементНоменклатурыПоставщика(Идентификатор) Экспорт
	
	ДополнительныеРеквизиты = Новый Структура;
	ДополнительныеРеквизиты.Вставить("Идентификатор", Идентификатор);
	
	НоменклатураПоставщика = Неопределено;
	ЭлектронноеВзаимодействиеКЭДОВызовСервера.НайтиСсылкуНаОбъект("НоменклатураПоставщиков", НоменклатураПоставщика,,
		ДополнительныеРеквизиты);
	
	Если ЗначениеЗаполнено(НоменклатураПоставщика) Тогда
		ПоказатьЗначение(, НоменклатураПоставщика);
	КонецЕсли;
	
КонецПроцедуры

// См. ОбменСКонтрагентамиКлиентПереопределяемый.ОткрытьФормуСопоставленияНоменклатуры.
Процедура ОткрытьФормуСопоставленияНоменклатуры(Владелец, Параметры, СтандартнаяОбработка) Экспорт
	
	СтандартнаяОбработка = Ложь;
	Параметры.Вставить("РежимОткрытияОкна", РежимОткрытияОкнаФормы.БлокироватьОкноВладельца);
	ОткрытьФорму("Справочник.Номенклатура.Форма.ФормаВыбораДляСопоставления", Параметры, Владелец);
	
КонецПроцедуры

// См. ОбменСКонтрагентамиКлиентПереопределяемый.ОткрытьФормуПодбораТоваров.
Процедура ОткрытьФормуПодбораТоваров(ИдентификаторФормы, ОбработкаПродолжения) Экспорт
	
	Параметры = Новый Структура("ИдентификаторФормы", ИдентификаторФормы);
	ОткрытьФорму("ОбщаяФорма.ПодборТоваров", Параметры,,,,, ОбработкаПродолжения);
	
КонецПроцедуры

#КонецОбласти