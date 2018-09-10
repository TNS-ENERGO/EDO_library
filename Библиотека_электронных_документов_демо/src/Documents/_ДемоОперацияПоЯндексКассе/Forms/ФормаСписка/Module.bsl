
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Элементы.ФормаЗагрузитьОперацииПоЯндексКассе.Видимость 
		= ИнтеграцияСЯндексКассой.ЕстьПравоНаЗагрузкуОперацийПоЯндексКассе();
	
	ИнтернетПоддержкаПодключена = ИнтернетПоддержкаПользователей.ЗаполненыДанныеАутентификацииПользователяИнтернетПоддержки();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИнтернетПоддержкаПодключена" Тогда
		ИнтернетПоддержкаПодключена = Истина;
	ИначеЕсли ИмяСобытия = "ИнтернетПоддержкаОтключена" Тогда
		ИнтернетПоддержкаПодключена = Ложь;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКоманд

&НаКлиенте
Процедура ЗагрузитьОперацииПоЯндексКассе(Команда)
	
	Если ИнтернетПоддержкаПодключена Тогда
		НачатьЗагрузкуОперацийПоЯндексКассе();
	Иначе
		ПоказатьВопросПодключенияИПП();
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияОСтатусеОбменов(Команда)
	
	ИнтеграцияСЯндексКассойКлиент.ОткрытьФормуСтатусаОбменов();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ПоказатьВопросПодключенияИПП()
	
	ОбработкаОтвета = Новый ОписаниеОповещения("ПоказатьВопросПодключенияИППЗавершение", ЭтотОбъект);
	
	ТекстВопроса = НСтр("ru='Для использования функций взаимодействия с сервисом Яндекс.Касса,
		|необходимо подключиться к Интернет-поддержке пользователей.
		|Подключиться сейчас?'");
	ПоказатьВопрос(ОбработкаОтвета, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьВопросПодключенияИППЗавершение(Знач Ответ, Знач Параметры) Экспорт
	
	Если Ответ <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ЗагрузитьОперацииПоЯндексКассеПродолжение = Новый ОписаниеОповещения("ЗагрузитьОперацииПоЯндексКассеПродолжение",
		ЭтотОбъект);
	ИнтернетПоддержкаПользователейКлиент.ПодключитьИнтернетПоддержкуПользователей(ЗагрузитьОперацииПоЯндексКассеПродолжение,
		ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьОперацииПоЯндексКассеПродолжение(Результат, ДополнительныеПараметры) Экспорт
	
	Если ТипЗнч(Результат) = Тип("Структура")
		И Результат.Свойство("Логин") Тогда
		НачатьЗагрузкуОперацийПоЯндексКассе();
	Иначе
		ТекстСообщения = НСтр("ru = 'Отсутствует подключение к Интернет-поддержке пользователей.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;

КонецПроцедуры

&НаКлиенте
Процедура НачатьЗагрузкуОперацийПоЯндексКассе()
	
	ОповещениеПослеЗагрузки = Новый ОписаниеОповещения("ЗагрузитьОперацииПоЯндексКассеЗавершение", ЭтотОбъект);
	
	ПараметрыЗагрузки = Новый Структура;
	ПараметрыЗагрузки.Вставить("Период", Неопределено);
	ПараметрыЗагрузки.Вставить("Организация", Неопределено);
	ПараметрыЗагрузки.Вставить("СДоговором", Истина);
	_ДемоИнтеграцияСЯндексКассойКлиент.НачатьЗагрузкуОперацийПоЯндексКассе(ПараметрыЗагрузки, ОповещениеПослеЗагрузки);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьОперацииПоЯндексКассеЗавершение(Результат, ДопПараметры) Экспорт
	
	Если Результат = Неопределено Тогда  // отменено пользователем
		Возврат;
	КонецЕсли;
	
	Если Результат.Свойство("Сообщения") Тогда 
		Для Каждого Сообщение Из Результат.Сообщения Цикл 
			Сообщение.Сообщить();
		КонецЦикла;
	КонецЕсли;
	
	Если Результат.Статус = "Выполнено" Тогда
		
		Если Не ЭтоАдресВременногоХранилища(Результат.АдресРезультата) Тогда
			Возврат;
		КонецЕсли;
		
		СчетчикДокументов = 0;
		
		РезультатыЗагрузки = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
		
		Если РезультатыЗагрузки <> Неопределено Тогда
			Если РезультатыЗагрузки.Количество() = 0 Тогда
				Возврат;
			КонецЕсли;
			
			Для каждого КЗ Из РезультатыЗагрузки Цикл
				СчетчикДокументов = СчетчикДокументов + КЗ.Значение;
			КонецЦикла;
		КонецЕсли;
		
		ТекстСообщения = ?(СчетчикДокументов, НСтр("ru = 'Операций по Яндекс.Кассе загружено: %1'")
		, НСтр("ru = 'Новых операций по Яндекс.Кассе не было'"));
		
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			ТекстСообщения, СчетчикДокументов);
		
		ПоказатьОповещениеПользователя(НСтр("ru = 'Загрузка завершена'"),
			"e1cib/list/Документ._ДемоОперацияПоЯндексКассе",
			ТекстСообщения);
		
		Если СчетчикДокументов Тогда 
			ОповеститьОбИзменении(Тип("ДокументСсылка._ДемоОперацияПоЯндексКассе"));
		КонецЕсли
		
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(Результат.ПодробноеПредставлениеОшибки);
		ПоказатьПредупреждение(,Результат.КраткоеПредставлениеОшибки);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти