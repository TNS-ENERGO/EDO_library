#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ОбработчикиСобытий

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, СтандартнаяОбработка)
	
	ТипДанныхЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипДанныхЗаполнения = Тип("ДокументСсылка.РеализацияТоваровУслуг") Тогда
		
		ЗаполнитьДокументНаОснованииРеализацииТоваровУслуг(ДанныеЗаполнения);
		
	ИначеЕсли ТипДанныхЗаполнения = Тип("ДокументСсылка.СчетФактураВыданный") Тогда
		
		ЗаполнитьДокументНаОснованииСчетаФактуры(ДанныеЗаполнения);
		
	ИначеЕсли ТипДанныхЗаполнения = Тип("Структура")
		И ДанныеЗаполнения.Свойство("Основание")
		И ДанныеЗаполнения.Свойство("ВидОперации", ВидОперации) Тогда
		
		ЗаполнитьДокументНаОснованииСчетаФактуры(ДанныеЗаполнения.Основание);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередЗаписью(Отказ)
	
	УстановитьПредставлениеНомера();
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ВидДокумента = Перечисления.ВидыДокументов.СчетФактураНаАванс
		ИЛИ ДокументыОснования.Количество() = 0 Тогда
		
		СуммаДокумента = Товары.Итог("Сумма");
		
		Если ОблагаетсяНДСУПокупателя Тогда
			Для Каждого СтрокаТаблицы Из Товары Цикл
				СтрокаТаблицы.СтавкаНДС = Неопределено;
				СтрокаТаблицы.СуммаНДС  = 0;
			КонецЦикла;
		КонецЕсли;
		
	Иначе
		
		Если НЕ ПометкаУдаления Тогда
			ПроверитьДублиСчетФактуры(Отказ);
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	ПредставлениеНомера = "";
	
	НомерЭД = "";
	СчетФактураОснование = Неопределено;
	ДатаВыставления = Дата(1,1,1);
	Выставлен = Ложь;
	
	НомерИсправления = 0;
	НомерИсправленияИсходногоДокумента = 0;
	НомерИсправляемогоКорректировочногоДокумента = "";
	НомерИсходногоДокумента = "";
	ДатаИсправленияИсходногоДокумента = Дата(1,1,1);
	ДатаИсправляемогоКорректировочногоДокумента = Дата(1,1,1);
	ДатаИсходногоДокумента = Дата(1,1,1);
	
	Если ДокументыОснования.Количество() Тогда
	
		Запрос = Новый Запрос;
		Запрос.Текст = 
			"ВЫБРАТЬ
			|	РеализацияТоваровУслугТовары.Номенклатура КАК Номенклатура,
			|	РеализацияТоваровУслугТовары.Характеристика КАК Характеристика,
			|	РеализацияТоваровУслугТовары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
			|	РеализацияТоваровУслугТовары.КоличествоДоКорректировки КАК КоличествоДоКорректировки,
			|	РеализацияТоваровУслугТовары.Количество КАК Количество,
			|	РеализацияТоваровУслугТовары.ЦенаДоКорректировки КАК ЦенаДоКорректировки,
			|	РеализацияТоваровУслугТовары.Цена КАК Цена,
			|	РеализацияТоваровУслугТовары.СуммаДоКорректировки КАК СуммаДоКорректировки,
			|	РеализацияТоваровУслугТовары.Сумма КАК Сумма,
			|	РеализацияТоваровУслугТовары.СтавкаНДС КАК СтавкаНДС,
			|	РеализацияТоваровУслугТовары.СуммаНДСДоКорректировки КАК СуммаНДСДоКорректировки,
			|	РеализацияТоваровУслугТовары.СуммаНДС КАК СуммаНДС,
			|	РеализацияТоваровУслугТовары.СуммаСНДСДоКорректировки КАК СуммаСНДСДоКорректировки,
			|	РеализацияТоваровУслугТовары.СуммаСНДС КАК СуммаСНДС,
			|	РеализацияТоваровУслугТовары.СуммаАкцизаДоКорректировки КАК СуммаАкцизаДоКорректировки,
			|	РеализацияТоваровУслугТовары.СуммаАкциза КАК СуммаАкциза,
			|	РеализацияТоваровУслугТовары.НомерГТД КАК НомерГТД,
			|	РеализацияТоваровУслугТовары.СтранаПроисхождения КАК СтранаПроисхождения
			|ИЗ
			|	Документ.РеализацияТоваровУслуг.Товары КАК РеализацияТоваровУслугТовары
			|ГДЕ
			|	РеализацияТоваровУслугТовары.Ссылка В (&Основания)";
		
		Запрос.УстановитьПараметр("Основания", ДокументыОснования.ВыгрузитьКолонку("ДокументОснование"));
		
		Товары.Загрузить(Запрос.Выполнить().Выгрузить());
		
		ДокументыОснования.Очистить();
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	
	Если ВидОперации = Перечисления.ВидыОпераций.Исправление Тогда
		Префикс = "И";
	Иначе
		Префикс = "0";
	КонецЕсли;
	
