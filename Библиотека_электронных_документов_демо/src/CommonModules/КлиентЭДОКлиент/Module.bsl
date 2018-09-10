#Область ПрограммныйИнтерфейс

// См. процедуру ОбщегоНазначенияКлиентПереопределяемый.ПриНачалеРаботыСистемы().
//
Процедура ПриНачалеРаботыСистемы(Параметры) Экспорт
	
	ПараметрыРаботыКлиента = СтандартныеПодсистемыКлиент.ПараметрыРаботыКлиентаПриЗапуске();
	Если ПараметрыРаботыКлиента.ДоступноИспользованиеРазделенныхДанных
		И ПараметрыРаботыКлиента.ПоказатьНачалоРаботы Тогда
		Параметры.Вставить("ИнтерактивнаяОбработка",
			Новый ОписаниеОповещения("ИнтерактивнаяОбработкаЗапросЛицензионногоСоглашения", ЭтотОбъект));
	КонецЕсли;
	
КонецПроцедуры

// Возвращает фильтр, используемый для выбора файлов-изображений.
//
// Возвращаемое значение:
//  Строка - строка, содержащая фильтр для файлов-изображений.
//
Функция ФильтрФайловИзображений() Экспорт
	Возврат НСтр("ru = 'Все картинки (*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf)|*.bmp;*.gif;*.png;*.jpeg;*.dib;*.rle;*.tif;*.jpg;*.ico;*.wmf;*.emf"
		                            + "|Все файлы(*.*)|*.*"
		                            + "|Формат bmp(*.bmp*;*.dib;*.rle)|*.bmp;*.dib;*.rle"
		                            + "|Формат GIF(*.gif*)|*.gif"
		                            + "|Формат JPEG(*.jpeg;*.jpg)|*.jpeg;*.jpg"
		                            + "|Формат PNG(*.png*)|*.png"
		                            + "|Формат TIFF(*.tif)|*.tif"
		                            + "|Формат icon(*.ico)|*.ico"
		                            + "|Формат метафайл(*.wmf;*.emf)|*.wmf;*.emf'");
КонецФункции

// Записывает сопоставление номенклатуры поставщика в информационную базу.
//
// Параметры:
//  СтрокаТабличнойЧасти - ДанныеФормыЭлементКоллекции - Строка таблицы, в которой выполняется сопоставление.
//  Номенклатура		 - СправочникСсылка.Номенклатура - Сопоставляемая номенклатура.
//
Процедура СопоставитьНоменклатуруПоставщика(СтрокаТабличнойЧасти, Номенклатура) Экспорт
	
	Если СтрокаТабличнойЧасти <> Неопределено 
		И НЕ ЗначениеЗаполнено(СтрокаТабличнойЧасти.НоменклатураПоставщика) Тогда
		Возврат;
	КонецЕсли;
	
	ЗначенияРеквизитов = Новый Структура;
	ЗначенияРеквизитов.Вставить("Номенклатура", Номенклатура);
	
	Результат = КлиентЭДОВызовСервера.ЗаписатьСопоставлениеНоменклатурыПоставщика(
		СтрокаТабличнойЧасти.НоменклатураПоставщика, ЗначенияРеквизитов);
	
	Если НЕ Результат Тогда
		ТекстВопроса = НСтр("ru='Номенклатура поставщика уже сопоставлена. Изменить сопоставление?'");
		ПараметрыОповещения = Новый Структура;
		ПараметрыОповещения.Вставить("СтрокаТабличнойЧасти", СтрокаТабличнойЧасти);
		ПараметрыОповещения.Вставить("ЗначенияРеквизитов", ЗначенияРеквизитов);
		ОписаниеОповещения = Новый ОписаниеОповещения("СопоставитьНоменклатуруПоставщикаПослеВопроса",
			ЭтотОбъект, ПараметрыОповещения);
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
	
КонецПроцедуры

// Показывает диалог с вопросом о разрешении редактирования реквизитов объекта.
//
// Параметры:
//  Оповещение  - ОписаниеОповещения - Описание процедуры, принимающей результат выбора.
//  Ссылка - ДокументСсылка - Документ, о котором должен быть задан вопрос.
//
Процедура ПоказатьВопросОРазрешенииРедактированияРеквизитовОбъекта(Оповещение, Ссылка) Экспорт
	
	ТекстВопроса = СтрШаблон(НСтр("ru = '%1 был создан по электронному документу.
		|Не рекомендуется разрешать редактирование из-за риска рассогласования данных.'"), Ссылка);
		
	ЗаголовокДиалога = НСтр("ru = 'Разрешение редактирования реквизитов'");
	Кнопки = Новый СписокЗначений;
	Кнопки.Добавить(КодВозвратаДиалога.Да, НСтр("ru = 'Разрешить редактирование'"));
	Кнопки.Добавить(КодВозвратаДиалога.Нет, НСтр("ru = 'Отмена'"));
	ПоказатьВопрос(Оповещение, ТекстВопроса, Кнопки,, КодВозвратаДиалога.Нет, ЗаголовокДиалога);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Асинхронная процедура.
Процедура ИнтерактивнаяОбработкаЗапросЛицензионногоСоглашения(Параметры, Контекст) Экспорт
	
	ОткрытьФорму("Обработка.НачалоРаботыКЭДО.Форма.ЛицензионноеСоглашение", , , , , ,
		Новый ОписаниеОповещения("ПослеЗакрытияФормыЗапросаЛицензионногоСоглашения", ЭтотОбъект, Параметры));
	
КонецПроцедуры

// Асинхронная процедура.
Процедура ПослеЗакрытияФормыЗапросаЛицензионногоСоглашения(Результат, Параметры) Экспорт
	
	Если Результат <> Истина Тогда
		Параметры.Отказ = Истина;
	КонецЕсли;
	
	ВыполнитьОбработкуОповещения(Параметры.ОбработкаПродолжения);
	
КонецПроцедуры

// Асинхронная процедура.
Процедура СопоставитьНоменклатуруПоставщикаПослеВопроса(Результат, Параметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		Возврат;
	КонецЕсли;
	
	КлиентЭДОВызовСервера.ЗаписатьСопоставлениеНоменклатурыПоставщика(
		Параметры.СтрокаТабличнойЧасти.НоменклатураПоставщика, Параметры.ЗначенияРеквизитов, Истина);
	
КонецПроцедуры

#КонецОбласти
