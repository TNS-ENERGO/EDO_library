////////////////////////////////////////////////////////////////////////////////
// ОбменСБанкамиПереопределяемый: механизм обмена электронными документами с банками.
//
////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Заполняет массив актуальными видами электронных документов для прикладного решения.
//
// Параметры:
//  Массив - Массив - виды актуальных ЭД:
//   * Перечисления.ВидыЭДОбменСБанками - вид электронного документа.
//
Процедура ПолучитьАктуальныеВидыЭД(Массив) Экспорт
	
	// _Демо начало примера
	
	Массив.Добавить(Перечисления.ВидыЭДОбменСБанками.ПлатежноеПоручение);
	Массив.Добавить(Перечисления.ВидыЭДОбменСБанками.ПлатежноеТребование);
	
	// Зарплатный проект
	Массив.Добавить(Перечисления.ВидыЭДОбменСБанками.СписокНаОткрытиеСчетовПоЗарплатномуПроекту);
	Массив.Добавить(Перечисления.ВидыЭДОбменСБанками.СписокУволенныхСотрудников);
	Массив.Добавить(Перечисления.ВидыЭДОбменСБанками.СписокНаЗачислениеДенежныхСредствНаСчетаСотрудников);
	
	// _Демо конец примера
	
КонецПроцедуры

// Используется для получения номеров счетов в виде массив строк
//
// Параметры:
//  Организация - СправочникСсылка.Организации - отбор по организации.
//  Банк - СправочникСсылка.КлассификаторБанков - отбор по банку.
//  МассивНомеровБанковскихСчетов - Массив - Массив возврата, в элементах строки с номерами счетов.
//
Процедура ПолучитьНомераБанковскихСчетов(Организация, Банк, МассивНомеровБанковскихСчетов) Экспорт
	
	// _Демо начало примера
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ
	               |	БанковскиеСчета.НомерСчета КАК НомерСчета
	               |ИЗ
	               |	Справочник.БанковскиеСчета КАК БанковскиеСчета
	               |ГДЕ
	               |	БанковскиеСчета.Банк = &Банк
	               |	И БанковскиеСчета.Владелец = &Организация
	               |	И НЕ БанковскиеСчета.ПометкаУдаления
	               |
	               |УПОРЯДОЧИТЬ ПО
	               |	НомерСчета";
	Запрос.УстановитьПараметр("Банк", Банк);
	Запрос.УстановитьПараметр("Организация", Организация);
	ТабРез = Запрос.Выполнить().Выгрузить();
	МассивНомеровБанковскихСчетов = ТабРез.ВыгрузитьКолонку("НомерСчета");
	// _Демо конец примера
	
КонецПроцедуры

