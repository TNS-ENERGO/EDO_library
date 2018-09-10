#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Находит последний по дате корректирующий документ.
//
// Параметры:
//  Основание	 - ДокументСсылка.РеализацияТоваровУслуг - Корректируемый документ.
// 
// Возвращаемое значение:
//  ДокументСсылка.РеализацияТоваровУслуг - найденный документ исправления.
//
Функция ПоследнийКорректирующийДокумент(Основание) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	РеализацияТоваровУслуг.Ссылка КАК Ссылка
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.ДокументОснование = &Основание
	|	И РеализацияТоваровУслуг.ВидОперации <> ЗНАЧЕНИЕ(Перечисление.ВидыОпераций.Реализация)
	|	И РеализацияТоваровУслуг.Проведен
	|
	|УПОРЯДОЧИТЬ ПО
	|	РеализацияТоваровУслуг.Дата УБЫВ";
	
	Запрос.УстановитьПараметр("Основание", Основание);
	Результат = Запрос.Выполнить().Выбрать();
	
	Если Результат.Следующий()
		И Результат.Ссылка <> Основание Тогда
		Возврат ПоследнийКорректирующийДокумент(Результат.Ссылка);
	Иначе
		Возврат Основание;
	КонецЕсли;
	
КонецФункции

// Получение данных для формирования электронного документа.
//
// Параметры:
//  СсылкаНаОбъект - ДокументСсылка.РеализацияТоваровУслуг - ссылка на документ.
// 
// Возвращаемое значение:
//  Структура - структура данных для печати.
//
Функция ПолучитьДанныеДляЭД(СсылкаНаОбъект) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ
	|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
	|	РеализацияТоваровУслуг.НомерЭД КАК Номер,
	|	РеализацияТоваровУслуг.Дата КАК Дата,
	|	РеализацияТоваровУслуг.НомерИсправления КАК НомерИсправления,
	|	РеализацияТоваровУслуг.Дата КАК ДатаИсправления,
	|	РеализацияТоваровУслуг.НомерИсходногоДокумента КАК НомерИсходногоДокумента,
	|	РеализацияТоваровУслуг.ДатаИсходногоДокумента КАК ДатаИсходногоДокумента,
	|	РеализацияТоваровУслуг.НомерИсправленияИсходногоДокумента КАК НомерИсправленияИсходногоДокумента,
	|	РеализацияТоваровУслуг.ДатаИсправленияИсходногоДокумента КАК ДатаИсправленияИсходногоДокумента,
	|	РеализацияТоваровУслуг.НомерИсправляемогоКорректировочногоДокумента КАК НомерИсправляемогоКорректировочногоДокумента,
	|	РеализацияТоваровУслуг.ДатаИсправляемогоКорректировочногоДокумента КАК ДатаИсправляемогоКорректировочногоДокумента,
	|	РеализацияТоваровУслуг.ВидДокумента КАК ВидДокумента,
	|	РеализацияТоваровУслуг.ВидОперации КАК ВидОперации,
	|	РеализацияТоваровУслуг.Организация КАК Организация,
	|	РеализацияТоваровУслуг.Контрагент КАК Контрагент,
	|	РеализацияТоваровУслуг.БанковскийСчетОрганизации КАК БанковскийСчетОрганизации,
	|	РеализацияТоваровУслуг.ДоговорКонтрагента КАК ДоговорКонтрагента,
	|	РеализацияТоваровУслуг.ДоговорКонтрагента.Наименование КАК НаименованиеДоговора,
	|	РеализацияТоваровУслуг.ДоговорКонтрагента.НомерДоговора КАК НомерДоговора,
	|	РеализацияТоваровУслуг.ДоговорКонтрагента.ДатаДоговора КАК ДатаДоговора,
	|	РеализацияТоваровУслуг.Грузоотправитель КАК Грузоотправитель,
	|	РеализацияТоваровУслуг.Грузополучатель КАК Грузополучатель,
	|	РеализацияТоваровУслуг.Перевозчик КАК Перевозчик,
	|	РеализацияТоваровУслуг.НомерТранспортнойНакладной КАК НомерТранспортнойНакладной,
	|	РеализацияТоваровУслуг.ДатаТранспортнойНакладной КАК ДатаТранспортнойНакладной,
	|	РеализацияТоваровУслуг.СведенияОТранспортировкеИГрузе КАК СведенияОТранспортировкеИГрузе,
	|	РеализацияТоваровУслуг.СуммаДокумента КАК СуммаДокумента,
	|	РеализацияТоваровУслуг.ЦенаВключаетНДС КАК ЦенаВключаетНДС,
	|	РеализацияТоваровУслуг.Валюта КАК Валюта,
	|	РеализацияТоваровУслуг.Валюта.Код КАК ВалютаКод,
	|	РеализацияТоваровУслуг.Валюта.Наименование КАК ВалютаНаименование,
	|	РеализацияТоваровУслуг.ДатаОтгрузки КАК ДатаОтгрузки,
	|	РеализацияТоваровУслуг.ИдентификаторГосКонтракта КАК ИдентификаторГосКонтракта,
	|	РеализацияТоваровУслуг.ДокументОснование КАК ДокументОснование,
	|	РеализацияТоваровУслуг.ОблагаетсяНДСУПокупателя КАК ОблагаетсяНДСУПокупателя
	|ИЗ
	|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
	|ГДЕ
	|	РеализацияТоваровУслуг.Ссылка В (&Ссылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	Товары.Ссылка,
	|	Товары.НомерСтроки КАК НомерСтроки,
	|	Товары.Номенклатура КАК Номенклатура,
	|	Товары.Номенклатура.Код КАК НоменклатураКод,
	|	Товары.Номенклатура.НаименованиеПолное КАК НоменклатураНаименование,
	|	Товары.Номенклатура.Артикул КАК НоменклатураАртикул,
	|	Товары.Номенклатура.ВидНоменклатуры.ТипНоменклатуры КАК ТипНоменклатуры,
	|	Товары.Характеристика КАК Характеристика,
	|	Товары.Характеристика.Код КАК ХарактеристикаКод,
	|	Товары.Характеристика.Наименование КАК ХарактеристикаНаименование,
	|	Товары.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	Товары.ЕдиницаИзмерения.Код КАК ЕдиницаИзмеренияКод,
	|	Товары.ЕдиницаИзмерения.Наименование КАК ЕдиницаИзмеренияНаименование,
	|	Товары.КоличествоДоКорректировки КАК КоличествоДоКорректировки,
	|	Товары.Количество КАК Количество,
	|	Товары.ЦенаДоКорректировки КАК ЦенаДоКорректировки,
	|	Товары.Цена КАК Цена,
	|	Товары.СуммаДоКорректировки КАК СуммаДоКорректировки,
	|	Товары.Сумма КАК Сумма,
	|	Товары.СтавкаНДС КАК СтавкаНДС,
	|	Товары.СуммаНДСДоКорректировки КАК СуммаНДСДоКорректировки,
	|	Товары.СуммаНДС КАК СуммаНДС,
	|	Товары.СуммаСНДСДоКорректировки КАК СуммаСНДСДоКорректировки,
	|	Товары.СуммаСНДС КАК СуммаСНДС,
	|	Товары.СуммаСНДСДоКорректировки - Товары.СуммаНДСДоКорректировки КАК СуммаБезНДСДоКорректировки,
	|	Товары.СуммаСНДС - Товары.СуммаНДС КАК СуммаБезНДС,
	|	Товары.СуммаАкцизаДоКорректировки КАК СуммаАкцизаДоКорректировки,
	|	Товары.СуммаАкциза КАК СуммаАкциза,
	|	Товары.НомерГТД КАК НомерГТД,
	|	Товары.СтранаПроисхождения.Код КАК СтранаПроисхожденияКод,
	|	Товары.СтранаПроисхождения.Наименование КАК СтранаПроисхожденияНаименование
	|ИЗ
	|	Документ.РеализацияТоваровУслуг.Товары КАК Товары
	|ГДЕ
	|	Товары.Ссылка В (&Ссылка)
	|
	|УПОРЯДОЧИТЬ ПО
	|	НомерСтроки";
	
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
	
	МассивРезультатов = Запрос.ВыполнитьПакет();
	
	ВыборкаШапки = МассивРезультатов[0].Выбрать();
	
	ВыборкаТоваров = МассивРезультатов[1].Выбрать();
	
	СтруктураДанных = Новый Структура;
	СтруктураДанных.Вставить("ВыборкаШапки",   ВыборкаШапки);
	СтруктураДанных.Вставить("ВыборкаТоваров", ВыборкаТоваров);
	
	Возврат СтруктураДанных;
	
КонецФункции

// _Демо начало примера

// Заполняет список команд печати.
// 
// Параметры:
//   КомандыПечати - ТаблицаЗначений - состав полей см. в функции УправлениеПечатью.СоздатьКоллекциюКомандПечати.
//
Процедура ДобавитьКомандыПечати(КомандыПечати) Экспорт
	
	КомандаПечати = КомандыПечати.Добавить();
	КомандаПечати.Идентификатор = "ТОРГ12";
	КомандаПечати.Представление = НСтр("ru = 'Товарная накладная'");
	КомандаПечати.ПроверкаПроведенияПередПечатью = Истина;
	
КонецПроцедуры

// Формирует печатные формы
//
// Параметры:
//  МассивОбъектов  - Массив    - ссылки на объекты, которые нужно распечатать;
//  ПараметрыПечати - Структура - дополнительные настройки печати;
//  КоллекцияПечатныхФорм - ТаблицаЗначений - сформированные табличные документы (выходной параметр).
//  ОбъектыПечати         - СписокЗначений  - значение - ссылка на объект;
//                                            представление - имя области в которой был выведен объект (выходной
//                                                            параметр);
//  ПараметрыВывода       - Структура       - дополнительные параметры сформированных табличных документов (выходной
//                                            параметр).
//
Процедура Печать(МассивОбъектов, ПараметрыПечати, КоллекцияПечатныхФорм, ОбъектыПечати, ПараметрыВывода) Экспорт
	
	Если УправлениеПечатью.НужноПечататьМакет(КоллекцияПечатныхФорм, "ТОРГ12") Тогда
		УправлениеПечатью.ВывестиТабличныйДокументВКоллекцию(
			КоллекцияПечатныхФорм,
			"ТОРГ12",
			НСтр("ru='Товарная накладная'"),
			_ДемоОбменСКонтрагентами.СформироватьТоварнуюНакладную(МассивОбъектов, ОбъектыПечати),
			,
			"Документ.РеализацияТоваровУслуг.ПФ_MXL_ТОРГ12");
	КонецЕсли;
	
КонецПроцедуры

// _Демо конец примера

#КонецОбласти

#КонецЕсли

#Область ОбработчикиСобытий

Процедура ОбработкаПолученияПолейПредставления(Поля, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	Поля.Добавить("ПредставлениеНомера");
	Поля.Добавить("Дата");
	Поля.Добавить("ВидДокумента");
	Поля.Добавить("ВидОперации");
	
КонецПроцедуры

Процедура ОбработкаПолученияПредставления(Данные, Представление, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	Представление = КлиентЭДОКлиентСервер.ПредставлениеИсходящегоДокумента(Данные);
	
КонецПроцедуры

#КонецОбласти