КонецПроцедуры

Процедура ОбработкаПроверкиЗаполнения(Отказ, ПроверяемыеРеквизиты)
	
	Если Не ЗначениеЗаполнено(СчетФактураОснование)
		И (ВидОперации = Перечисления.ВидыОпераций.Исправление
		ИЛИ ВидОперации = Перечисления.ВидыОпераций.Корректировка) Тогда
		
		ТекстСообщения = СтрШаблон(НСтр("ru = 'Не выбран счет-фактура к %1.'"),
			?(ВидОперации = Перечисления.ВидыОпераций.Исправление,
				НСтр("ru = 'исправлению'"), НСтр("ru = 'корректировке'")));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка, ,
			"СчетФактураОснованиеПредставление", Отказ);
		
	КонецЕсли;
	
	МассивНепроверяемыхРеквизитов = Новый Массив;
	
	Если ВидДокумента = Перечисления.ВидыДокументов.СчетФактураНаАванс Тогда
		ПроверяемыеРеквизиты.Добавить("ПлатежноРасчетныеДокументы");
		МассивНепроверяемыхРеквизитов.Добавить("ДокументыОснования.ДокументОснование");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Номенклатура");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.ЕдиницаИзмерения");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Количество");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Цена");
		
	ИначеЕсли ДокументыОснования.Количество() Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары");
		
	ИначеЕсли ВидОперации = Перечисления.ВидыОпераций.Корректировка
		ИЛИ (ВидОперации = Перечисления.ВидыОпераций.Исправление
			И ЗначениеЗаполнено(НомерИсправляемогоКорректировочногоДокумента)) Тогда
		
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Количество");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Цена");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.Сумма");
		МассивНепроверяемыхРеквизитов.Добавить("Товары.СтавкаНДС");
		
		МассивСтрок = Товары.НайтиСтроки(Новый Структура("КоличествоДоКорректировки", 0));
		Для Каждого СтрокаТаблицы Из МассивСтрок Цикл
			Для Каждого Реквизит Из МассивНепроверяемыхРеквизитов Цикл
				ИмяКолонки = Сред(Реквизит, 8);
				Если НЕ ЗначениеЗаполнено(СтрокаТаблицы[ИмяКолонки]) Тогда
					ТекстСообщения = СтрШаблон(НСтр("ru = 'Не заполнена колонка ""%1"" в строке %2 списка ""Товары""'"),
						ИмяКолонки, СтрокаТаблицы.НомерСтроки);
					ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, Ссылка,
						"Товары[" + Формат(СтрокаТаблицы.НомерСтроки - 1, "ЧН=0") + "]." + ИмяКолонки, "Объект", Отказ);
				КонецЕсли;
			КонецЦикла;
		КонецЦикла;
		
	КонецЕсли;
	
	Если ОблагаетсяНДСУПокупателя Тогда
		МассивНепроверяемыхРеквизитов.Добавить("Товары.СтавкаНДС");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(МассивНепроверяемыхРеквизитов) Тогда
		ОбщегоНазначения.УдалитьНепроверяемыеРеквизитыИзМассива(ПроверяемыеРеквизиты, МассивНепроверяемыхРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура УстановитьПредставлениеНомера()
	
	Если ПустаяСтрока(Номер) Тогда
		УстановитьНовыйНомер();
	КонецЕсли;
	
	Если ПустаяСтрока(НомерЭД) Тогда
		НомерЭД = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(Номер, Истина, Истина);
	КонецЕсли;
	
	Если ЗначениеЗаполнено(НомерИсправления) Тогда
		ПредставлениеНомера = СтрШаблон(НСтр("ru = '%1 (испр. %2)'"),
			НомерЭД, НомерИсправления);
	Иначе
		ПредставлениеНомера = НомерЭД;
	КонецЕсли;
	
КонецПроцедуры

Процедура ПроверитьДублиСчетФактуры(Отказ)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ДокументыОснования.ДокументОснование КАК Ссылка
	|ПОМЕСТИТЬ Основания
	|ИЗ
	|	&ДокументыОснования КАК ДокументыОснования
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ДанныеДокумента.Ссылка КАК Ссылка,
	|	Основания.Ссылка КАК ДокументОснование
	|ИЗ
	|	Документ.СчетФактураВыданный.ДокументыОснования КАК ДанныеДокумента
	|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Основания КАК Основания
	|		ПО ДанныеДокумента.ДокументОснование = Основания.Ссылка
	|ГДЕ
	|	ДанныеДокумента.Ссылка <> &Ссылка
	|	И НЕ ДанныеДокумента.Ссылка.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	Запрос.УстановитьПараметр("ДокументыОснования", ДокументыОснования);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		
		ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			НСтр("ru = 'Для документа %1 по организации %2 уже введен счет-фактура %3'"),
			Выборка.ДокументОснование, Организация, Выборка.Ссылка);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения,
			ЭтотОбъект, "ДокументыОснования",, Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьДокументНаОснованииРеализацииТоваровУслуг(ДанныеЗаполнения)
	
	СуществующийСФ = Документы.СчетФактураВыданный.СчетФактураДокумента(ДанныеЗаполнения);
	Если ЗначениеЗаполнено(СуществующийСФ)
		И СуществующийСФ <> Ссылка Тогда
		ТекстСообщения = СтрШаблон(НСтр("ru='На основании документа %1 был введен %2'"),
			ДанныеЗаполнения, СуществующийСФ);
		ВызватьИсключение ТекстСообщения;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	РеализацияТоваровУслуг.ВидОперации КАК ВидОперации,
		|	РеализацияТоваровУслуг.Организация КАК Организация,
		|	РеализацияТоваровУслуг.Контрагент КАК Контрагент,
		|	РеализацияТоваровУслуг.ДоговорКонтрагента КАК ДоговорКонтрагента,
		|	РеализацияТоваровУслуг.Валюта КАК Валюта,
		|	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
		|	РеализацияТоваровУслуг.ЦенаВключаетНДС КАК ЦенаВключаетНДС,
		|	РеализацияТоваровУслуг.ОблагаетсяНДСУПокупателя КАК ОблагаетсяНДСУПокупателя
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	РеализацияТоваровУслуг.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
	Выборка = Запрос.Выполнить().Выбрать();
	
	ДокументыОснования.Очистить();
	
	Если Выборка.Следующий() Тогда
		Валюта             = Выборка.Валюта;
		ВидОперации        = Выборка.ВидОперации;
		Организация        = Выборка.Организация;
		Контрагент         = Выборка.Контрагент;
		ДоговорКонтрагента = Выборка.ДоговорКонтрагента;
		СуммаДокумента     = Выборка.СуммаДокумента;
		ЦенаВключаетНДС    = Выборка.ЦенаВключаетНДС;
		ОблагаетсяНДСУПокупателя = Выборка.ОблагаетсяНДСУПокупателя;
		
		НоваяСтрока = ДокументыОснования.Добавить();
		НоваяСтрока.ДокументОснование = ДанныеЗаполнения;
		
	КонецЕсли;
	
	Если ВидОперации = Перечисления.ВидыОпераций.Исправление
		ИЛИ ВидОперации = Перечисления.ВидыОпераций.Корректировка Тогда
		
		Запрос = Новый Запрос;
		Запрос.Текст =
			"ВЫБРАТЬ
			|	СчетФактураВыданный.Ссылка КАК Ссылка,
			|	СчетФактураВыданный.ВидОперации КАК ВидОперации,
			|	СчетФактураВыданный.НомерЭД КАК НомерЭД,
			|	СчетФактураВыданный.НомерИсправления КАК НомерИсправления,
			|	СчетФактураВыданный.Дата КАК Дата,
			|	СчетФактураВыданный.НомерИсходногоДокумента КАК НомерИсходногоДокумента,
			|	СчетФактураВыданный.ДатаИсходногоДокумента КАК ДатаИсходногоДокумента,
			|	СчетФактураВыданный.НомерИсправленияИсходногоДокумента КАК НомерИсправленияИсходногоДокумента,
			|	СчетФактураВыданный.ДатаИсправленияИсходногоДокумента КАК ДатаИсправленияИсходногоДокумента,
			|	СчетФактураВыданный.НомерИсправляемогоКорректировочногоДокумента КАК НомерИсправляемогоКорректировочногоДокумента,
			|	СчетФактураВыданный.ДатаИсправляемогоКорректировочногоДокумента КАК ДатаИсправляемогоКорректировочногоДокумента
			|ИЗ
			|	Документ.СчетФактураВыданный.ДокументыОснования КАК СчетФактураВыданныйДокументыОснования
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
			|		ПО СчетФактураВыданныйДокументыОснования.ДокументОснование = РеализацияТоваровУслуг.ДокументОснование
			|			И (РеализацияТоваровУслуг.Ссылка = &Ссылка)
			|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный КАК СчетФактураВыданный
			|		ПО СчетФактураВыданныйДокументыОснования.Ссылка = СчетФактураВыданный.Ссылка
			|ГДЕ
			|	НЕ СчетФактураВыданный.ПометкаУдаления";
		
		Запрос.УстановитьПараметр("Ссылка", ДанныеЗаполнения);
		
		ВыборкаСчетФактураОснование = Запрос.Выполнить().Выбрать();
		
		СчетФактураОснование = Неопределено;
		Если ВыборкаСчетФактураОснование.Следующий() Тогда
			
			СчетФактураОснование = ВыборкаСчетФактураОснование.Ссылка;
			ЗаполнитьНомерДатуИсходногоДокумента(ВыборкаСчетФактураОснование);
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьДокументНаОснованииСчетаФактуры(СчетФактура)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	СчетФактураВыданный.ВидДокумента КАК ВидДокумента,
		|	СчетФактураВыданный.ВидОперации КАК ВидОперации,
		|	СчетФактураВыданный.НомерЭД КАК НомерЭД,
		|	СчетФактураВыданный.НомерИсправления КАК НомерИсправления,
		|	СчетФактураВыданный.Дата КАК Дата,
		|	СчетФактураВыданный.Валюта КАК Валюта,
		|	СчетФактураВыданный.Организация КАК Организация,
		|	СчетФактураВыданный.Контрагент КАК Контрагент,
		|	СчетФактураВыданный.ДоговорКонтрагента КАК ДоговорКонтрагента,
		|	СчетФактураВыданный.ИдентификаторГосКонтракта КАК ИдентификаторГосКонтракта,
		|	СчетФактураВыданный.СуммаДокумента КАК СуммаДокумента,
		|	СчетФактураВыданный.ЦенаВключаетНДС КАК ЦенаВключаетНДС,
		|	СчетФактураВыданный.ОблагаетсяНДСУПокупателя КАК ОблагаетсяНДСУПокупателя,
		|	СчетФактураВыданный.НомерИсходногоДокумента КАК НомерИсходногоДокумента,
		|	СчетФактураВыданный.ДатаИсходногоДокумента КАК ДатаИсходногоДокумента,
		|	СчетФактураВыданный.НомерИсправленияИсходногоДокумента КАК НомерИсправленияИсходногоДокумента,
		|	СчетФактураВыданный.ДатаИсправленияИсходногоДокумента КАК ДатаИсправленияИсходногоДокумента,
		|	СчетФактураВыданный.НомерИсправляемогоКорректировочногоДокумента КАК НомерИсправляемогоКорректировочногоДокумента,
		|	СчетФактураВыданный.ДатаИсправляемогоКорректировочногоДокумента КАК ДатаИсправляемогоКорректировочногоДокумента
		|ИЗ
		|	Документ.СчетФактураВыданный КАК СчетФактураВыданный
		|ГДЕ
		|	СчетФактураВыданный.Ссылка = &СчетФактураОснование
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	СчетФактураВыданныйТовары.Номенклатура КАК Номенклатура,
		|	СчетФактураВыданныйТовары.Характеристика КАК Характеристика,
		|	СчетФактураВыданныйТовары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
		|	СчетФактураВыданныйТовары.КоличествоДоКорректировки КАК КоличествоДоКорректировки,
		|	СчетФактураВыданныйТовары.Количество КАК Количество,
		|	СчетФактураВыданныйТовары.ЦенаДоКорректировки КАК ЦенаДоКорректировки,
		|	СчетФактураВыданныйТовары.Цена КАК Цена,
		|	СчетФактураВыданныйТовары.СуммаДоКорректировки КАК СуммаДоКорректировки,
		|	СчетФактураВыданныйТовары.Сумма КАК Сумма,
		|	СчетФактураВыданныйТовары.СтавкаНДС КАК СтавкаНДС,
		|	СчетФактураВыданныйТовары.СуммаНДСДоКорректировки КАК СуммаНДСДоКорректировки,
		|	СчетФактураВыданныйТовары.СуммаНДС КАК СуммаНДС,
		|	СчетФактураВыданныйТовары.СуммаСНДСДоКорректировки КАК СуммаСНДСДоКорректировки,
		|	СчетФактураВыданныйТовары.СуммаСНДС КАК СуммаСНДС,
		|	СчетФактураВыданныйТовары.СуммаАкцизаДоКорректировки КАК СуммаАкцизаДоКорректировки,
		|	СчетФактураВыданныйТовары.СуммаАкциза КАК СуммаАкциза,
		|	СчетФактураВыданныйТовары.НомерГТД КАК НомерГТД,
		|	СчетФактураВыданныйТовары.СтранаПроисхождения КАК СтранаПроисхождения
		|ИЗ
		|	Документ.СчетФактураВыданный.Товары КАК СчетФактураВыданныйТовары
		|ГДЕ
		|	СчетФактураВыданныйТовары.Ссылка = &СчетФактураОснование
		|;
		|
		|////////////////////////////////////////////////////////////////////////////////
		|ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
		|	РеализацияТоваровУслуг.ВидОперации КАК ВидОперации,
		|	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|		ВНУТРЕННЕЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный.ДокументыОснования КАК СчетФактураВыданныйДокументыОснования
		|		ПО РеализацияТоваровУслуг.ДокументОснование = СчетФактураВыданныйДокументыОснования.ДокументОснование
		|			И (СчетФактураВыданныйДокументыОснования.Ссылка = &СчетФактураОснование)
		|			И (НЕ РеализацияТоваровУслуг.ПометкаУдаления)
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный.ДокументыОснования КАК ОснованияСчетаФактуры
		|		ПО РеализацияТоваровУслуг.Ссылка = ОснованияСчетаФактуры.ДокументОснование
		|		ЛЕВОЕ СОЕДИНЕНИЕ Документ.СчетФактураВыданный КАК СчетФактураВыданный
		|		ПО (ОснованияСчетаФактуры.Ссылка = СчетФактураВыданный.Ссылка)
		|			И (НЕ(СчетФактураВыданный.ПометкаУдаления
		|					ИЛИ СчетФактураВыданный.Ссылка = &СчетФактура))
		|ГДЕ
		|	СчетФактураВыданный.Ссылка ЕСТЬ NULL";
	
	Запрос.УстановитьПараметр("СчетФактура", Ссылка);
	Запрос.УстановитьПараметр("СчетФактураОснование", СчетФактура);
	
	Если ЗначениеЗаполнено(ВидОперации) Тогда
		Запрос.Текст = Запрос.Текст + "
		|	И РеализацияТоваровУслуг.ВидОперации = &ВидОперации";
		Запрос.УстановитьПараметр("ВидОперации", ВидОперации);
	КонецЕсли;
	
	РезультатыЗапроса = Запрос.ВыполнитьПакет();
	
	СчетФактураОснование = СчетФактура;
	ДокументыОснования.Очистить();
	
	Если НЕ РезультатыЗапроса[0].Пустой() Тогда
		
		ВыборкаСчетФактураОснование = РезультатыЗапроса[0].Выбрать();
		ВыборкаСчетФактураОснование.Следующий();
		
		Если ЭтоНовый() Тогда
			ВидДокумента = ВыборкаСчетФактураОснование.ВидДокумента;
		КонецЕсли;
		
		Если ВидДокумента = Перечисления.ВидыДокументов.СчетФактураНаАванс
			И ВидОперации = Перечисления.ВидыОпераций.Корректировка Тогда
			ТекстСообщения = НСтр("ru='Для счета-фактуры с видом ""На аванс"" возможность корректировки не предусмотрена'");
			ВызватьИсключение ТекстСообщения;
		КонецЕсли;
		
		Валюта                    = ВыборкаСчетФактураОснование.Валюта;
		Организация               = ВыборкаСчетФактураОснование.Организация;
		Контрагент                = ВыборкаСчетФактураОснование.Контрагент;
		ДоговорКонтрагента        = ВыборкаСчетФактураОснование.ДоговорКонтрагента;
		ИдентификаторГосКонтракта = ВыборкаСчетФактураОснование.ИдентификаторГосКонтракта;
		ЦенаВключаетНДС           = ВыборкаСчетФактураОснование.ЦенаВключаетНДС;
		ОблагаетсяНДСУПокупателя  = ВыборкаСчетФактураОснование.ОблагаетсяНДСУПокупателя;
		
		ЗаполнитьНомерДатуИсходногоДокумента(ВыборкаСчетФактураОснование);
		
	КонецЕсли;
	
	Если НЕ РезультатыЗапроса[1].Пустой() Тогда
		Товары.Загрузить(РезультатыЗапроса[1].Выгрузить());
		
		Если ВидОперации = Перечисления.ВидыОпераций.Корректировка Тогда
			
			Для Каждого СтрокаТаблицы Из Товары Цикл
				СтрокаТаблицы.КоличествоДоКорректировки  = СтрокаТаблицы.Количество;
				СтрокаТаблицы.ЦенаДоКорректировки        = СтрокаТаблицы.Цена;
				СтрокаТаблицы.СуммаДоКорректировки       = СтрокаТаблицы.Сумма;
				СтрокаТаблицы.СуммаНДСДоКорректировки    = СтрокаТаблицы.СуммаНДС;
				СтрокаТаблицы.СуммаСНДСДоКорректировки   = СтрокаТаблицы.СуммаСНДС;
				СтрокаТаблицы.СуммаАкцизаДоКорректировки = СтрокаТаблицы.СуммаАкциза;
			КонецЦикла;
			
		КонецЕсли;
		
	ИначеЕсли НЕ РезультатыЗапроса[2].Пустой() Тогда
		
		ВыборкаОснование = РезультатыЗапроса[2].Выбрать();
		Пока ВыборкаОснование.Следующий() Цикл
			
			Если НЕ ЗначениеЗаполнено(ВидОперации) Тогда
				ВидОперации = ВыборкаОснование.ВидОперации;
			ИначеЕсли ВидОперации <> ВыборкаОснование.ВидОперации Тогда
				Продолжить;
			КонецЕсли;
			
			НоваяСтрока = ДокументыОснования.Добавить();
			НоваяСтрока.ДокументОснование = ВыборкаОснование.Ссылка;
			
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

