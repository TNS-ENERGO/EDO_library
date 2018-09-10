
#Область ПрограммныйИнтерфейс

#Область АвтоподборНоменклатуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьМассивПолейСобытияИзменениеТекстаРедактирования.
Процедура ЗаполнитьМассивПолейСобытияИзменениеТекстаРедактирования(МассивПолей) Экспорт
	
	МассивПолей.Добавить("Наименование");
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьМассивПолейСобытияПриИзменении.
Процедура ЗаполнитьМассивПолейСобытияПриИзменении(МассивПолей) Экспорт
	
	МассивПолей.Добавить("ЕдиницаИзмерения");
	
КонецПроцедуры

#КонецОбласти

#Область СозданиеВидаНоменклатуры

// См. РаботаСНоменклатуройПереопределяемый.СоздатьВидНоменклатуры.
Процедура СоздатьВидНоменклатуры(ДанныеЗаполнения, ВидНоменклатурыСсылка) Экспорт
	
	// Подготовка данных
	
	СтавкаНДС = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеЗаполнения.СтавкаНДС, СтавкаНДС);
	
	ТипНоменклатуры = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	ПреобразоватьТипНоменклатурыСервиса(ДанныеЗаполнения.Тип, ТипНоменклатуры);
	
	// Заполнение объекта
	
	ВидНоменклатурыОбъект = Справочники.ВидыНоменклатуры.СоздатьЭлемент();
	
	ВидНоменклатурыОбъект.Заполнить(Неопределено);
	ВидНоменклатурыОбъект.УстановитьНовыйКод();
	
	ВидНоменклатурыОбъект.Наименование    = ДанныеЗаполнения.Наименование;
	ВидНоменклатурыОбъект.СтавкаНДС       = СтавкаНДС;
	ВидНоменклатурыОбъект.ТипНоменклатуры = ТипНоменклатуры;
	ВидНоменклатурыОбъект.Описание        = ДанныеЗаполнения.Описание;
	
	ВидНоменклатурыОбъект.Записать();
	
	ВидНоменклатурыСсылка = ВидНоменклатурыОбъект.Ссылка;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.СоздатьЗначениеРеквизита.
Процедура СоздатьЗначениеРеквизита(ДополнительныйРеквизит, СтрокаДанных, ЗначениеРеквизитаСсылка) Экспорт
			
	НовоеЗначение = Справочники.ЗначенияСвойствОбъектов.СоздатьЭлемент();
	
	НовоеЗначение.Владелец = ДополнительныйРеквизит;
	НовоеЗначение.Наименование = СтрокаДанных.Наименование;
	НовоеЗначение.ПолноеНаименование = СтрокаДанных.Наименование;
	НовоеЗначение.Записать();
	
	ЗначениеРеквизитаСсылка = НовоеЗначение.Ссылка;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПрисвоитьРеквизитыОбъекту.
Процедура ПрисвоитьРеквизитыОбъекту(ВидНоменклатуры, ДополнительныеРеквизиты, ЯвляетсяРеквизитомХарактеристики) Экспорт
	
	Если ЯвляетсяРеквизитомХарактеристики Тогда
		НаборСвойствОбъект = ВидНоменклатуры.НаборСвойствХарактеристик.ПолучитьОбъект();	
	Иначе
		НаборСвойствОбъект = ВидНоменклатуры.НаборСвойств.ПолучитьОбъект();
	КонецЕсли;
	
	Для каждого ДополнительныйРеквизит Из ДополнительныеРеквизиты Цикл
		
		НоваяСтрокаРеквизита = НаборСвойствОбъект.ДополнительныеРеквизиты.Добавить();	
		
		НоваяСтрокаРеквизита.Свойство = ДополнительныйРеквизит;
		
	КонецЦикла;
	
	НаборСвойствОбъект.Записать();
		
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.СоздатьДополнительныйРеквизит.
Процедура СоздатьДополнительныйРеквизит(ВидНоменклатуры, СтрокаДанных, РеквизитСсылка) Экспорт
	
	// Подготовка данных
	
	НаборСвойств = ВидНоменклатуры.НаборСвойств;
	
	УИД = Новый УникальныйИдентификатор();
	СтрокаУИД = СтрЗаменить(Строка(УИД), "-", "");
	ИмяРеквизита = СтрокаДанных.Наименование + "_" + СтрокаУИД;
	
	НаименованиеНабора = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НаборСвойств, "Наименование");
	Наименование = СтрокаДанных.Наименование + " (" + НаименованиеНабора + ")";
	
	ОписаниеТипа = РаботаСНоменклатурой.ОписаниеТипаНаОснованииТипаСервиса(СтрокаДанных.Тип);
	
	// Заполнение объекта
	
	НовыйРеквизит = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.СоздатьЭлемент();
	
	НовыйРеквизит.Наименование = Наименование;
	НовыйРеквизит.Имя          = ИмяРеквизита;
	НовыйРеквизит.Заголовок    = СтрокаДанных.Наименование;
	НовыйРеквизит.НаборСвойств = НаборСвойств;
	НовыйРеквизит.ТипЗначения = ОписаниеТипа;
	НовыйРеквизит.Доступен = Истина;
	
	НовыйРеквизит.Записать();
	
	РеквизитСсылка = НовыйРеквизит.Ссылка;
		
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаписатьШтрихкоды.
Процедура ЗаписатьШтрихкоды(ДанныеПоШтрихкодам) Экспорт 
	
	ЕдиницыИзмерения = Новый Соответствие;
	
	Для каждого ЭлементКоллекции Из ДанныеПоШтрихкодам Цикл
		
		Если ЕдиницыИзмерения.Получить(ЭлементКоллекции.Номенклатура) = Неопределено Тогда
			ЕдиницыИзмерения.Вставить(ЭлементКоллекции.Номенклатура, 
				ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ЭлементКоллекции.Номенклатура, "ЕдиницаИзмерения"));
		КонецЕсли;
		
		НаборЗаписей = РегистрыСведений.Штрихкоды.СоздатьНаборЗаписей();
		
		НаборЗаписей.Отбор.Владелец.Установить(ЭлементКоллекции.Номенклатура);
		НаборЗаписей.Отбор.Характеристика.Установить(ЭлементКоллекции.Характеристика);
		НаборЗаписей.Отбор.Штрихкод.Установить(ЭлементКоллекции.Штрихкод);
		НаборЗаписей.Отбор.ЕдиницаИзмерения.Установить(ЕдиницыИзмерения.Получить(ЭлементКоллекции.Номенклатура));
		
		НоваяЗапись = НаборЗаписей.Добавить();
		
		НоваяЗапись.Владелец         = ЭлементКоллекции.Номенклатура;
		НоваяЗапись.Характеристика   = ЭлементКоллекции.Характеристика;
		НоваяЗапись.Штрихкод         = ЭлементКоллекции.Штрихкод;
		НоваяЗапись.ЕдиницаИзмерения = ЕдиницыИзмерения.Получить(ЭлементКоллекции.Номенклатура);
		
		НаборЗаписей.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьОтличияВидаНоменклатурыИКатегории.