// Определяет параметры электронного документа по типу владельца.
//
// Параметры:
//  Источник - ДокументСсылка, ДокументОбъект - Источник объекта, либо ссылка документа/справочника-источника.
//  ПараметрыЭД - Структура - структура параметров источника, необходимых для определения
//                настроек обмена ЭД. Обязательные параметры: ВидЭД, Банк, Организация.
//
Процедура ЗаполнитьПараметрыЭДПоИсточнику(Источник, ПараметрыЭД) Экспорт
	
	// _Демо начало примера
	ТипИсточника = ТипЗнч(Источник);
	Если ТипИсточника = Тип("ДокументСсылка._ДемоПлатежныйДокумент")
		ИЛИ ТипИсточника = Тип("ДокументОбъект._ДемоПлатежныйДокумент") Тогда
	
		Если Источник.ТипПлатежногоДокумента = Перечисления._ДемоТипыПлатежныхДокументов.ПлатежноеПоручение Тогда
			ПараметрыЭД.ВидЭД = Перечисления.ВидыЭДОбменСБанками.ПлатежноеПоручение;
		ИначеЕсли Источник.ТипПлатежногоДокумента = Перечисления._ДемоТипыПлатежныхДокументов.ПлатежноеТребование Тогда
			ПараметрыЭД.ВидЭД = Перечисления.ВидыЭДОбменСБанками.ПлатежноеТребование;
		КонецЕсли;
		ПараметрыЭД.Организация = Источник.Организация;
		ПараметрыЭД.Банк = Источник.СчетОрганизации.Банк;
	КонецЕсли;
	// _Демо конец примера
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Платежное поручение.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета ПлатежноеПоручение из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеПлатежныхПоручений(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
	// _Демо начало примера
	
	Счетчик = 0;
	Для Каждого СсылкаНаОбъект Из МассивСсылок Цикл
		
		ДеревоДокумента = ДанныеДляЗаполнения.Получить(Счетчик);
		Счетчик = Счетчик + 1;
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ПлатежноеПоручение.Дата,
		|	ПлатежноеПоручение.СуммаДокумента КАК Сумма,
		|	ПлатежноеПоручение.Контрагент.НаименованиеПолное КАК РеквизитыПолучателя_Наименование,
		|	ПлатежноеПоручение.Контрагент.ИНН КАК РеквизитыПолучателя_ИНН,
		|	ПлатежноеПоручение.Контрагент.КПП КАК РеквизитыПолучателя_КПП,
		|	ПлатежноеПоручение.СчетКонтрагента.НомерСчета КАК РеквизитыПолучателя_РасчСчет,
		|	ПлатежноеПоручение.СчетКонтрагента.Банк.Код КАК РеквизитыПолучателя_Банк_БИК,
		|	ПлатежноеПоручение.СчетКонтрагента.Банк.Наименование КАК РеквизитыПолучателя_Банк_Наименование,
		|	ПлатежноеПоручение.СчетКонтрагента.Банк.Город КАК РеквизитыПолучателя_Банк_Город,
		|	ПлатежноеПоручение.СчетКонтрагента.Банк.КоррСчет КАК РеквизитыПолучателя_Банк_КоррСчет,
		|	ПлатежноеПоручение.Организация.Наименование КАК РеквизитыПлательщика_Наименование,
		|	ПлатежноеПоручение.Организация.ИНН КАК РеквизитыПлательщика_ИНН,
		|	ПлатежноеПоручение.Организация.КПП КАК РеквизитыПлательщика_КПП,
		|	ПлатежноеПоручение.СчетОрганизации.НомерСчета КАК РеквизитыПлательщика_РасчСчет,
		|	ПлатежноеПоручение.СчетОрганизации.Банк.Код КАК РеквизитыПлательщика_Банк_БИК,
		|	ПлатежноеПоручение.СчетОрганизации.Банк.Наименование КАК РеквизитыПлательщика_Банк_Наименование,
		|	ПлатежноеПоручение.СчетОрганизации.Банк.Город КАК РеквизитыПлательщика_Банк_Город,
		|	ПлатежноеПоручение.СчетОрганизации.Банк.КоррСчет КАК РеквизитыПлательщика_Банк_КоррСчет,
		|	ПлатежноеПоручение.ВидПлатежа КАК РеквизитыПлатежа_ВидПлатежа,
		|	""01"" КАК РеквизитыПлатежа_ВидОплаты,
		|	ПлатежноеПоручение.ОчередностьПлатежа КАК РеквизитыПлатежа_Очередность,
		|	ПлатежноеПоручение.Идентификатор КАК РеквизитыПлатежа_Код,
		|	ПлатежноеПоручение.НазначениеПлатежа КАК РеквизитыПлатежа_НазначениеПлатежа,
		|	ПлатежноеПоручение.Контрагент КАК Получатель,
		|	ПлатежноеПоручение.ПлатежВБюджет КАК ПеречислениеВБюджет,
		|	ПлатежноеПоручение.СтатусСоставителя КАК ПлатежиВБюджет_СтатусСоставителя,
		|	ПлатежноеПоручение.КодБК КАК ПлатежиВБюджет_ПоказательКБК,
		|	ПлатежноеПоручение.КодОКАТО КАК ПлатежиВБюджет_ОКТМО,
		|	ПлатежноеПоручение.ПоказательОснования КАК ПлатежиВБюджет_ПоказательОснования,
		|	ВЫБОР
		|		КОГДА ПлатежноеПоручение.ПоказательПериода = """"
		|			ТОГДА ""0""
		|		ИНАЧЕ ПлатежноеПоручение.ПоказательПериода
		|	КОНЕЦ КАК ПлатежиВБюджет_ПоказательПериода,
		|	ВЫБОР
		|		КОГДА ПлатежноеПоручение.ПоказательНомера = """"
		|			ТОГДА ""0""
		|		ИНАЧЕ ПлатежноеПоручение.ПоказательНомера
		|	КОНЕЦ КАК ПлатежиВБюджет_ПоказательНомера,
		|	ВЫБОР
		|		КОГДА ПлатежноеПоручение.ПоказательДаты = """"
		|			ТОГДА ""0""
		|		ИНАЧЕ ПлатежноеПоручение.ПоказательДаты
		|	КОНЕЦ КАК ПлатежиВБюджет_ПоказательДаты
		|ИЗ
		|	Документ._ДемоПлатежныйДокумент КАК ПлатежноеПоручение
		|ГДЕ
		|	ПлатежноеПоручение.Ссылка = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
		ТаблицаДанныхДокумента = Запрос.Выполнить().Выгрузить();
		
		СтрокаДанных = ТаблицаДанныхДокумента[0];
		Индекс = 0;
		
		Для Индекс = 0 По 22 Цикл
			Путь = СтрЗаменить(ТаблицаДанныхДокумента.Колонки[Индекс].Имя, "_", ".");
			ЭлектронноеВзаимодействие.ЗаполнитьЗначениеРеквизитаВДереве(ДеревоДокумента, Путь, СтрокаДанных[Индекс]);
		КонецЦикла;
		
		Если СтрокаДанных.ПеречислениеВБюджет Тогда
			Для Индекс = 25 По 31 Цикл
				Путь = СтрЗаменить(ТаблицаДанныхДокумента.Колонки[Индекс].Имя, "_", ".");
				ЭлектронноеВзаимодействие.ЗаполнитьЗначениеРеквизитаВДереве(ДеревоДокумента, Путь, СтрокаДанных[Индекс]);
			КонецЦикла;
		КонецЕсли;

		ЭлектронноеВзаимодействие.ЗаполнитьЗначениеРеквизитаВДереве(ДеревоДокумента, "Получатель", СтрокаДанных.Получатель);
	
	КонецЦикла;
	// _Демо конец примера
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Платежное требование.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета ПлатежноеТребование из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеПлатежныхТребований(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
	// _Демо начало примера
	Счетчик = 0;
	Для Каждого СсылкаНаОбъект Из МассивСсылок Цикл
		
		ДеревоДокумента = ДанныеДляЗаполнения.Получить(Счетчик);
		Счетчик = Счетчик + 1;
		
		Запрос = Новый Запрос;
		Запрос.Текст =
		"ВЫБРАТЬ
		|	ПлатежноеТребование.Дата,
		|	ПлатежноеТребование.СуммаДокумента КАК Сумма,
		|	ПлатежноеТребование.Контрагент.НаименованиеПолное КАК РеквизитыПлательщика_Наименование,
		|	ПлатежноеТребование.Контрагент.ИНН КАК РеквизитыПлательщика_ИНН,
		|	ПлатежноеТребование.Контрагент.КПП КАК РеквизитыПлательщика_КПП,
		|	ПлатежноеТребование.СчетКонтрагента.НомерСчета КАК РеквизитыПлательщика_РасчСчет,
		|	ПлатежноеТребование.СчетКонтрагента.Банк.Код КАК РеквизитыПлательщика_Банк_БИК,
		|	ПлатежноеТребование.СчетКонтрагента.Банк.Наименование КАК РеквизитыПлательщика_Банк_Наименование,
		|	ПлатежноеТребование.СчетКонтрагента.Банк.Город КАК РеквизитыПлательщика_Банк_Город,
		|	ПлатежноеТребование.СчетКонтрагента.Банк.КоррСчет КАК РеквизитыПлательщика_Банк_КоррСчет,
		|	ПлатежноеТребование.Организация.Наименование КАК РеквизитыПолучателя_Наименование,
		|	ПлатежноеТребование.Организация.ИНН КАК РеквизитыПолучателя_ИНН,
		|	ПлатежноеТребование.Организация.КПП КАК РеквизитыПолучателя_КПП,
		|	ПлатежноеТребование.СчетОрганизации.НомерСчета КАК РеквизитыПолучателя_РасчСчет,
		|	ПлатежноеТребование.СчетОрганизации.Банк.Код КАК РеквизитыПолучателя_Банк_БИК,
		|	ПлатежноеТребование.СчетОрганизации.Банк.Наименование КАК РеквизитыПолучателя_Банк_Наименование,
		|	ПлатежноеТребование.СчетОрганизации.Банк.Город КАК РеквизитыПолучателя_Банк_Город,
		|	ПлатежноеТребование.СчетОрганизации.Банк.КоррСчет КАК РеквизитыПолучателя_Банк_КоррСчет,
		|	ПлатежноеТребование.ВидПлатежа КАК РеквизитыПлатежа_ВидПлатежа,
		|	""02"" КАК РеквизитыПлатежа_ВидОплаты,
		|	ПлатежноеТребование.ОчередностьПлатежа КАК РеквизитыПлатежа_Очередность,
		|	ПлатежноеТребование.НазначениеПлатежа КАК РеквизитыПлатежа_НазначениеПлатежа,
		|	ПлатежноеТребование.Идентификатор КАК РеквизитыПлатежа_Код,
		|	ПлатежноеТребование.УсловиеОплаты,
		|	ПлатежноеТребование.СрокАкцепта,
		|	ПлатежноеТребование.ДатаОтсылкиДокументов,
		|	ПлатежноеТребование.Контрагент КАК Плательщик
		|ИЗ
		|	Документ._ДемоПлатежныйДокумент КАК ПлатежноеТребование
		|ГДЕ
		|	ПлатежноеТребование.Ссылка = &Ссылка";
		
		Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
		ТаблицаДанныхДокумента = Запрос.Выполнить().Выгрузить();
		
		СтрокаДанных = ТаблицаДанныхДокумента[0];
		Индекс = 0;
		
		Для Индекс = 0 По 26 Цикл
			Путь = СтрЗаменить(ТаблицаДанныхДокумента.Колонки[Индекс].Имя, "_", ".");
			ЭлектронноеВзаимодействие.ЗаполнитьЗначениеРеквизитаВДереве(ДеревоДокумента, Путь, СтрокаДанных[Индекс]);
		КонецЦикла;
	КонецЦикла;
	// _Демо конец примера
		
КонецПроцедуры

// Подготавливает данные для электронного документа типа Поручение на перевод валюты.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета ПоручениеНаПереводВалюты из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеПорученийНаПереводВалюты(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Поручение на покупку валюты.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета ПоручениеНаПокупкуВалюты из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеПорученийНаПокупкуВалюты(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Поручение на продажу валюты.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета ПоручениеНаПродажуВалюты из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеПорученийНаПродажуВалюты(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Распоряжение на обязательную продажу валюты.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета РаспоряжениеНаОбязательнуюПродажуВалюты из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеРаспоряженийНаОбязательнуюПродажуВалюты(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
КонецПроцедуры

// Подготавливает данные для электронного документа типа Справка о подтверждающих документах.
//
// Параметры:
//  МассивСсылок - Массив - содержит ссылки на документы информационной базы, на основании которых будут созданы электронные документы.
//  ДанныеДляЗаполнения - Массив - содержит пустые деревья значений, которые необходимо заполнить данными.
//           Дерево значений повторяет структуру макета СправкаОПодтверждающихДокументах из обработки ОбменСБанками.
//           Если по какому-либо документу не удалось получить данные, то текст ошибки необходимо поместить вместо дерева значений.
//           ВНИМАНИЕ! Порядок элементов массива ДанныеДляЗаполнения соответствует порядку элементов массива МассивСсылок.
//
Процедура ЗаполнитьДанныеСправокОПодтверждающихДокументах(МассивСсылок, ДанныеДляЗаполнения) Экспорт
	
КонецПроцедуры

// Вызывается при получении уведомления о зачислении валюты
//
// Параметры:
//  ДеревоРазбора - ДеревоЗначений - дерево данных, соответствующее макету Обработки.ОбменСБанками.УведомлениеОЗачислении
//  НовыйДокументСсылка - ДокументСсылка - ссылка на созданный документ на основании данных электронного документа.
//
Процедура ПриПолученииУведомленияОЗачислении(ДеревоРазбора, НовыйДокументСсылка) Экспорт
	
КонецПроцедуры

// Заполняет список команд ЭДО.
// 
// Параметры:
//  СоставКомандЭДО - Массив - например "Документ.ПлатежныйДокумент".
//
Процедура ПодготовитьСтруктуруОбъектовКомандЭДО(СоставКомандЭДО) Экспорт
	
	// _Демо начало примера
	СоставКомандЭДО.Добавить("Документ._ДемоПлатежныйДокумент");
	// _Демо конец примера
	
КонецПроцедуры

// Включает тестовый режим обмена в банком.
// При включении тестового режима возможно ручное указание URL сервера для получения настроек обмена.
//
// Параметры:
//    ИспользуетсяТестовыйРежим - Булево - признак использования тестового режима.
//
Процедура ПроверитьИспользованиеТестовогоРежима(ИспользуетсяТестовыйРежим) Экспорт

	// _Демо начало примера

	УстановитьПривилегированныйРежим(Истина);

	Если СтрНайти(ВРег(Константы.ЗаголовокСистемы.Получить()), ВРег("DirectBank")) > 0 Тогда
		ИспользуетсяТестовыйРежим = Истина;
	КонецЕсли;
	// _Демо конец примера
	
КонецПроцедуры

#Область ЗарплатныйПроект

// Вызывается для формирования XML файла в прикладном решении.
//
// Параметры:
//    ОбъектДляВыгрузки - ДокументСсылка - ссылка на документ, на основании которого будет сформирован ЭД.
//    ИмяФайла - Строка - имя сформированного файла.
//    АдресФайла - АдресВременногоХранилища - содержит двоичные данные файла.
//
Процедура ПриФормированииXMLФайла(ОбъектДляВыгрузки, ИмяФайла, АдресФайла) Экспорт
	
КонецПроцедуры

// Формирует табличный документ на основании файла XML для визуального отображения электронного документа.
//
// Параметры:
//  ИмяФайла - Строка - полный путь к файлу XML
//  ТабличныйДокумент - ТабличныйДокумент - возвращаемое значение, визуальное отображение данных файла.
//
Процедура ЗаполнитьТабличныйДокумент(Знач ИмяФайла, ТабличныйДокумент) Экспорт
	
КонецПроцедуры

// Вызывается при получении файла из банка.
//
// Параметры:
//  АдресДанныхФайла - Строка - адрес временного хранилища с двоичными данными файла.
//  ИмяФайла - Строка - формализованное имя файла данных.
//  ОбъектВладелец - ДокументСсылка - (возвращаемый параметр) ссылка на документ, который был создан на основании ЭД.
//  ДанныеОповещения - Структура - (возвращаемый параметр) данные для вызова метода Оповестить на клиенте.
//                 * Ключ - Строка - имя события.
//                 * Значение - Произвольный - параметр сообщения.
Процедура ПриПолученииXMLФайла(АдресДанныхФайла, ИмяФайла, ОбъектВладелец, ДанныеОповещения) Экспорт
	
КонецПроцедуры

// Вызывается при изменении состояния электронного документооборота.
//
// Параметры:
//  СсылкаНаОбъект - ДокументСсылка - владелец электронного документооборота;
//  СостояниеЭД - ПеречислениеСсылка.СостоянияОбменСБанками - новое состояние электронного документооборота.
//
Процедура ПриИзмененииСостоянияЭД(СсылкаНаОбъект, СостояниеЭД) Экспорт
	
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