Процедура ЗаполнитьНомерДатуИсходногоДокумента(ДокументОснование)
	
	Если ДокументОснование.ВидОперации = Перечисления.ВидыОпераций.Реализация Тогда
		НомерИсходногоДокумента = ДокументОснование.НомерЭД;
		ДатаИсходногоДокумента  = ДокументОснование.Дата;
		Если ВидОперации = Перечисления.ВидыОпераций.Исправление Тогда
			НомерИсправления = 1;
			НомерЭД = НомерИсходногоДокумента;
		КонецЕсли;
		
	ИначеЕсли ВидОперации = Перечисления.ВидыОпераций.Исправление
		И ДокументОснование.ВидОперации = Перечисления.ВидыОпераций.Корректировка Тогда
		
		НомерИсходногоДокумента = ДокументОснование.НомерИсходногоДокумента;
		ДатаИсходногоДокумента  = ДокументОснование.ДатаИсходногоДокумента;
		НомерИсправленияИсходногоДокумента = ДокументОснование.НомерИсправленияИсходногоДокумента;
		ДатаИсправленияИсходногоДокумента  = ДокументОснование.ДатаИсправленияИсходногоДокумента;
		НомерИсправляемогоКорректировочногоДокумента = ДокументОснование.НомерЭД;
		ДатаИсправляемогоКорректировочногоДокумента  = ДокументОснование.Дата;
		НомерИсправления = 1;
		НомерЭД = НомерИсправляемогоКорректировочногоДокумента;
		
	ИначеЕсли ВидОперации = Перечисления.ВидыОпераций.Исправление
		И ДокументОснование.ВидОперации = Перечисления.ВидыОпераций.Исправление Тогда
		
		НомерИсходногоДокумента = ДокументОснование.НомерИсходногоДокумента;
		ДатаИсходногоДокумента  = ДокументОснование.ДатаИсходногоДокумента;
		НомерИсправляемогоКорректировочногоДокумента = ДокументОснование.НомерИсправляемогоКорректировочногоДокумента;
		ДатаИсправляемогоКорректировочногоДокумента  = ДокументОснование.ДатаИсправляемогоКорректировочногоДокумента;
		НомерИсправления = ДокументОснование.НомерИсправления + 1;
		
		Если ЗначениеЗаполнено(ДокументОснование.НомерИсправляемогоКорректировочногоДокумента)
			И ЗначениеЗаполнено(ДокументОснование.ДатаИсправляемогоКорректировочногоДокумента) Тогда
			НомерИсправленияИсходногоДокумента = ДокументОснование.НомерИсправленияИсходногоДокумента;
			ДатаИсправленияИсходногоДокумента  = ДокументОснование.ДатаИсправленияИсходногоДокумента;
			НомерЭД = НомерИсправляемогоКорректировочногоДокумента;
		Иначе
			НомерИсправленияИсходногоДокумента = ДокументОснование.НомерИсправления;
			ДатаИсправленияИсходногоДокумента  = ДокументОснование.Дата;
			НомерЭД = НомерИсходногоДокумента;
		КонецЕсли;
		
	ИначеЕсли ВидОперации = Перечисления.ВидыОпераций.Корректировка
		И ДокументОснование.ВидОперации = Перечисления.ВидыОпераций.Корректировка Тогда
		
		НомерИсходногоДокумента = ДокументОснование.НомерЭД;
		ДатаИсходногоДокумента  = ДокументОснование.Дата;
		
	ИначеЕсли ВидОперации = Перечисления.ВидыОпераций.Корректировка
		И ДокументОснование.ВидОперации = Перечисления.ВидыОпераций.Исправление Тогда
		
		Если ЗначениеЗаполнено(ДокументОснование.НомерИсправляемогоКорректировочногоДокумента)
			И ЗначениеЗаполнено(ДокументОснование.ДатаИсправляемогоКорректировочногоДокумента) Тогда
			НомерИсходногоДокумента = ДокументОснование.НомерИсправляемогоКорректировочногоДокумента;
			ДатаИсходногоДокумента  = ДокументОснование.ДатаИсправляемогоКорректировочногоДокумента;
		Иначе
			НомерИсходногоДокумента = ДокументОснование.НомерИсходногоДокумента;
			ДатаИсходногоДокумента  = ДокументОснование.ДатаИсходногоДокумента;
		КонецЕсли;
		НомерИсправленияИсходногоДокумента = ДокументОснование.НомерИсправления;
		ДатаИсправленияИсходногоДокумента  = ДокументОснование.Дата;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#КонецЕсли