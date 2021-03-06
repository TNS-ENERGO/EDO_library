
#Область ПрограммныйИнтерфейс

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьСоответствиеСправочников.
Процедура ПолучитьСоответствиеСправочников(СоответствиеСправочников) Экспорт
	
	// Электронные документы
	СоответствиеСправочников.Вставить("Банки",  "КлассификаторБанков");
	СоответствиеСправочников.Вставить("Валюты", "Валюты");
	// Конец электронные документы
	
	СоответствиеСправочников.Вставить("Контрагенты",                 "Контрагенты");
	СоответствиеСправочников.Вставить("Организации",                 "Организации");
	СоответствиеСправочников.Вставить("ДоговорыКонтрагентов",        "ДоговорыКонтрагентов");
	СоответствиеСправочников.Вставить("Номенклатура",                "Номенклатура");
	СоответствиеСправочников.Вставить("ЕдиницыИзмерения",            "ЕдиницыИзмерения");
	СоответствиеСправочников.Вставить("НоменклатураПоставщиков",     "НоменклатураПоставщиков");
	СоответствиеСправочников.Вставить("БанковскиеСчетаОрганизаций",  "БанковскиеСчета");
	СоответствиеСправочников.Вставить("БанковскиеСчетаКонтрагентов", "БанковскиеСчета");
	СоответствиеСправочников.Вставить("УпаковкиНоменклатуры",        "ЕдиницыИзмерения");
	СоответствиеСправочников.Вставить("ФизическиеЛица",              "Пользователи");
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьСоответствиеНаименованийОбъектовМДИРеквизитов.
Процедура ПолучитьСоответствиеНаименованийОбъектовМДИРеквизитов(СоответствиеРеквизитовОбъекта) Экспорт
	
	// Обмен с контрагентами начало
	СоответствиеРеквизитовОбъекта.Вставить("РеализацияТоваровУслугВМетаданных",    "РеализацияТоваровУслуг");
	СоответствиеРеквизитовОбъекта.Вставить("ПоступлениеТоваровУслугВМетаданных",   "ПоступлениеТоваровУслуг");
	СоответствиеРеквизитовОбъекта.Вставить("ДатаВыставленияВСчетеФактуреВыданном", "ДатаВыставления");
	СоответствиеРеквизитовОбъекта.Вставить("ДатаПолученияВСчетеФактуреПолученном", "ДатаПолучения");
	
	СоответствиеРеквизитовОбъекта.Вставить("НомерСчета", "НомерСчета");
	СоответствиеРеквизитовОбъекта.Вставить("ИННКонтрагента",                       "ИНН");
	СоответствиеРеквизитовОбъекта.Вставить("КППКонтрагента",                       "КПП");
	СоответствиеРеквизитовОбъекта.Вставить("НаименованиеКонтрагента",              "Наименование");
	СоответствиеРеквизитовОбъекта.Вставить("НаименованиеКонтрагентаДляСообщенияПользователю", "Наименование");
	СоответствиеРеквизитовОбъекта.Вставить("ВнешнийКодКонтрагента",                "Код");
	СоответствиеРеквизитовОбъекта.Вставить("ПартнерКонтрагента",                   "Партнер");
	
	СоответствиеРеквизитовОбъекта.Вставить("ИННОрганизации",                       "ИНН");
	СоответствиеРеквизитовОбъекта.Вставить("КППОрганизации",                       "КПП");
	СоответствиеРеквизитовОбъекта.Вставить("ОГРНОрганизации",                      "ОГРН");
	СоответствиеРеквизитовОбъекта.Вставить("НаименованиеОрганизации",              "Наименование");
	СоответствиеРеквизитовОбъекта.Вставить("СокращенноеНаименованиеОрганизации",   "Наименование");
	
	СоответствиеРеквизитовОбъекта.Вставить("НомерДоговораКонтрагента",             "НомерДоговора");
	СоответствиеРеквизитовОбъекта.Вставить("ДатаДоговораКонтрагента",              "ДатаДоговора");
	// Обмен с контрагентами конец.
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.НайтиСсылкуНаОбъект.
Процедура НайтиСсылкуНаОбъект(ТипОбъекта, Результат, ИдОбъекта = "", ДополнительныеРеквизиты = Неопределено, ИДЭД = Неопределено) Экспорт
	
	Если ДополнительныеРеквизиты = Неопределено Тогда
		ДополнительныеРеквизиты = Новый Структура;
	КонецЕсли;
	
	// Обмен с контрагентами
	Если ТипОбъекта = "Валюты" ИЛИ ТипОбъекта = "ЕдиницыИзмерения" ИЛИ ТипОбъекта = "ХарактеристикиНоменклатуры" Тогда
		ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
		Результат = Неопределено; 
		КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Код", ИдОбъекта, Результат);
		
		Если Результат = Неопределено И ТипОбъекта = "ЕдиницыИзмерения" И ЗначениеЗаполнено(ДополнительныеРеквизиты)
			И ДополнительныеРеквизиты.Свойство("Наименование") Тогда
			
			Результат = Неопределено;
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Наименование", ДополнительныеРеквизиты.Наименование, Результат);
		КонецЕсли;
	ИначеЕсли (ТипОбъекта = "Контрагенты" ИЛИ ТипОбъекта = "Организации") И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		ПараметрПоиска = "";
		ИНН = "";
		КПП = "";
		
		Если ДополнительныеРеквизиты.Свойство("ИНН") Тогда
			ИНН = ДополнительныеРеквизиты.ИНН;
		КонецЕсли;
		
		Если ДополнительныеРеквизиты.Свойство("КПП") Тогда
			КПП = ДополнительныеРеквизиты.КПП;
		КонецЕсли;
		
		Если ЗначениеЗаполнено(ИНН) Тогда
			ОбменСКонтрагентамиКЭДО.СсылкаНаОбъектПоИННКПП(ТипОбъекта, ИНН, КПП, Результат);
		КонецЕсли;
		
		ИмяМетаданных = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
		
		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Наименование", ПараметрПоиска) Тогда
			Результат = Неопределено;
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяМетаданных, "Наименование", ПараметрПоиска, Результат);
		КонецЕсли;
		
	ИначеЕсли ТипОбъекта = "НоменклатураПоставщиков" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		
		Владелец = "";
		ДополнительныеРеквизиты.Свойство("Владелец", Владелец);
		
		ПараметрПоиска = "";
		Если ДополнительныеРеквизиты.Свойство("Идентификатор", ПараметрПоиска) И ЗначениеЗаполнено(ПараметрПоиска) Тогда
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = Неопределено; 
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Идентификатор", ПараметрПоиска, Результат, 
				 Владелец, Истина);
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Наименование", ПараметрПоиска)
			И ЗначениеЗаполнено(ПараметрПоиска) Тогда // по наименованию
			
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = Неопределено; 
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Наименование", ПараметрПоиска, Результат,
				Владелец, Истина);
		КонецЕсли;

		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Артикул", ПараметрПоиска)
			И ЗначениеЗаполнено(ПараметрПоиска) Тогда // по артикулу
			
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = Неопределено; 
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Артикул", ПараметрПоиска, Результат,
				Владелец, Истина);
		КонецЕсли;
	ИначеЕсли ТипОбъекта = "Номенклатура" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		
		ПараметрПоиска = "";
		Если ДополнительныеРеквизиты.Свойство("Идентификатор", ПараметрПоиска) И ЗначениеЗаполнено(ПараметрПоиска) Тогда
			Результат = НайтиСсылкуНаНоменклатуруПоИдентификаторуНоменклатурыПоставщика(ПараметрПоиска);
		КонецЕсли;
		
		Если НЕ ЗначениеЗаполнено(Результат) И ДополнительныеРеквизиты.Свойство("Артикул", ПараметрПоиска)
			И ЗначениеЗаполнено(ПараметрПоиска) Тогда
			
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = Неопределено; 
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "Код", ПараметрПоиска, Результат);
		КонецЕсли;
	
	ИначеЕсли ТипОбъекта = "БанковскиеСчетаОрганизаций" Или ТипОбъекта = "БанковскиеСчетаКонтрагентов" Тогда
		
		Владелец = "";
		Если ТипЗнч(ДополнительныеРеквизиты) = Тип("Структура") И ДополнительныеРеквизиты.Свойство("Владелец") Тогда
			Владелец = ДополнительныеРеквизиты.Владелец;
		КонецЕсли;
		
		ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);

 		Результат = Неопределено; 
		КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(ИмяПрикладногоСправочника, "НомерСчета", ИдОбъекта, Результат, Владелец);
		
	ИначеЕсли ТипОбъекта = "Банки" И ЗначениеЗаполнено(ДополнительныеРеквизиты) Тогда
		
		Владелец = "";
		ПараметрПоиска = Неопределено;
		
		Если ДополнительныеРеквизиты.Свойство("Код", ПараметрПоиска) И ЗначениеЗаполнено(ПараметрПоиска) Тогда
			ИмяПрикладногоСправочника = ЭлектронноеВзаимодействиеКЭДОПовтИсп.ИмяПрикладногоСправочника(ТипОбъекта);
			Результат = Неопределено; 
			КлиентЭДО.НайтиСсылкуНаОбъектПоРеквизиту(
				ИмяПрикладногоСправочника, "Код", ПараметрПоиска, Результат, Владелец, Истина);
		КонецЕсли;
			
	ИначеЕсли ВРег(ТипОбъекта) = ВРег("ДоговорыКонтрагентов") Тогда
		
		Результат = ДоговорКонтрагентаПоРеквизитам(ДополнительныеРеквизиты);
		
	ИначеЕсли ТипОбъекта = "ВидыКонтактнойИнформации" Тогда
		Если ИдОбъекта = "EmailКонтрагента" Тогда
			Результат = Справочники.ВидыКонтактнойИнформации.EmailКонтрагента;
		ИначеЕсли ИдОбъекта = "ТелефонКонтрагента" Тогда
			Результат = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента;
		ИначеЕсли ИдОбъекта = "ФаксКонтрагента" Тогда
			Результат = Справочники.ВидыКонтактнойИнформации.ФаксКонтрагента;
		КонецЕсли;
	ИначеЕсли ТипОбъекта = "СтраныМира" Тогда
		
		Результат = "";
	
	КонецЕсли;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьПечатныйНомерДокумента.
Процедура ПолучитьПечатныйНомерДокумента(СсылкаНаОбъект, Результат) Экспорт
	
	Результат = ПрефиксацияОбъектовКлиентСервер.НомерНаПечать(СсылкаНаОбъект.Номер, Истина);
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПроверитьГотовностьИсточников.
Процедура ПроверитьГотовностьИсточников(ДокументыМассив) Экспорт
	
	// Проверим проведенность документов.
	ОбщегоНазначенияКлиентСервер.УдалитьВсеВхожденияТипаИзМассива(
										ДокументыМассив,
										Тип("СтрокаГруппировкиДинамическогоСписка"));
	
	МассивНепроведенныхДокументов = ОбщегоНазначения.ПроверитьПроведенностьДокументов(ДокументыМассив);
	Если МассивНепроведенныхДокументов.Количество() <> 0 Тогда
		ШаблонСообщения = НСтр("ru = 'Документ %1 не проведен. Электронный документ не сформирован.'");
		Для Каждого НеПроведенныйДокумент Из МассивНепроведенныхДокументов Цикл
			Найденный = ДокументыМассив.Найти(НеПроведенныйДокумент.Ссылка);
			Если Найденный <> Неопределено Тогда
				
				ДокументыМассив.Удалить(Найденный);
				ТекстСообщения = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(ШаблонСообщения,
					Строка(НеПроведенныйДокумент.Ссылка));
				ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
			КонецЕсли;
		
		КонецЦикла;
	КонецЕсли;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПолучитьДанныеЮрФизЛица.
Процедура ПолучитьДанныеЮрФизЛица(ЮрФизЛицо, Сведения) Экспорт
	
	Сведения = Новый Структура("Ссылка, ОфициальноеНаименование, Наименование, Представление, ПолноеНаименование,
		| ЮрФизЛицо, КодПоОКПО, ИНН, КПП, ОГРН, Фамилия, Имя, Отчество, СвидетельствоСерияНомер, СвидетельствоДатаВыдачи,
		| Банк, БИК, КоррСчет, НомерСчета, ЮридическийАдрес, ЮридическийАдресЗначенияПолей, ЭлектроннаяПочта, Телефоны");
	
	Если НЕ ЗначениеЗаполнено(ЮрФизЛицо) Тогда
		Возврат
	КонецЕсли;
	
	Сведения.Ссылка = ЮрФизЛицо;
	
	Реквизиты = "ЮрФизЛицо, НаименованиеПолное, Наименование, ИНН, КПП, КодПоОКПО";
	
	Если ТипЗнч(ЮрФизЛицо) = Тип("СправочникСсылка.Организации") Тогда
		Реквизиты = Реквизиты + ", ОГРН, СвидетельствоСерияНомер, СвидетельствоДатаВыдачи";
	КонецЕсли;
	
	СтруктураДанных = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(ЮрФизЛицо, Реквизиты);
	
	СтруктураДанных.Свойство("ЮрФизЛицо",          Сведения.ЮрФизЛицо);
	СтруктураДанных.Свойство("НаименованиеПолное", Сведения.ПолноеНаименование);
	СтруктураДанных.Свойство("НаименованиеПолное", Сведения.ОфициальноеНаименование);
	СтруктураДанных.Свойство("Наименование",       Сведения.Наименование);
	СтруктураДанных.Свойство("ИНН",                Сведения.ИНН);
	СтруктураДанных.Свойство("КПП",                Сведения.КПП);
	СтруктураДанных.Свойство("КодПоОКПО",          Сведения.КодПоОКПО);
	
	СтруктураДанных.Свойство("ОГРН",                    Сведения.ОГРН);
	СтруктураДанных.Свойство("СвидетельствоСерияНомер", Сведения.СвидетельствоСерияНомер);
	СтруктураДанных.Свойство("СвидетельствоДатаВыдачи", Сведения.СвидетельствоДатаВыдачи);
	
	Если Сведения.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель
		ИЛИ Сведения.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ФизЛицо Тогда
		ФИО = ФизическиеЛицаКлиентСервер.ЧастиИмени(Сведения.ПолноеНаименование);
		Сведения.Вставить("Фамилия",  ФИО.Фамилия);
		Сведения.Вставить("Имя",      ФИО.Имя);
		Сведения.Вставить("Отчество", ФИО.Отчество);
	КонецЕсли;
	
	ТаблицаКИ = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(ЮрФизЛицо,,,Ложь);
	
	Для Каждого СтрокаТаблицыКИ Из ТаблицаКИ Цикл
		
		Если СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации
			ИЛИ СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.ЮрАдресКонтрагента Тогда
			
			Сведения.ЮридическийАдресЗначенияПолей = СтрокаТаблицыКИ.ЗначенияПолей;
			Сведения.ЮридическийАдрес = СтрокаТаблицыКИ.Представление;
			
		ИначеЕсли СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонОрганизации
			ИЛИ СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.ТелефонКонтрагента Тогда
			
			Сведения.Телефоны = СтрокаТаблицыКИ.Представление;
			
		ИначеЕсли СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.EmailОрганизации
			ИЛИ СтрокаТаблицыКИ.Вид = Справочники.ВидыКонтактнойИнформации.EmailКонтрагента Тогда
			
			Сведения.ЭлектроннаяПочта = СтрокаТаблицыКИ.Представление;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ЕстьПравоОткрытияЖурналаРегистрации.
Процедура ЕстьПравоОткрытияЖурналаРегистрации(Результат) Экспорт
	
	Результат = Пользователи.ЭтоПолноправныйПользователь(, , Ложь);
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ОписаниеОрганизации.
Процедура ОписаниеОрганизации(СведенияОрганизации, Результат, Список = "", СПрефиксом = Истина) Экспорт
	
	Результат = КлиентЭДО.ОписаниеОрганизации(СведенияОрганизации, Список, СПрефиксом);
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ЗаполнитьРегистрационныеДанныеОрганизации.
Процедура ЗаполнитьРегистрационныеДанныеОрганизации(Организация, ДанныеОрганизации) Экспорт
	
	СвойстваОрганизации = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Организация,
			"НаименованиеПолное, ИНН, КПП, ОГРН, ЮрФизЛицо");
	
	ОрганизацияФизЛицо = (СвойстваОрганизации.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ИндивидуальныйПредприниматель
		ИЛИ СвойстваОрганизации.ЮрФизЛицо = Перечисления.ЮрФизЛицо.ФизЛицо);
	
	ДанныеОрганизации.Вставить("ОрганизацияСсылка", Организация);
	
	ДанныеОрганизации.Вставить("Наименование"   , СвойстваОрганизации.НаименованиеПолное);
	ДанныеОрганизации.Вставить("ИНН"            , СвойстваОрганизации.ИНН);
	ДанныеОрганизации.Вставить("КПП"            , СвойстваОрганизации.КПП);
	ДанныеОрганизации.Вставить("ОГРН"           , СвойстваОрганизации.ОГРН);
	ДанныеОрганизации.Вставить("КодИМНС"        , "");
	
	Если ОрганизацияФизЛицо Тогда
		ДанныеОрганизации.Вставить("ЮрФизЛицо"      , "ФизЛицо");
	Иначе
		ДанныеОрганизации.Вставить("ЮрФизЛицо"      , "ЮрЛицо");
	КонецЕсли;
	
	ВидКонтактнойИнформации = Справочники.ВидыКонтактнойИнформации.ЮрАдресОрганизации;
	
	ДанныеОрганизации.Вставить("Индекс"         , "");
	ДанныеОрганизации.Вставить("Регион"         , "");
	ДанныеОрганизации.Вставить("Район"          , "");
	ДанныеОрганизации.Вставить("Город"          , "");
	ДанныеОрганизации.Вставить("НаселенныйПункт", "");
	ДанныеОрганизации.Вставить("Улица"          , "");
	ДанныеОрганизации.Вставить("Дом"            , "");
	ДанныеОрганизации.Вставить("Корпус"         , "");
	ДанныеОрганизации.Вставить("Квартира"       , "");
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	КонтактнаяИнформация.ЗначенияПолей
	|ИЗ
	|	Справочник.Организации.КонтактнаяИнформация КАК КонтактнаяИнформация
	|ГДЕ
	|	КонтактнаяИнформация.Ссылка = &Ссылка
	|	И КонтактнаяИнформация.Вид = &Вид";
	
	Запрос = Новый Запрос;
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("Ссылка", Организация);
	Запрос.УстановитьПараметр("Вид",    ВидКонтактнойИнформации);
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		
		АдресСтруктурой = РаботаСАдресами.ПредыдущаяСтруктураКонтактнойИнформацииXML(Выборка.ЗначенияПолей);
		Если АдресСтруктурой.Свойство("Индекс") Тогда
			ДанныеОрганизации.Индекс = АдресСтруктурой.Индекс;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Регион") Тогда
			ДанныеОрганизации.Регион = АдресСтруктурой.Регион;
			ДанныеОрганизации.Вставить("КодРегиона", КодРегионаПоНазванию(АдресСтруктурой.Регион));
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Район") Тогда
			ДанныеОрганизации.Район = АдресСтруктурой.Район;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Город") Тогда
			ДанныеОрганизации.Город = АдресСтруктурой.Город;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("НаселенныйПункт") Тогда
			ДанныеОрганизации.НаселенныйПункт = АдресСтруктурой.НаселенныйПункт;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Улица") Тогда
			ДанныеОрганизации.Улица = АдресСтруктурой.Улица;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Дом") Тогда
			ДанныеОрганизации.Дом = АдресСтруктурой.Дом;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Корпус") Тогда
			ДанныеОрганизации.Корпус = АдресСтруктурой.Корпус;
		КонецЕсли;
		Если АдресСтруктурой.Свойство("Квартира") Тогда
			ДанныеОрганизации.Квартира = АдресСтруктурой.Квартира;
		КонецЕсли;
		
	КонецЕсли;
	
	ДанныеОрганизации.Вставить("Телефон", УправлениеКонтактнойИнформацией.КонтактнаяИнформацияОбъекта(
		Организация, Справочники.ВидыКонтактнойИнформации.ТелефонОрганизации));
	
КонецПроцедуры

// См. ЭлектронноеВзаимодействиеПереопределяемый.ПередЗаписьюВладельцаЭлектронногоДокумента.
Процедура ПередЗаписьюВладельцаЭлектронногоДокумента(Объект, ИзменилисьКлючевыеРеквизиты, Знач СостояниеЭлектронногоДокумента, ПодлежитОбменуЭД, Отказ) Экспорт
	
	Если Объект.ДополнительныеСвойства.Свойство("ИзменилисьКлючевыеРеквизиты")
		И Объект.ДополнительныеСвойства.ИзменилисьКлючевыеРеквизиты Тогда
		ИзменилисьКлючевыеРеквизиты = Истина;
		Возврат;
	КонецЕсли;
	
	Если ИзмененыКлючевыеРеквизитыОбъекта(Объект) Тогда
		ИзменилисьКлючевыеРеквизиты = Истина;
	КонецЕсли;
	
	Объект.ДополнительныеСвойства.Вставить("ИзменилисьКлючевыеРеквизиты", ИзменилисьКлючевыеРеквизиты);
	
КонецПроцедуры

// Сравнивает значения ключевых реквизитов объекта с данными информационной базы.
//
// Параметры:
//  Объект - ДокументОбъект - владелец электронного документа.
//
// Возвращаемое значение:
//  Булево - Истина, если значения реквизитов различаются.
//
Функция ИзмененыКлючевыеРеквизитыОбъекта(Объект) Экспорт
	
	МетаданныеОбъекта = Объект.Метаданные();
	ИмяОбъекта = МетаданныеОбъекта.ПолноеИмя();
	
	КлючевыеРеквизиты = Новый Структура;
	
	Если ИмяОбъекта = "Документ.РеализацияТоваровУслуг" Тогда
		// Реквизиты объекта
		СтрокаРеквизитовОбъекта = "Дата, Номер, Организация, Контрагент, Валюта";
		КлючевыеРеквизиты.Вставить("Шапка", СтрокаРеквизитовОбъекта);
		
		// Табличная часть
		СтрокаРеквизитовОбъекта = "Номенклатура, Количество, Цена, Сумма";
		КлючевыеРеквизиты.Вставить("Товары", СтрокаРеквизитовОбъекта);
	ИначеЕсли ИмяОбъекта = "Документ.СчетФактураВыданный" Тогда
		// Реквизиты объекта
		СтрокаРеквизитовОбъекта = "Дата, Номер, Организация, Контрагент, Валюта";
		КлючевыеРеквизиты.Вставить("Шапка", СтрокаРеквизитовОбъекта);
		
		// Табличная часть
		СтрокаРеквизитовОбъекта = "Номенклатура, Количество, Цена, Сумма";
		КлючевыеРеквизиты.Вставить("Товары", СтрокаРеквизитовОбъекта);
	КонецЕсли;
	
	Возврат ИзмененыРеквизитыОбъекта(Объект, КлючевыеРеквизиты);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ДоговорКонтрагентаПоРеквизитам(РеквизитыДоговора)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	ДоговорыКонтрагентов.Ссылка КАК Договор
	|ИЗ
	|	Справочник.ДоговорыКонтрагентов КАК ДоговорыКонтрагентов
	|ГДЕ
	|	ДоговорыКонтрагентов.НомерДоговора = &НомерДоговора
	|	И ДоговорыКонтрагентов.ДатаДоговора = &ДатаДоговора
	|	И ДоговорыКонтрагентов.Организация = &Организация
	|	И ДоговорыКонтрагентов.Владелец = &Владелец";
	Запрос.УстановитьПараметр("НомерДоговора", РеквизитыДоговора.НомерДоговора);
	Запрос.УстановитьПараметр("ДатаДоговора", РеквизитыДоговора.ДатаДоговора);
	Запрос.УстановитьПараметр("Организация", РеквизитыДоговора.Организация);
	Запрос.УстановитьПараметр("Владелец", РеквизитыДоговора.Владелец);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	
	Возврат Выборка.Договор;
	
