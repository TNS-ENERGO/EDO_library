#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ИспользуетсяНесколькоОрганизацийЭД = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийЭД");
	
	Если ИспользуетсяНесколькоОрганизацийЭД Тогда
		Элементы.ПустаяДекорация.Видимость = Ложь;
	ИначеЕсли Не ИспользуетсяНесколькоОрганизацийЭД И НЕ ЗначениеЗаполнено(Объект.Организация) Тогда
		Объект.Организация = Справочники.Организации.ОрганизацияПоУмолчанию();
	КонецЕсли;
	
	Если НЕ ОбменСБанками.ПравоЧтенияДанных() Тогда
		Элементы.ГруппаСостояниеЭДО.Видимость = Ложь;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект.Ссылка) Тогда
		УстановитьТекстСостоянияЭДНаСервере();
	КонецЕсли;
	
	Элементы.ПоказательПериода.СписокВыбора.Добавить("0", НСтр("ru = '0 - значение не указывается'"));
	Элементы.ПоказательПериода.СписокВыбора.Добавить("Дата...", НСтр("ru = 'Дата...'"));
	Элементы.ПоказательПериода.СписокВыбора.Добавить("МС - месячный платеж", НСтр("ru = 'МС - месячный платеж'"));
	Элементы.ПоказательПериода.СписокВыбора.Добавить("КВ - квартальный платеж", НСтр("ru = 'КВ - квартальный платеж'"));
	Элементы.ПоказательПериода.СписокВыбора.Добавить("ПЛ - полугодовой платеж", НСтр("ru = 'ПЛ - полугодовой платеж'"));
	Элементы.ПоказательПериода.СписокВыбора.Добавить("ГД - годовой платеж", НСтр("ru = 'ГД - годовой платеж'"));
	
	Элементы.ПоказательДаты.СписокВыбора.Добавить("0", НСтр("ru = '0 - значение не указывается'"));
	Элементы.ПоказательДаты.СписокВыбора.Добавить("Дата...", НСтр("ru = 'Дата...'"));
	
	Элементы.ПоказательДатыФТС.СписокВыбора.Добавить("0", НСтр("ru = '0 - значение не указывается'"));
	Элементы.ПоказательДатыФТС.СписокВыбора.Добавить("Дата...", НСтр("ru = 'Дата...'"));
		
	Если Объект.ПоказательПериода = "0" ИЛИ ПустаяСтрока(Объект.ПоказательПериода) Тогда
		ПоказательПериода = "0";
	Иначе
		Попытка
			ПоказательПериода = Дата(Сред(Объект.ПоказательПериода, 7, 4)
				+ Сред(Объект.ПоказательПериода, 4, 2) + Сред(Объект.ПоказательПериода, 1, 2));
		Исключение
			ПоказательПериода = Объект.ПоказательПериода;
		КонецПопытки;
	
	КонецЕсли;
	
	Если ТипЗнч(Объект.ПоказательПериода) = Тип("Строка") Тогда
		Префикс = Сред(Объект.ПоказательПериода, 1, 2);
		Если Префикс = "МС" Тогда
			Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.МС;
			ПоказательПериода = НСтр("ru = 'МС - месячный платеж'");
			Месяц = Число(Сред(Объект.ПоказательПериода,4,2));
			Год =  Число(Сред(Объект.ПоказательПериода,7,4));
		ИначеЕсли Префикс = "КВ" Тогда
			Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.КВ; 
			ПоказательПериода = НСтр("ru = 'КВ - квартальный платеж'");
			Квартал = Число(Сред(Объект.ПоказательПериода,4,2));
			Год =  Число(Сред(Объект.ПоказательПериода,7,4));
		ИначеЕсли Префикс = "ПЛ" Тогда
			Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ПЛ; 
			ПоказательПериода = НСтр("ru = 'ПЛ - полугодовой платеж'");
			Полугодие = Число(Сред(Объект.ПоказательПериода,4,2));
			Год =  Число(Сред(Объект.ПоказательПериода,7,4));
		ИначеЕсли Префикс = "ГД" Тогда
			Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ГД; 
			ПоказательПериода = НСтр("ru = 'ГД - годовой платеж'");
			Год =  Число(Сред(Объект.ПоказательПериода,7,4));
		КонецЕсли;
	КонецЕсли;
	
	
	Если Объект.ПоказательДаты = "0" ИЛИ ПустаяСтрока(Объект.ПоказательДаты) Тогда
		ПоказательДаты = "0";
	Иначе
		Попытка
			ПоказательДаты = Дата(Сред(Объект.ПоказательДаты, 7, 4)
				+ Сред(Объект.ПоказательДаты, 4, 2) + Сред(Объект.ПоказательДаты, 1, 2));
		Исключение
			ПоказательДаты = "0";
		КонецПопытки;
	КонецЕсли;
	
	Элементы.ГруппаБюджетныеРеквизиты.Видимость = Объект.ПлатежВБюджет;
	Элементы.СтраницыПоказателяПериода.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
	
	ВидимостьРеквизитовПлатежногоДокумента(ЭтотОбъект, Объект.ТипПлатежногоДокумента);
	
	Элементы.ПоказательОснования.СписокВыбора.СортироватьПоЗначению();
	Элементы.ПоказательОснованияФТС.СписокВыбора.СортироватьПоЗначению();
	
	// СтандартныеПодсистемы.Печать
	ПодключаемыеКоманды.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.Печать
	
	// КомандыЭДО
	ОбменСБанками.ПриСозданииНаСервере(ЭтотОбъект);
	// Конец КомандыЭДО
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды

КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьРедактированиеПоказателяПериода();
	УстановитьРедактированиеПоказателяДаты();
	ОбработатьИзменениеКБК();
	
	// СтандартныеПодсистемы.ПодключаемыеКоманды
	ПодключаемыеКомандыКлиент.НачатьОбновлениеКоманд(ЭтотОбъект);
	// Конец СтандартныеПодсистемы.ПодключаемыеКоманды
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗаписью(Отказ, ПараметрыЗаписи)
	
	ПриИзмененииПериода();	
	
КонецПроцедуры

&НаСервере
Процедура ПослеЗаписиНаСервере(ТекущийОбъект, ПараметрыЗаписи)
	
	УстановитьТекстСостоянияЭДНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	Оповестить("ОбновитьСостояниеОбменСБанками");
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ОбновитьСостояниеОбменСБанками" Тогда
		УстановитьТекстСостоянияЭДНаСервере();
		Прочитать();
	КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийПолейФормы

&НаКлиенте
Процедура ТипПлатежногоДокументаПриИзменении(Элемент)
	
	ВидимостьРеквизитовПлатежногоДокумента(ЭтотОбъект, Объект.ТипПлатежногоДокумента);
	
КонецПроцедуры

&НаКлиенте
Процедура СостояниеЭДНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ОбменСБанкамиКлиент.ОткрытьАктуальныйЭД(Объект.Ссылка, ЭтотОбъект);

КонецПроцедуры

&НаКлиенте
Процедура ПлатежВБюджетПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(ПоказательПериода) Тогда
		ПоказательПериода = "0";
	КонецЕсли;
	Если НЕ ЗначениеЗаполнено(ПоказательДаты) Тогда
		ПоказательДаты = "0";
	КонецЕсли;
	
	Элементы.ГруппаБюджетныеРеквизиты.Видимость = Объект.ПлатежВБюджет;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательПериодаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательПериода) = Тип("Дата");
	
	Если НЕ СтандартнаяОбработка Тогда
		
		Оп = Новый ОписаниеОповещения("ОбработатьРезультатВыбораПоказателяПериода", ЭтотОбъект);
		ПоказатьВыборИзСписка(ОП, Элемент.СписокВыбора);

	КонецЕсли;
	
	УстановитьРедактированиеПоказателяПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательПериодаПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(ПоказательПериода) Тогда
		ПоказательПериода = "0";
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяПериода();
	
	УстановитьСтраницуПериода();
				
	ПриИзмененииПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательПериодаОткрытие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательПериода) = Тип("Дата");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательПериодаОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбработатьРезультатВыбораПоказателяПериода(Новый Структура("Значение", ВыбранноеЗначение), Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательДаты) = Тип("Дата");
	
	Если НЕ СтандартнаяОбработка Тогда
		
		Оп = Новый ОписаниеОповещения("ОбработатьРезультатВыбораПоказателяДаты", ЭтотОбъект);

		ПоказатьВыборИзСписка(Оп, Элемент.СписокВыбора);
	
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяДаты();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыФТСНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательДаты) = Тип("Дата");
	
	Если НЕ СтандартнаяОбработка Тогда
		
		Оп = Новый ОписаниеОповещения("ОбработатьРезультатВыбораПоказателяДаты", ЭтотОбъект);

		ПоказатьВыборИзСписка(Оп, Элемент.СписокВыбора);
	
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяДаты();
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(ПоказательДаты) Тогда
		ПоказательДаты = "0";
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяДаты();
	
	Если ТипЗнч(ПоказательДаты) = Тип("Дата") Тогда
		Объект.ПоказательДаты = Формат(ПоказательДаты, "ДЛФ=D");
	Иначе
		Объект.ПоказательДаты = ПоказательДаты;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбработатьРезультатВыбораПоказателяДаты(Новый Структура("Значение", ВыбранноеЗначение), Неопределено);
КонецПроцедуры


&НаКлиенте
Процедура ПоказательДатыФТСПриИзменении(Элемент)
	
	Если НЕ ЗначениеЗаполнено(ПоказательДаты) Тогда
		ПоказательДаты = "0";
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяДаты();
	
	Если ТипЗнч(ПоказательДаты) = Тип("Дата") Тогда
		Объект.ПоказательДаты = Формат(ПоказательДаты, "ДЛФ=D");
	Иначе
		Объект.ПоказательДаты = ПоказательДаты;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательДаты) = Тип("Дата");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыФТСОчистка(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = ТипЗнч(ПоказательДаты) = Тип("Дата");
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказательДатыФТСОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	ОбработатьРезультатВыбораПоказателяДаты(Новый Структура("Значение", ВыбранноеЗначение), Неопределено);
КонецПроцедуры

&НаКлиенте
Процедура КодБКПриИзменении(Элемент)
	
	ОбработатьИзменениеКБК();
	
КонецПроцедуры

#КонецОбласти


#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Подключаемый_ВыполнитьКомандуЭДО(Команда)
	
	ЭлектронноеВзаимодействиеКлиент.ВыполнитьПодключаемуюКомандуЭДО(Команда, ЭтотОбъект, Объект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьИзменениеКБК()
	
	Если Объект.ПлатежВБюджет И Сред(Объект.КодБК, 1, 3) = "153" Тогда //Федеральная таможенная служба
		Элементы.СтраницыПоказателяПериода.ТекущаяСтраница = Элементы.СтраницаФТС;
	Иначе
		Элементы.СтраницыПоказателяПериода.ТекущаяСтраница = Элементы.СтраницаПрочее;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьСтраницуПериода()
	
	Если ПоказательПериода = "0" ИЛИ ТипЗнч(ПоказательПериода) = Тип("Дата") Тогда
		Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ПустаяСтраница;
	ИначеЕсли ПоказательПериода = НСтр("ru = 'МС - месячный платеж'") Тогда
		Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.МС;
	ИначеЕсли ПоказательПериода = НСтр("ru = 'КВ - квартальный платеж'") Тогда
		Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.КВ;
	ИначеЕсли ПоказательПериода = НСтр("ru = 'ПЛ - полугодовой платеж'") Тогда
		Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ПЛ;
	ИначеЕсли ПоказательПериода = НСтр("ru = 'ГД - годовой платеж'") Тогда
		Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ГД;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриИзмененииПериода()
	
	Если ТипЗнч(ПоказательПериода) = Тип("Дата") Тогда
		Объект.ПоказательПериода = Формат(ПоказательПериода, "ДЛФ=D");
	Иначе
		Если Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ПустаяСтраница Тогда
			Объект.ПоказательПериода = ПоказательПериода;
		ИначеЕсли Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.МС И ЗначениеЗаполнено(Месяц)
			И ЗначениеЗаполнено(Год) Тогда
			Объект.ПоказательПериода = "МС." + Формат(Месяц, "ЧЦ=2; ЧВН=") + "." + Формат(Год, "ЧГ=");
		ИначеЕсли Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.КВ И ЗначениеЗаполнено(Квартал)
			И ЗначениеЗаполнено(Год) Тогда
			Объект.ПоказательПериода = "КВ." + Формат(Квартал, "ЧЦ=2; ЧВН=") + "." + Формат(Год, "ЧГ=");
		ИначеЕсли Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ПЛ И ЗначениеЗаполнено(Полугодие)
			И ЗначениеЗаполнено(Год) Тогда
			Объект.ПоказательПериода = "ПЛ." + Формат(Полугодие, "ЧЦ=2; ЧВН=") + "." + Формат(Год, "ЧГ=");
		ИначеЕсли Элементы.СтраницыПериода.ТекущаяСтраница = Элементы.ГД И ЗначениеЗаполнено(Год)  Тогда
			Объект.ПоказательПериода = "ГД.00." + Формат(Год, "ЧГ=");
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатВыбораПоказателяПериода(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		УстановитьСтраницуПериода();
		Возврат;
	КонецЕсли;
		
	Если Результат.Значение = "Дата..." Тогда
		Если ТипЗнч(ПоказательПериода) = Тип("Строка") Тогда
			ПоказательПериода = '00010101';
		КонецЕсли;
	Иначе
		ПоказательПериода = Результат.Значение;
	КонецЕсли;
	УстановитьСтраницуПериода();
	
	УстановитьРедактированиеПоказателяПериода();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатВыбораПоказателяДаты(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Если Результат.Значение = "Дата..." Тогда
		Если ТипЗнч(ПоказательДаты) = Тип("Строка") Тогда
			ПоказательДаты = '00010101';
		КонецЕсли;
	Иначе
		ПоказательДаты = Результат.Значение;
	КонецЕсли;
	
	УстановитьРедактированиеПоказателяДаты();

КонецПроцедуры

&НаСервере
Процедура УстановитьТекстСостоянияЭДНаСервере()
	
	ТекстСостоянияЭД = ОбменСБанкамиКлиентСервер.ПолучитьТекстСостоянияЭД(Объект.Ссылка, ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРедактированиеПоказателяПериода()
	
	ПоказательПериодаИмеетТипДата = ТипЗнч(ПоказательПериода) = Тип("Дата");
	Элементы.ПоказательПериода.РедактированиеТекста = ПоказательПериодаИмеетТипДата;
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьРедактированиеПоказателяДаты()
	
	ПоказательДатыИмеетТипДата = ТипЗнч(ПоказательДаты) = Тип("Дата");
	Элементы.ПоказательДаты.РедактированиеТекста = ПоказательДатыИмеетТипДата;
	Элементы.ПоказательДатыФТС.РедактированиеТекста = ПоказательДатыИмеетТипДата;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ВидимостьРеквизитовПлатежногоДокумента(Форма, Знач ТипПлатежногоДокумента)
	
	ПлатежноеПоручение = ПредопределенноеЗначение("Перечисление._ДемоТипыПлатежныхДокументов.ПлатежноеПоручение");
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы,
		"ПлатежноеПоручение",
		"Видимость",
		ТипПлатежногоДокумента = ПлатежноеПоручение);
		
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы,
		"ПлатежноеТребование",
		"Видимость",
		Не ТипПлатежногоДокумента = ПлатежноеПоручение);
	
КонецПроцедуры

// СтандартныеПодсистемы.ПодключаемыеКоманды
&НаКлиенте
Процедура Подключаемый_ВыполнитьКоманду(Команда)
	ПодключаемыеКомандыКлиент.ВыполнитьКоманду(ЭтотОбъект, Команда, Объект);
КонецПроцедуры

&НаСервере
Процедура Подключаемый_ВыполнитьКомандуНаСервере(Контекст, Результат)
	ПодключаемыеКоманды.ВыполнитьКоманду(ЭтотОбъект, Контекст, Объект, Результат);
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ОбновитьКоманды()
	ПодключаемыеКомандыКлиентСервер.ОбновитьКоманды(ЭтотОбъект, Объект);
КонецПроцедуры
// Конец СтандартныеПодсистемы.ПодключаемыеКоманды


#КонецОбласти
