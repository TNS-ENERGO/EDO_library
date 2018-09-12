#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	ОтборПоВладельцу = Неопределено;
	Если Не Параметры.Отбор = Неопределено Тогда 
		Параметры.Отбор.Свойство("Владелец", ОтборПоВладельцу);
	КонецЕсли;
	
	Если Не ОтборПоВладельцу = Неопределено Тогда 
		Элементы.Владелец.Видимость = Ложь;
		Заголовок = НСтр("ru = 'Характеристики:'");
		Если ТипЗнч(ОтборПоВладельцу) = Тип("СправочникСсылка.ВидыНоменклатуры") Тогда 
			Заголовок = НСтр("ru = 'Общие характеристики вида номенклатуры:'");
		ИначеЕсли ТипЗнч(ОтборПоВладельцу) = Тип("СправочникСсылка.Номенклатура") Тогда 
			Заголовок = НСтр("ru = 'Характеристики номенклатуры:'");
		КонецЕсли;
		Заголовок = СтрШаблон("%1 %2", Заголовок, ОтборПоВладельцу)
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