КонецФункции

Функция КодРегионаПоНазванию(Знач Название)
	
	Если НЕ ЗначениеЗаполнено(Название) Тогда
		Возврат "";
	КонецЕсли;
	
	Название = СокрЛП(Название);
	ПервыйПробел = Найти(Название, " ");
	Если ПервыйПробел <> 0 Тогда
		Название = Лев(Название, ПервыйПробел - 1);
	КонецЕсли;
	
	КодРегиона = АдресныйКлассификатор.КодРегионаПоНаименованию(Название);
	
	Если ЗначениеЗаполнено(КодРегиона) Тогда
		Возврат Формат(КодРегиона, "ЧЦ=2; ЧВН=");
	КонецЕсли;
	
	Возврат "";
	
КонецФункции

Функция НайтиСсылкуНаНоменклатуруПоИдентификаторуНоменклатурыПоставщика(Идентификатор)
	
	Результат = Неопределено;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	СпрНоменклатура.Номенклатура КАК Ссылка
	|ИЗ
	|	Справочник.НоменклатураПоставщиков КАК СпрНоменклатура
	|ГДЕ
	|	СпрНоменклатура.Идентификатор = &Идентификатор";
	Запрос.УстановитьПараметр("Идентификатор", Идентификатор);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Если Выборка.Следующий() Тогда
		Результат = Выборка.Ссылка;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ИзмененыРеквизитыОбъекта(Знач Объект, Знач Реквизиты)
	
	МетаданныеОбъекта = Объект.Метаданные();
	
	ТаблицаРеквизитов = ТаблицаРеквизитовОбъектов();
	
	ТекущийПорядок = -50;
	Для Каждого Реквизит Из Реквизиты Цикл
		
		СтрокаРеквизитов = ТаблицаРеквизитов.Добавить();
		СтрокаРеквизитов.Порядок  = ТекущийПорядок;
		СтрокаРеквизитов.ИмяОбъекта = МетаданныеОбъекта.ПолноеИмя();
		СтрокаРеквизитов.ИмяТабличнойЧасти = ?(Реквизит.Ключ = "Шапка", "", Реквизит.Ключ);
		СтрокаРеквизитов.РеквизитыОбъекта = Реквизит.Значение;
		СтрокаРеквизитов.СтруктураРеквизитовОбъекта = Новый Структура(Реквизит.Значение);
		ТекущийПорядок = ТекущийПорядок + 100;
		
	КонецЦикла;
	
	ТаблицаРеквизитов.Сортировать("Порядок Возр");
	
	Для Каждого СтрокаРеквизитов Из ТаблицаРеквизитов Цикл
		
		ЕстьИзмененияВерсийОбъектов = ОпределитьИзмененияВерсийОбъекта(Объект, СтрокаРеквизитов);
		
		Если ЕстьИзмененияВерсийОбъектов Тогда
			Возврат Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ложь;
	