Процедура ПолучитьОтличияВидаНоменклатурыИКатегории(ДанныеКатегории, ДанныеВидаНоменклатуры, ТаблицаОтличийРеквизитов) Экспорт
	
	// Проверка наименования
	
	Если ДанныеВидаНоменклатуры.Наименование <> ДанныеКатегории.Наименование Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"Наименование", ДанныеКатегории.Наименование, ДанныеВидаНоменклатуры.Наименование);
	КонецЕсли; 
	
	// Проверка ставки НДС
	
	СтавкаНДССервиса = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеКатегории.СтавкаНДС, СтавкаНДССервиса);
	
	Если ДанныеВидаНоменклатуры.СтавкаНДС <> СтавкаНДССервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"СтавкаНДС", СтавкаНДССервиса, ДанныеВидаНоменклатуры.СтавкаНДС, НСтр("ru = 'Ставка НДС'"));		
	КонецЕсли; 
	
	// Проверка типа номенклатуры
	
	ТипНоменклатурыСервиса = Перечисления.ТипыНоменклатуры.ПустаяСсылка();
	ПреобразоватьТипНоменклатурыСервиса(ДанныеКатегории.Тип, ТипНоменклатурыСервиса);
	
	Если ДанныеВидаНоменклатуры.ТипНоменклатуры <> ТипНоменклатурыСервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"ТипНоменклатуры", ТипНоменклатурыСервиса, ДанныеВидаНоменклатуры.ТипНоменклатуры, НСтр("ru = 'Тип номенклатуры'"));		
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти

#Область СозданиеНоменклатуры

#Область ОсновныеРеквизиты

// См. РаботаСНоменклатуройПереопределяемый.СоздатьНоменклатуру.
Процедура СоздатьНоменклатуру(ДанныеЗаполнения, НоменклатураСсылка) Экспорт
	
	// Подготовка данных
	
	СтавкаНДС = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеЗаполнения.СтавкаНДС, СтавкаНДС);
	
	СсылкаНаЕдиницуИзмерения = Справочники.ЕдиницыИзмерения.ПустаяСсылка();
	ЕдиницаИзмеренияПоДаннымСервиса(ДанныеЗаполнения.ЕдиницаИзмерения, СсылкаНаЕдиницуИзмерения);
	
	// Заполнение объекта
	
	НоменклатураОбъект = Справочники.Номенклатура.СоздатьЭлемент();
	НоменклатураОбъект.Заполнить(Неопределено);
	
	НоменклатураОбъект.УстановитьНовыйКод();
	
	НаименованиеПолное = ?(ЗначениеЗаполнено(ДанныеЗаполнения.НаименованиеДляПечати), 
		ДанныеЗаполнения.НаименованиеДляПечати, 
		ДанныеЗаполнения.Наименование);
		
	НоменклатураОбъект.Наименование =     ДанныеЗаполнения.Наименование;
	НоменклатураОбъект.Артикул =          ДанныеЗаполнения.Артикул;
	НоменклатураОбъект.НаименованиеПолное = НаименованиеПолное;
	НоменклатураОбъект.ЕдиницаИзмерения = СсылкаНаЕдиницуИзмерения;
	НоменклатураОбъект.СтавкаНДС =        СтавкаНДС;
	НоменклатураОбъект.Комментарий =      ДанныеЗаполнения.Описание;
	НоменклатураОбъект.ВидНоменклатуры =  ДанныеЗаполнения.ВидНоменклатурыПоУмолчанию.ВидНоменклатуры;
	
	НоменклатураОбъект.ОбменДанными.Загрузка = Истина;
	
	НоменклатураОбъект.Записать();
	
	НоменклатураСсылка = НоменклатураОбъект.Ссылка;
	
	// Сохранение изображения
	
	Если ЗначениеЗаполнено(ДанныеЗаполнения.Изображения) Тогда
		ПрикрепитьИзображения(НоменклатураСсылка, ДанныеЗаполнения.Изображения.ВыгрузитьКолонку("ИзображениеURL"));
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область Характеристики

