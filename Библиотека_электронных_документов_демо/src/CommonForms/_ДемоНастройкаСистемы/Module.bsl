
#Область ОбработчикиСобытийФормы

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ОбновитьПовторноИспользуемыеЗначения();
	ОбновитьИнтерфейс();
	СтандартныеПодсистемыКлиент.УстановитьРасширенныйЗаголовокПриложения();
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура УдалитьЭлектронныеДокументы(Команда)
	
	Оповещение = Новый ОписаниеОповещения("УдалитьЭлектронныеДокументыПродолжить", ЭтотОбъект);
	
	ТекстВопроса = НСтр("ru = 'Будет выполнено удаление всех электронных документов из базы данных.
                        |Продолжить?'");
	ПоказатьВопрос(Оповещение, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьИнтеграцию1СОтчетность(Команда)
	
	ОткрытьФорму("ОбщаяФорма._ДемоПроверкаИнтеграцииССервисом1СОтчетность");
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьИнтернетПоддержку(Команда)
	
	ОтключитьИнтернетПоддержкуПродолжить();
	Оповестить("ИнтернетПоддержкаОтключена");
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура УдалитьЭлектронныеДокументыПродолжить(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда 
		
		ОчиститьИнформационнуюБазуНаСервере();
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОчиститьИнформационнуюБазуНаСервере()
	
	ОчиститьРегистрСведений("СостоянияЭД");
	ОчиститьРегистрСведений("ЖурналСобытийЭД");
	ОчиститьРегистрСведений("ЭлектронныеПодписи");
	ОчиститьРегистрСведений("ДвоичныеДанныеФайлов");
	УдалитьЭлементыСправочника("ЭДПрисоединенныеФайлы");
	УдалитьЭлементыСправочника("ПакетЭДПрисоединенныеФайлы");
	УдалитьДокументы("ПакетЭД");
	
	ОчиститьРегистрСведений("СостоянияОбменСБанками");
	ОчиститьРегистрСведений("ТикетыОбменСБанками");
	ОчиститьРегистрСведений("ЖурналОбменСБанками");
	ОчиститьРегистрСведений("ЖурналСобытийОбменСБанками");
	УдалитьЭлементыСправочника("ПакетОбменСБанкамиПрисоединенныеФайлы");
	УдалитьЭлементыСправочника("СообщениеОбменСБанкамиПрисоединенныеФайлы");
	УдалитьДокументы("ПакетОбменСБанками");
	УдалитьДокументы("СообщениеОбменСБанками");
	
	ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Операция выполнена.'"));
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОчиститьРегистрСведений(Имя)
	
	Менеджер = РегистрыСведений[Имя];
	НаборЗаписей = Менеджер.СоздатьНаборЗаписей();
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	НаборЗаписей.Записать();

КонецПроцедуры

&НаСервереБезКонтекста
Процедура УдалитьЭлементыСправочника(Имя)
	
	Менеджер = Справочники[Имя];
	Выборка = Менеджер.Выбрать();
	Пока Выборка.Следующий()  Цикл
		ОбъектВыборки = Выборка.ПолучитьОбъект();
		ОбъектВыборки.Удалить();
	КонецЦикла;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура УдалитьДокументы(Имя)
	
	Менеджер = Документы[Имя];
	Выборка = Менеджер.Выбрать();
	Пока Выборка.Следующий()  Цикл
		ОбъектВыборки = Выборка.ПолучитьОбъект();
		ОбъектВыборки.Удалить();
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОтключитьИнтернетПоддержкуПродолжить()
	
	СуществуетПодсистемаПоддержки = ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей");
	
	Если СуществуетПодсистемаПоддержки Тогда
		ИнтернетПоддержкаПользователей.СохранитьДанныеАутентификации(Неопределено);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Элементы.ОтключитьИнтернетПоддержку.Видимость = ОбщегоНазначения.ПодсистемаСуществует("ИнтернетПоддержкаПользователей");
	
КонецПроцедуры

#КонецОбласти