КонецФункции

Функция ТаблицаРеквизитовОбъектов()
	
	ТаблицаРеквизитов = Новый ТаблицаЗначений;
	
	Колонки = ТаблицаРеквизитов.Колонки;
	Колонки.Добавить("Порядок",                    Новый ОписаниеТипов("Число"));
	Колонки.Добавить("ИмяОбъекта",                 Новый ОписаниеТипов("Строка"));
	Колонки.Добавить("ИмяТабличнойЧасти",          Новый ОписаниеТипов("Строка"));
	Колонки.Добавить("РеквизитыОбъекта",           Новый ОписаниеТипов("Строка"));
	Колонки.Добавить("СтруктураРеквизитовОбъекта", Новый ОписаниеТипов("Структура"));
	
	ТаблицаРеквизитов.Индексы.Добавить("ИмяОбъекта");
	
	Возврат ТаблицаРеквизитов;
	
КонецФункции

Функция ОпределитьИзмененияВерсийОбъекта(Объект, СтрокаТаблицыРеквизитовРегистрации)
	
	Если ПустаяСтрока(СтрокаТаблицыРеквизитовРегистрации.ИмяТабличнойЧасти) Тогда
		
		ТаблицаРеквизитовРегистрацииВерсияОбъектаДоИзменения = РеквизитыРегистрацииШапкиДоИзменения(Объект,
			СтрокаТаблицыРеквизитовРегистрации);
		ТаблицаРеквизитовРегистрацииВерсияОбъектаПослеИзменения = РеквизитыРегистрацииШапкиПослеИзменения(
			Объект, СтрокаТаблицыРеквизитовРегистрации);
	Иначе
		
		ТаблицаРеквизитовРегистрацииВерсияОбъектаДоИзменения = РеквизитыРегистрацииТабличнойЧастиДоИзменения(
			Объект, СтрокаТаблицыРеквизитовРегистрации);
		ТаблицаРеквизитовРегистрацииВерсияОбъектаПослеИзменения = РеквизитыРегистрацииТабличнойЧастиПослеИзменения(
			Объект, СтрокаТаблицыРеквизитовРегистрации);
	КонецЕсли;
	
	Возврат НЕ ТаблицыРеквизитовОбъектовОдинаковые(ТаблицаРеквизитовРегистрацииВерсияОбъектаДоИзменения,
												   ТаблицаРеквизитовРегистрацииВерсияОбъектаПослеИзменения,
												   СтрокаТаблицыРеквизитовРегистрации.РеквизитыОбъекта);
	
КонецФункции

// Проверяет переданные таблицы реквизитов на совпадения.
//
// Параметры:
//  Таблица1 - ТаблицаЗначений - первая таблица проверки, реквизиты, которые надо проверить на совпадение.
//  Таблица2 - ТаблицаЗначений - вторая таблица проверки.
//  РеквизитыОбъекта - Строка - реквизиты, перечисленные через запятую.
//  ДопПараметры - Структура - структура дополнительных параметров, по которым надо проводить сравнение.
//
Функция ТаблицыРеквизитовОбъектовОдинаковые(Таблица1, Таблица2, РеквизитыОбъекта, ДопПараметры = Неопределено)
	
	ДобавитьИтераторТаблице(Таблица1, +1);
	ДобавитьИтераторТаблице(Таблица2, -1);
	
	ТаблицаРезультат = Таблица1.Скопировать();
	
	ОбщегоНазначенияКлиентСервер.ДополнитьТаблицу(Таблица2, ТаблицаРезультат);
	
	ТаблицаРезультат.Свернуть(РеквизитыОбъекта, "ИтераторТаблицыРеквизитовОбъекта");
	
	КоличествоОдинаковыхСтрок = ТаблицаРезультат.НайтиСтроки(Новый Структура("ИтераторТаблицыРеквизитовОбъекта", 0)).Количество();
	
	КоличествоСтрокТаблицы = ТаблицаРезультат.Количество();
	ПризнакСовпадения = КоличествоОдинаковыхСтрок = КоличествоСтрокТаблицы;
	
	Если НЕ ПризнакСовпадения И ЗначениеЗаполнено(ДопПараметры) Тогда
		Если ДопПараметры.Свойство("ИмяТабличнойЧасти") Тогда
			ИмяТабличнойЧасти = ДопПараметры.ИмяТабличнойЧасти;
		КонецЕсли;
		Если ДопПараметры.Свойство("СтрокаДереваСравнения") Тогда
			СтрокаДереваСравнения = ДопПараметры.СтрокаДереваСравнения;
		КонецЕсли;
		
		Если ИмяТабличнойЧасти = "Шапка" Тогда
			
			НовСтрокаДереваМесто = СтрокаДереваСравнения.Строки.Добавить();
			НовСтрокаДереваМесто.Место = НСтр("ru ='Реквизиты шапки'");
			Для Каждого ТекСтрокаТаб1 Из Таблица1 Цикл
				Для Каждого ТекКолонка Из Таблица1.Колонки Цикл
					ИмяКолонки = ТекКолонка.Имя;
					Если ИмяКолонки = "ИтераторТаблицыРеквизитовОбъекта" Тогда
						Продолжить;
					КонецЕсли;
					НайденнаяСтрокаТаб2 = Таблица2.Найти( - ТекСтрокаТаб1.ИтераторТаблицыРеквизитовОбъекта,
						"ИтераторТаблицыРеквизитовОбъекта");
					Если НЕ ЗначениеЗаполнено(НайденнаяСтрокаТаб2) 
						ИЛИ	НайденнаяСтрокаТаб2[ИмяКолонки] = ТекСтрокаТаб1[ИмяКолонки] Тогда
						Продолжить;
					КонецЕсли;
					НовСтрокаДереваРеквизита = НовСтрокаДереваМесто.Строки.Добавить();
					НовСтрокаДереваРеквизита.Реквизит  = ИмяКолонки;
					НовСтрокаДереваЗнч            = НовСтрокаДереваРеквизита.Строки.Добавить();
					НовСтрокаДереваЗнч.ЗначениеБД = ТекСтрокаТаб1[ИмяКолонки];
					НовСтрокаДереваЗнч.ЗначениеЭД = НайденнаяСтрокаТаб2[ИмяКолонки];
					
				КонецЦикла;
			КонецЦикла;
		Иначе
			НовСтрокаДереваМесто = СтрокаДереваСравнения.Строки.Добавить();
			НовСтрокаДереваМесто.Место = СтрШаблон(НСтр("ru ='Табличная часть <%1>'"), ИмяТабличнойЧасти);
			НовСтрокаДереваРеквизита = НовСтрокаДереваМесто.Строки.Добавить();
			НовСтрокаДереваРеквизита.Реквизит = "<Изменена>";
		КонецЕсли;
	КонецЕсли;
	
	Возврат ПризнакСовпадения;
	
КонецФункции

Процедура ДобавитьИтераторТаблице(Таблица, ЗначениеИтератора)
	
	Таблица.Колонки.Добавить("ИтераторТаблицыРеквизитовОбъекта");
	Таблица.ЗаполнитьЗначения(ЗначениеИтератора, "ИтераторТаблицыРеквизитовОбъекта");
	
КонецПроцедуры

Функция РеквизитыРегистрацииТабличнойЧастиПослеИзменения(Объект, СтрокаТаблицыРеквизитовРегистрации)
	
	ТаблицаРеквизитовРегистрации = Объект[СтрокаТаблицыРеквизитовРегистрации.ИмяТабличнойЧасти].Выгрузить(,
		СтрокаТаблицыРеквизитовРегистрации.РеквизитыОбъекта);
		
	Возврат ТаблицаРеквизитовРегистрации;
	
КонецФункции

Функция РеквизитыРегистрацииТабличнойЧастиДоИзменения(Объект, СтрокаТаблицыРеквизитовРегистрации)
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ "+ СтрокаТаблицыРеквизитовРегистрации.РеквизитыОбъекта + " ИЗ "
	+ СтрокаТаблицыРеквизитовРегистрации.ИмяОбъекта + "." + СтрокаТаблицыРеквизитовРегистрации.ИмяТабличнойЧасти
	+ " КАК ТекущийОбъектИмяТабличнойЧасти
	|ГДЕ
	|	ТекущийОбъектИмяТабличнойЧасти.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	
	Возврат Запрос.Выполнить().Выгрузить();
		
КонецФункции

Функция РеквизитыРегистрацииШапкиПослеИзменения(Объект, СтрокаТаблицыРеквизитовРегистрации)
	
	ТаблицаРеквизитовРегистрации = Новый ТаблицаЗначений;
	
	СтруктураРеквизитовРегистрации = СтрокаТаблицыРеквизитовРегистрации.СтруктураРеквизитовОбъекта;
	Для Каждого РеквизитРегистрации Из СтруктураРеквизитовРегистрации Цикл
		ТаблицаРеквизитовРегистрации.Колонки.Добавить(РеквизитРегистрации.Ключ);
	КонецЦикла;
	
	СтрокаТаблицы = ТаблицаРеквизитовРегистрации.Добавить();
	Для Каждого РеквизитРегистрации Из СтруктураРеквизитовРегистрации Цикл
		
		СтрокаТаблицы[РеквизитРегистрации.Ключ] = Объект[РеквизитРегистрации.Ключ];
	КонецЦикла;
	
	Возврат ТаблицаРеквизитовРегистрации;
	
КонецФункции

Функция РеквизитыРегистрацииШапкиДоИзменения(Объект, СтрокаТаблицыРеквизитовРегистрации)

	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ " + СтрокаТаблицыРеквизитовРегистрации.РеквизитыОбъекта + " ИЗ "
	+ СтрокаТаблицыРеквизитовРегистрации.ИмяОбъекта + " КАК ТекущийОбъект
	|ГДЕ
	|	ТекущийОбъект.Ссылка = &Ссылка";
	Запрос.УстановитьПараметр("Ссылка", Объект.Ссылка);
	
	Возврат Запрос.Выполнить().Выгрузить();
		
КонецФункции

#КонецОбласти