// См. РаботаСНоменклатуройПереопределяемый.СоздатьХарактеристику.
Процедура СоздатьХарактеристику(Характеристика, Владелец, ХарактеристикаСсылка) Экспорт
	
	НоваяХарактеристика = Справочники.ХарактеристикиНоменклатуры.СоздатьЭлемент();
	
	НоваяХарактеристика.Владелец = Владелец;
	НоваяХарактеристика.Наименование = Характеристика.Наименование;
	
	НоваяХарактеристика.Записать();
	
	ХарактеристикаСсылка = НоваяХарактеристика.Ссылка;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.СоздатьХарактеристикуСДополнительнымиРеквизитами.
Процедура СоздатьХарактеристикуСДополнительнымиРеквизитами(Характеристика, Владелец, ХарактеристикаСсылка) Экспорт
	
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	ЗаполнитьЗначенияРеквизитовХарактеристики(
		ЗначенияДополнительныхРеквизитов, 
		Характеристика);
	
	Если ЗначенияДополнительныхРеквизитов.Количество() <> 0 Тогда
		ХарактеристикаСсылка = Неопределено;
		СоздатьХарактеристику(Характеристика, Владелец, ХарактеристикаСсылка);
		УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(ХарактеристикаСсылка, ЗначенияДополнительныхРеквизитов);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ДополнительныеРеквизиты

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьЗначенияДополнительныхРеквизитов.
Процедура ЗаполнитьЗначенияДополнительныхРеквизитов(ДанныеЗаполнения, НоменклатураСсылка) Экспорт 
		
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	Для каждого ДополнительныйРеквизит Из ДанныеЗаполнения Цикл
		
		Если НЕ ЗначениеЗаполнено(ДополнительныйРеквизит.РеквизитИнформационнойБазы) Тогда
			Продолжить;
		КонецЕсли;	
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = ДополнительныйРеквизит.РеквизитИнформационнойБазы;
		НоваяСтрока.Значение = РаботаСНоменклатурой.ЗначениеДополнительногоРеквизита(ДополнительныйРеквизит);
		
	КонецЦикла;
	
	Если ЗначенияДополнительныхРеквизитов.Количество() > 0 Тогда
		УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(НоменклатураСсылка, ЗначенияДополнительныхРеквизитов);
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьОтличияНоменклатуры.
Процедура ПолучитьОтличияНоменклатуры(ДанныеНоменклатурыСервиса, ДанныеНоменклатурыБазы, ТаблицаОтличийРеквизитов) Экспорт
	
	// Проверка простых типов
	
	СоответствиеПолей = Новый Структура();
	
	СоответствиеПолей.Вставить("Наименование", "Наименование");
	СоответствиеПолей.Вставить("Артикул",      "Артикул");
	
	Для каждого ЭлементКоллекции Из СоответствиеПолей Цикл
		Если ДанныеНоменклатурыБазы[ЭлементКоллекции.Значение] <> ДанныеНоменклатурыСервиса[ЭлементКоллекции.Ключ] Тогда
			РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
				ЭлементКоллекции.Значение, ДанныеНоменклатурыСервиса[ЭлементКоллекции.Ключ], ДанныеНоменклатурыБазы[ЭлементКоллекции.Значение]);
		КонецЕсли; 		
	КонецЦикла;
	
	Если ДанныеНоменклатурыБазы.НаименованиеПолное <> ДанныеНоменклатурыСервиса.Наименование Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"НаименованиеПолное", ДанныеНоменклатурыСервиса.Наименование, ДанныеНоменклатурыБазы.НаименованиеПолное, НСтр("ru = 'Полное наименование'"));
	КонецЕсли; 		
		
	// Проверка ставки НДС
	
	СтавкаНДССервиса = Перечисления.СтавкиНДС.ПустаяСсылка();
	ПреобразоватьСтавкуНДССервиса(ДанныеНоменклатурыСервиса.СтавкаНДС, СтавкаНДССервиса);
	
	Если ДанныеНоменклатурыБазы.СтавкаНДС <> СтавкаНДССервиса Тогда
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"СтавкаНДС", СтавкаНДССервиса, ДанныеНоменклатурыБазы.СтавкаНДС, НСтр("ru = 'Ставка НДС'"));		
	КонецЕсли; 
	
	// Единица измерения
	
	ЕдиницаИзмеренияСервиса = ДанныеНоменклатурыСервиса.ЕдиницаИзмерения;
	
	Если Строка(ДанныеНоменклатурыБазы.ЕдиницаИзмерения) <> ЕдиницаИзмеренияСервиса.Наименование Тогда
		
		ЕдиницаИзмеренияВБазе = Справочники.ЕдиницыИзмерения.ЕдиницаИзмеренияПоКоду(ЕдиницаИзмеренияСервиса.ОКЕИ);
		
		РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов, 
			"ЕдиницаИзмерения",  ЕдиницаИзмеренияВБазе, ДанныеНоменклатурыБазы.ЕдиницаИзмерения, НСтр("ru = 'Единица измерения'"), ЕдиницаИзмеренияСервиса.Наименование);
	КонецЕсли; 
	
	// Вид номенклатуры
	
	Если Не ЗначениеЗаполнено(ДанныеНоменклатурыБазы.ВидНоменклатуры) Тогда
		
		ВидыНоменклатуры = РаботаСНоменклатурой.ВидыНоменклатурыПоИдентификаторуКатегории(ДанныеНоменклатурыСервиса.Категория.Идентификатор);
		
		Если ВидыНоменклатуры.Количество() > 0 Тогда
			Если ВидыНоменклатуры.Найти(ДанныеНоменклатурыБазы.ВидНоменклатуры) = Неопределено Тогда 
				РаботаСНоменклатурой.ДобавитьСтрокуВТаблицуОтличий(ТаблицаОтличийРеквизитов,
				"ВидНоменклатуры", ВидыНоменклатуры[0], ДанныеНоменклатурыБазы.ВидНоменклатуры, НСтр("ru = 'Вид номенклатуры'"), ДанныеНоменклатурыСервиса.Категория.Наименование);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти

#Область ФункциональностьСистемы

// См. РаботаСНоменклатуройПереопределяемый.РазрешеноПакетноеСозданиеНоменклатуры.
Процедура РазрешеноПакетноеСозданиеНоменклатуры(РазрешеноПакетноеСоздание) Экспорт
	
	РазрешеноПакетноеСоздание = Истина;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ВедетсяУчетПоХарактеристикам.
Процедура ВедетсяУчетПоХарактеристикам(ИспользоватьХарактеристикиНоменклатуры) Экспорт
	
	ИспользоватьХарактеристикиНоменклатуры = ПолучитьФункциональнуюОпцию("ИспользоватьХарактеристикиНоменклатуры");
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ВедетсяУчетВидовНоменклатуры.
Процедура ВедетсяУчетВидовНоменклатуры(Результат) Экспорт
	
	Результат = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ПолучениеДанныхИнформационнойБазы

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьТаблицуХарактеристикПоВидуНоменклатуры.
Процедура ЗаполнитьТаблицуХарактеристикПоВидуНоменклатуры(ВидНоменклатуры, ЗначенияХарактеристикТекущейБазы) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст =
	"ВЫБРАТЬ
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка КАК ХарактеристикаБазы,
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Свойство КАК Свойство,
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Значение КАК Значение
	|ИЗ
	|	Справочник.ХарактеристикиНоменклатуры.ДополнительныеРеквизиты КАК ХарактеристикиНоменклатурыДополнительныеРеквизиты
	|ГДЕ
	|	ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка.Владелец = &ВидНоменклатуры
	|	И НЕ ХарактеристикиНоменклатурыДополнительныеРеквизиты.Ссылка.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("ВидНоменклатуры", ВидНоменклатуры);
	
	ЗначенияХарактеристикТекущейБазы = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ИспользуютсяИндивидуальныеХарактеристики.
Процедура ИспользуютсяИндивидуальныеХарактеристики(ВидНоменклатуры, Результат) Экспорт
	
	Результат = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ВидНоменклатуры, "ИндивидуальныеХарактеристикиНоменклатуры");	
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьДополнительныеРеквизитыВидаНоменклатуры.
Процедура ПолучитьДополнительныеРеквизитыВидаНоменклатуры(ВидНоменклатуры, ТаблицаРеквизитов) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	ДополнительныеРеквизиты.Свойство КАК РеквизитВидаНоменклатуры,
	|	ЛОЖЬ КАК ЯвляетсяХарактеристикой,
	|	ДополнительныеРеквизиты.Свойство.Заголовок КАК РеквизитВидаНоменклатурыПредставление
	|ИЗ
	|	Справочник.НаборыДополнительныхРеквизитовИСведений.ДополнительныеРеквизиты КАК ДополнительныеРеквизиты
	|ГДЕ
	|	ДополнительныеРеквизиты.Ссылка В
	|			(ВЫБРАТЬ
	|				ВидыНоменклатуры.НаборСвойств КАК НаборСвойств
	|			ИЗ
	|				Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|			ГДЕ
	|				ВидыНоменклатуры.Ссылка = &ВидНоменклатуры)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДополнительныеРеквизиты.Свойство,
	|	ИСТИНА,
	|	ДополнительныеРеквизиты.Свойство.Заголовок
	|ИЗ
	|	Справочник.НаборыДополнительныхРеквизитовИСведений.ДополнительныеРеквизиты КАК ДополнительныеРеквизиты
	|ГДЕ
	|	ДополнительныеРеквизиты.Ссылка В
	|			(ВЫБРАТЬ
	|				ВидыНоменклатуры.НаборСвойствХарактеристик КАК НаборСвойств
	|			ИЗ
	|				Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|			ГДЕ
	|				ВидыНоменклатуры.Ссылка = &ВидНоменклатуры)";
	
	Запрос.УстановитьПараметр("ВидНоменклатуры", ВидНоменклатуры);
	
	ТаблицаРеквизитов = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьЗначенияРеквизитовВидовНоменклатуры.
Процедура ПолучитьЗначенияРеквизитовВидовНоменклатуры(Знач ВидыНоменклатуры, Результат) Экспорт
	
	Если ТипЗнч(ВидыНоменклатуры) <> Тип("Массив") Тогда
		ВидыНоменклатуры = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(ВидыНоменклатуры);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	ВидыНоменклатуры.Ссылка КАК ВидНоменклатуры,
	|	ВидыНоменклатуры.Наименование КАК Наименование,
	|	ВидыНоменклатуры.ТипНоменклатуры КАК ТипНоменклатуры,
	|	ВидыНоменклатуры.СтавкаНДС КАК СтавкаНДС
	|ИЗ
	|	Справочник.ВидыНоменклатуры КАК ВидыНоменклатуры
	|ГДЕ
	|	ВидыНоменклатуры.Ссылка В(&ВидыНоменклатуры)";
	
	Запрос.УстановитьПараметр("ВидыНоменклатуры", ВидыНоменклатуры);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьЗначенияРеквизитовНоменклатуры.
Процедура ПолучитьЗначенияРеквизитовНоменклатуры(Знач Номенклатура, Результат) Экспорт
	
	Если ТипЗнч(Номенклатура) <> Тип("Массив") Тогда
		Номенклатура = ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Номенклатура);
	КонецЕсли;
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	Номенклатура.Артикул КАК Артикул,
	|	Номенклатура.Наименование КАК Наименование,
	|	Номенклатура.ЕдиницаИзмерения КАК ЕдиницаИзмерения,
	|	Номенклатура.СтавкаНДС КАК СтавкаНДС,
	|	Номенклатура.Ссылка КАК Номенклатура,
	|	Номенклатура.ВидНоменклатуры КАК ВидНоменклатуры,
	|	Номенклатура.Комментарий КАК Комментарий,
	|	Номенклатура.НаименованиеПолное КАК НаименованиеПолное
	|ИЗ
	|	Справочник.Номенклатура КАК Номенклатура
	|ГДЕ
	|	Номенклатура.Ссылка В(&Номенклатура)";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	Результат = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьВидНоменклатуры.
Процедура ПолучитьВидНоменклатуры(НоменклатураСсылка, ВидНоменклатуры) Экспорт
	
	ВидНоменклатуры = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(НоменклатураСсылка, "ВидНоменклатуры");
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьВидНоменклатурыИзФормы.
Процедура ПолучитьВидНоменклатурыИзФормы(Форма, ВидНоменклатуры) Экспорт
	
	ВидНоменклатуры = Форма.Объект.ВидНоменклатуры;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьЗначенияРеквизитовНоменклатурыИзФормы.
Процедура ПолучитьЗначенияРеквизитовНоменклатурыИзФормы(Форма, ЗначенияРеквизитов) Экспорт
	
	ЗначенияРеквизитов.Вставить("Наименование");
	ЗначенияРеквизитов.Вставить("СтавкаНДС");
	ЗначенияРеквизитов.Вставить("Комментарий");
	ЗначенияРеквизитов.Вставить("Артикул");
	ЗначенияРеквизитов.Вставить("ЕдиницаИзмерения");
	ЗначенияРеквизитов.Вставить("НаименованиеПолное");
	ЗначенияРеквизитов.Вставить("ВидНоменклатуры");
	
	Для каждого ЭлементКоллекции Из ЗначенияРеквизитов Цикл
		ЗначенияРеквизитов[ЭлементКоллекции.Ключ] = Форма.Объект[ЭлементКоллекции.Ключ];
	КонецЦикла;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьЗначенияДополнительныхРеквизитовИзФормы.
Процедура ПолучитьЗначенияДополнительныхРеквизитовИзФормы(Форма, ЗначенияРеквизитов) Экспорт
	
	УправлениеСвойствами.ПеренестиЗначенияИзРеквизитовФормыВОбъект(Форма,Форма.Объект);
	
	ЗначенияРеквизитов = Форма.Объект.ДополнительныеРеквизиты.Выгрузить(, "Свойство, Значение");
	
КонецПроцедуры

#КонецОбласти

#Область ЗаполнениеДанных

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьВидНоменклатуры.
Процедура ЗаполнитьВидНоменклатуры(ВидНоменклатурыСсылка, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ВидНоменклатурыОбъект = ВидНоменклатурыСсылка.ПолучитьОбъект();
	
	ЗаблокироватьДанныеДляРедактирования(ВидНоменклатурыОбъект.Ссылка);
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		ВидНоменклатурыОбъект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;
	
	ВидНоменклатурыОбъект.Записать();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьНоменклатуру.
Процедура ЗаполнитьНоменклатуру(НоменклатураСсылка, ТаблицаИзменений) Экспорт
	
	Если ТаблицаИзменений.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	НоменклатураОбъект = НоменклатураСсылка.ПолучитьОбъект();
	
	ЗаблокироватьДанныеДляРедактирования(НоменклатураОбъект.Ссылка);
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		НоменклатураОбъект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;
	
	НоменклатураОбъект.Записать();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьДополнительныеРеквизитыНоменклатуры.
Процедура ЗаполнитьДополнительныеРеквизитыНоменклатуры(НоменклатураСсылка, ДополнительныеРеквизиты) Экспорт
	
	Если ДополнительныеРеквизиты.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	ЗначенияДополнительныхРеквизитов = Новый ТаблицаЗначений;
	
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Свойство");
	ЗначенияДополнительныхРеквизитов.Колонки.Добавить("Значение");
	
	Для каждого Реквизит Из ДополнительныеРеквизиты Цикл
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = Реквизит.РеквизитОбъекта;
		НоваяСтрока.Значение = Реквизит.НовоеЗначение;
		
	КонецЦикла;
	
	УправлениеСвойствами.ЗаписатьСвойстваУОбъекта(НоменклатураСсылка, ЗначенияДополнительныхРеквизитов);
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ПолучитьЗначенияДополнительныхРеквизитов.
Процедура ПолучитьЗначенияДополнительныхРеквизитов(Номенклатура, ЗначенияРеквизитов) Экспорт
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	НоменклатураДополнительныеРеквизиты.Ссылка КАК ВладелецСвойств,
	|	НоменклатураДополнительныеРеквизиты.Свойство КАК Свойство,
	|	НоменклатураДополнительныеРеквизиты.Значение КАК Значение
	|ИЗ
	|	Справочник.Номенклатура.ДополнительныеРеквизиты КАК НоменклатураДополнительныеРеквизиты
	|ГДЕ
	|	НоменклатураДополнительныеРеквизиты.Ссылка В(&Номенклатура)";
	
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	ЗначенияРеквизитов = Запрос.Выполнить().Выгрузить();
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьНоменклатуруВФорме.
Процедура ЗаполнитьНоменклатуруВФорме(Форма, ТаблицаИзменений) Экспорт
		
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		Форма.Объект[ЭлементКоллекции.РеквизитОбъекта] = ЭлементКоллекции.НовоеЗначение;
	КонецЦикла;	
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьДополнительныеРеквизитыНоменклатурыВФорме.
Процедура ЗаполнитьДополнительныеРеквизитыНоменклатурыВФорме(Форма, ТаблицаИзменений) Экспорт
	
	Объект = Форма.Объект;
	
	Для каждого ЭлементКоллекции Из ТаблицаИзменений Цикл
		
		СтрокиРеквизита = Объект.ДополнительныеРеквизиты.
			НайтиСтроки(Новый Структура("Свойство", ЭлементКоллекции.РеквизитОбъекта));
		
		Если СтрокиРеквизита.Количество() = 0 Тогда
			НоваяСтрока = Объект.ДополнительныеРеквизиты.Добавить();
			НоваяСтрока.Свойство = ЭлементКоллекции.РеквизитОбъекта;
			НоваяСтрока.Значение = ЭлементКоллекции.НовоеЗначение;	
		Иначе
			СтрокиРеквизита[0].Значение = ЭлементКоллекции.НовоеЗначение; 
		КонецЕсли;
		
	КонецЦикла;	

	УправлениеСвойствами.ЗаполнитьДополнительныеРеквизитыВФорме(Форма, Объект);
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.СформироватьНаименованиеПоХарактеристике.
Процедура СформироватьНаименованиеПоХарактеристике(НаименованиеНоменклатуры, ПредставлениеХарактеристики, НаименованиеХарактеристики) Экспорт
	
	НаименованиеХарактеристики = СтрШаблон("%1 ,%2", НаименованиеНоменклатуры, ПредставлениеХарактеристики);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Прикрепление изображений к номенклатуре по массиву адресов.
//
// Параметры:
//  НоменклатураСсылка	 - Ссылка - владелец изображений.
//  СсылкиНаИзображения	 - Массив (Строка) - ссылки на изображения.
//
Процедура ПрикрепитьИзображения(НоменклатураСсылка, СсылкиНаИзображения)
	
	СозданныеИзображения = Новый Массив;
	
	Для каждого ИзображениеURL Из СсылкиНаИзображения Цикл
		
		ДанныеИзображения = ДвоичныеДанныеПоАдресуURL(ИзображениеURL);
		
		ИмяИзображения = "";
		РасширениеИзображения = "";
		
		ПодстрокиАдреса = СтрРазделить(ИзображениеURL, "/");		
		
		Если ПодстрокиАдреса.Количество() > 0  Тогда
			ИмяИзображения = ПодстрокиАдреса[ПодстрокиАдреса.ВГраница()];
			
			ПодстрокиИмени = СтрРазделить(ИмяИзображения, ".");
			
			Если ПодстрокиИмени.Количество() = 2 Тогда
				ИмяИзображения = ПодстрокиИмени[0];	
				РасширениеИзображения = ПодстрокиИмени[1];	
			КонецЕсли;	
		КонецЕсли;
				
		ПараметрыФайла = Новый Структура();
		ПараметрыФайла.Вставить("Автор", Пользователи.АвторизованныйПользователь());
		ПараметрыФайла.Вставить("ВладелецФайлов", НоменклатураСсылка);
		ПараметрыФайла.Вставить("ИмяБезРасширения", ИмяИзображения);
		ПараметрыФайла.Вставить("РасширениеБезТочки", РасширениеИзображения);
		ПараметрыФайла.Вставить("ВремяИзмененияУниверсальное");
		
		СозданныеИзображения.Добавить(
			РаботаСФайлами.ДобавитьФайл(ПараметрыФайла, ПоместитьВоВременноеХранилище(ДанныеИзображения)));
		
	КонецЦикла;
	
	Если СозданныеИзображения.Количество() > 0 Тогда
		НоменклатураОбъект = НоменклатураСсылка.ПолучитьОбъект();
		НоменклатураОбъект.ФайлКартинки = СозданныеИзображения[0];
		НоменклатураОбъект.ОбменДанными.Загрузка = Истина;
		НоменклатураОбъект.Записать();		
	КонецЕсли;
	
КонецПроцедуры

// Получение значения ставки НДС по идентификатору.
//
// Параметры:
//  Значение - Строка - значение ставки НДС (-, 10, 18).
//  Ссылка	 - СправочникСсылка, ПеречислениеСсылка - ссылка на значение ставки НДС прикладного решения.
//
Процедура ПреобразоватьСтавкуНДССервиса(Знач Значение, Ссылка)
	
	Если Значение = "10" Тогда
		Ссылка = Перечисления.СтавкиНДС.НДС10;
	ИначеЕсли Значение = "18" Тогда
		Ссылка = Перечисления.СтавкиНДС.НДС18;
	Иначе
		Ссылка = Перечисления.СтавкиНДС.БезНДС;
	КонецЕсли;
	
КонецПроцедуры

// Преобразование типа объекта сервиса в объект прикладного решения.
//
// Параметры:
//  Значение	 - Строка - тип объекта сервиса.
//  Результат	 - Произвольный - преобразованный тип.
//
Процедура ПреобразоватьТипНоменклатурыСервиса(Знач Значение, Результат)

	Если Значение = "Услуга" Тогда 
		Результат = Перечисления.ТипыНоменклатуры.Услуга;
	ИначеЕсли Значение = "Товар" Тогда 
		Результат = Перечисления.ТипыНоменклатуры.Товар;
	Иначе 
		Результат = Перечисления.ТипыНоменклатуры.ПустаяСсылка();	
	КонецЕсли;
	
КонецПроцедуры

// Поиск и создание единицы измерения, на основании данных сервиса
//
// Параметры:
//  ЕдиницаИзмеренияСервиса	 - Структура - см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса, колонка ЕдиницаИзмерения.
//  ЕдиницуИзмеренияСсылка	 - Справочник.Ссылка - ссылка на созданную единицу измерения.
//
Процедура ЕдиницаИзмеренияПоДаннымСервиса(ЕдиницаИзмеренияСервиса, ЕдиницуИзмеренияСсылка) 
	
	// Поиск элемента в базе
	
	ЕдиницаИзмеренияВБазе(ЕдиницаИзмеренияСервиса, ЕдиницуИзмеренияСсылка);
	
	Если ЕдиницуИзмеренияСсылка <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	// Создание элемента если не найдено
	
	ЕдиницуИзмеренияСсылка = Справочники.ЕдиницыИзмерения.СоздатьЭлемент();
	
	ЕдиницуИзмеренияСсылка.Наименование = СокрЛП(ЕдиницаИзмеренияСервиса.Наименование);
	
	ЕдиницуИзмеренияСсылка.Записать();
	
КонецПроцедуры

// Поиск единицы измерения в информационной базе, на основании данных сервиса
//
// Параметры:
//  ЕдиницаИзмеренияСервиса	 - Структура - см. РаботаСНоменклатурой.ДанныеНоменклатурыСервиса, колонка ЕдиницаИзмерения.
//  ЕдиницуИзмеренияСсылка	 - Справочник.Ссылка - ссылка на созданную единицу измерения.
//
Процедура ЕдиницаИзмеренияВБазе(ЕдиницаИзмеренияСервиса, ЕдиницуИзмеренияСсылка)
	
	// Поиск по коду
	
	КодОКЕИ = "";
	СсылкаНаЕдиницуИзмерения = Неопределено;
	
	Если ЕдиницаИзмеренияСервиса.Свойство("ОКЕИ", КодОКЕИ) Тогда
		СсылкаНаЕдиницуИзмерения = Справочники.ЕдиницыИзмерения.ЕдиницаИзмеренияПоКоду(КодОКЕИ);
	КонецЕсли;
	
	Если СсылкаНаЕдиницуИзмерения <> Неопределено Тогда
		ЕдиницуИзмеренияСсылка = СсылкаНаЕдиницуИзмерения;
		Возврат ;
	КонецЕсли;
	
	// Поиск по наименованию
	
	НаименованиеЕдиницыИзмерения = СокрЛП(ЕдиницаИзмеренияСервиса.Наименование);
	
	Если НЕ ЗначениеЗаполнено(НаименованиеЕдиницыИзмерения) Тогда
		Возврат;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	
	Запрос.Текст = 
	
	"ВЫБРАТЬ
	|	ЕдиницыИзмерения.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ЕдиницыИзмерения КАК ЕдиницыИзмерения
	|ГДЕ
	|	ЕдиницыИзмерения.Наименование = &Наименование
	|	И ЕдиницыИзмерения.Код = """"";
	
	Запрос.УстановитьПараметр("Наименование", НаименованиеЕдиницыИзмерения);
	
	Выгрузка = Запрос.Выполнить().Выгрузить();
	
	Если Выгрузка.Количество() > 0 Тогда
		ЕдиницуИзмеренияСсылка = Выгрузка[0].Ссылка;
	КонецЕсли;
	
КонецПроцедуры

// См. РаботаСНоменклатуройПереопределяемый.ЗаполнитьЗначенияРеквизитовХарактеристики.
Процедура ЗаполнитьЗначенияРеквизитовХарактеристики(ЗначенияДополнительныхРеквизитов, Характеристика)
	
	ЗначенияДополнительныхРеквизитов.Очистить();
	
	Для каждого Свойство Из Характеристика.ДополнительныеРеквизиты Цикл
		
		Если Не ЗначениеЗаполнено(Свойство.РеквизитИнформационнойБазы) Тогда
			Продолжить;
		КонецЕсли;
		
		НоваяСтрока = ЗначенияДополнительныхРеквизитов.Добавить();
		
		НоваяСтрока.Свойство = Свойство.РеквизитИнформационнойБазы;
		НоваяСтрока.Значение = РаботаСНоменклатурой.ЗначениеДополнительногоРеквизита(Свойство);
		
	КонецЦикла;
	
КонецПроцедуры

// Получение двоичных данных по адресу URL, например изображения.
//
// Параметры:
//  АдресURL - Строка - адрес хранения данных.
// 
// Возвращаемое значение:
//  ДвоичныеДанные - полученные данные.
//
Функция ДвоичныеДанныеПоАдресуURL(АдресURL)
	
	СтруктураURI = ОбщегоНазначенияКлиентСервер.СтруктураURI(АдресURL);
	
	ПараметрыСоединения = Новый Структура("Протокол, ИмяСервера, АдресРесурса, Порт, Таймаут, ЗащищенноеСоединение, Прокси");
	ПараметрыСоединения.Протокол     = СтруктураURI.Схема;
	ПараметрыСоединения.ИмяСервера   = СтруктураURI.Хост;
	ПараметрыСоединения.АдресРесурса = СтруктураURI.ПутьНаСервере;
	ПараметрыСоединения.Порт         = СтруктураURI.Порт;
	ПараметрыСоединения.Таймаут      = 30;
	ПараметрыСоединения.ЗащищенноеСоединение = ПараметрыСоединения.Протокол = "https";
	ПараметрыСоединения.Прокси = ПолучениеФайловИзИнтернетаКлиентСервер.ПолучитьПрокси(ПараметрыСоединения.Протокол);
	
	ЗащищенноеСоединение = Неопределено;
	Если ПараметрыСоединения.ЗащищенноеСоединение Тогда
		СертификатыУдостоверяющихЦентров = Неопределено;
		Если Не ОбщегоНазначения.ЭтоLinuxСервер() И Не ОбщегоНазначения.РазделениеВключено() Тогда
			// Ошибка фреша при работе с веб сервисами. Не работает проверка доверенных сертификатов при установке соединения.
			СертификатыУдостоверяющихЦентров = Новый СертификатыУдостоверяющихЦентровWindows;
		КонецЕсли;
		ЗащищенноеСоединение = ОбщегоНазначенияКлиентСервер.НовоеЗащищенноеСоединение(, СертификатыУдостоверяющихЦентров);
	КонецЕсли;
	
	Попытка
		Соединение = Новый HTTPСоединение(ПараметрыСоединения.ИмяСервера,
			ПараметрыСоединения.Порт,,,,ПараметрыСоединения.Таймаут, ЗащищенноеСоединение);
	Исключение
		ВызватьИсключение НСтр("ru = 'Ошибка установки соединения при получении изображения'");
	КонецПопытки;
	
	HTTPЗапрос = Новый HTTPЗапрос(ПараметрыСоединения.АдресРесурса);
	
	Попытка
		HTTPОтвет = Соединение.Получить(HTTPЗапрос);
	Исключение
		ВызватьИсключение НСтр("ru = 'Ошибка получения изображения'");
	КонецПопытки;
	
	Возврат HTTPОтвет.ПолучитьТелоКакДвоичныеДанные();
	
КонецФункции

#КонецОбласти
