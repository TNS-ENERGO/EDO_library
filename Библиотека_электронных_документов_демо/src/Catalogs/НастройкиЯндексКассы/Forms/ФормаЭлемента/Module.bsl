#Область ОписаниеПеременных

&НаКлиенте
Перем ХронологияПереключенияСтраниц;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;

	ОбновлениеИнформационнойБазы.ПроверитьОбъектОбработан(Объект, ЭтотОбъект);
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		РежимСоздания = Истина;
		ПриЧтенииСозданииНаСервере(Объект);
	КонецЕсли;
	
	СоздатьПереопределяемуюСтраницу();
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ХронологияПереключенияСтраниц = Новый Массив;
	
	ИзменитьЗаголовок();
	ОтобразитьПризнакНедействительна();
	
	Если НеПоказыватьСтраницуКарточкаНастроекПриОткрытии Тогда 
		СменитьСтраницуШаги(Элементы.СтраницаПреимущества);
	Иначе
		СменитьСтраницуШаги(Элементы.СтраницаКарточкаНастройки);
	КонецЕсли;
	СменитьСтраницуКомандНавигации(Элементы.ДалееОтмена)
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "Запись_УчетнаяЗаписьЭлектроннойПочты" 
		И Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаШаблоныСообщений Тогда 
		
		ПроверитьНастроенныеУчетныеЗаписиЭлектроннойПочтыИОбработатьВидимостьПредупреждения();
		
	ИначеЕсли ИмяСобытия = "Запись_НастройкиЯндексКассы"
		И Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаВариантыИВыборОрганизации Тогда 
		
		Если РежимСоздания Тогда 
			ТекущаяОрганизация = Неопределено;
		Иначе
			ТекущаяОрганизация = Объект.Организация;
		КонецЕсли;
		
		СписокВыбора = Новый СписокЗначений;
		УстановитьСписокНеПодключенныхОрганизаций(СписокВыбора, ТекущаяОрганизация);
		
		Элементы.Организация.СписокВыбора.ЗагрузитьЗначения(СписокВыбора.ВыгрузитьЗначения());
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ПриЧтенииСозданииНаСервере(ТекущийОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если Модифицированность Тогда
		
		СтандартнаяОбработка = Ложь;
		Отказ = Истина;
		
		ТекстПредупреждения = НСтр("ru = 'Работа помощника подключения к сервису Яндекс.Касса не была завершена.'");
		
		Если Не ЗавершениеРаботы Тогда
			
			Кнопки = Новый СписокЗначений;
			Кнопки.Добавить("Завершить", НСтр("ru = 'Завершить настройку'"));
			Кнопки.Добавить("Продолжить", НСтр("ru = 'Продолжить настройку'"));
			ОбработкаОтвета = Новый ОписаниеОповещения("ОбработкаОтветаПередЗакрытием", ЭтотОбъект);
			ПоказатьВопрос(ОбработкаОтвета, ТекстПредупреждения, Кнопки, , "Завершить");
			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовФормы

#Область СтраницаВариантыИВыборОрганизации

&НаКлиенте
Процедура ВариантПриИзменении(Элемент)
	
	ОтобразитьПодсказку(ЭтотОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура ОрганизацияПриИзменении(Элемент)
	
	ИзменитьЗаголовок();
	
КонецПроцедуры

#КонецОбласти

#Область СтраницаШаблоныСообщений

&НаКлиенте
Процедура СоздатьШаблоныАвтоматическиПриИзменении(Элемент)
	
	ПроверитьНастроенныеУчетныеЗаписиЭлектроннойПочтыИОбработатьВидимостьПредупреждения();
	
КонецПроцедуры

#КонецОбласти

#Область СтраницаФинал

&НаКлиенте
Процедура ОткрытьФормуСпискаШаблоныСообщенийНажатие(Элемент)
	
	Если Не ОбщегоНазначенияКлиент.ПодсистемаСуществует("СтандартныеПодсистемы.ШаблоныСообщений") Тогда
		Возврат;
	КонецЕсли;
	
	Отбор = Новый Структура();
	Отбор.Вставить("Ссылка", СозданныеШаблоныСообщений);
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("Отбор", Отбор);
	
	ИмяФормыСпискаШаблонов = "Справочник.ШаблоныСообщений.ФормаСписка";
	ОткрытьФорму(ИмяФормыСпискаШаблонов, ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти

#Область СтраницаПараметрыПодключенияКСервису

&НаКлиенте
Процедура ОтправкаЧековЧерезЯндексПриИзменении(Элемент)
	
	ОтправкаЧековЧерезЯндекс = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтправкаЧековСамостоятельноПриИзменении(Элемент)
	
	ОтправкаЧековЧерезЯндекс = Ложь;
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область ОбработчикиКомандФормы

#Область СтраницаШаблоныСообщений

&НаКлиенте
Процедура СоздатьУчетнуюЗаписьЭлектроннойПочты(Команда)
	
	ОповещениеОЗакрытииПомощника = Новый ОписаниеОповещения(
		"ПослеЗакрытияФормыПомощникаСозданияУчетнойЗаписиЭлектроннойПочты", ЭтотОбъект);
	ОткрытьФорму("Справочник.УчетныеЗаписиЭлектроннойПочты.ФормаОбъекта",,ЭтотОбъект,,,,ОповещениеОЗакрытииПомощника);
	
КонецПроцедуры

#КонецОбласти

#Область КомандыНавигации

&НаКлиенте
Процедура Готово(Команда)
	
	Закрыть();
	
КонецПроцедуры

&НаКлиенте
Процедура Далее(Команда)
	
	ОчиститьСообщения();
	
	Если Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаПреимущества Тогда
		
		ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаПреимущества);
		СменитьСтраницуШаги(Элементы.СтраницаВариантыИВыборОрганизации);
		
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаКарточкаНастройки Тогда
		
		Если ХронологияПереключенияСтраниц.Количество() Тогда 
			Если СДоговором Тогда 
				СменитьСтраницуШаги(Элементы.СтраницаФинал);
				СменитьСтраницуКомандНавигации(Элементы.Готово);
			Иначе 
				ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаКарточкаНастройки);
				СменитьСтраницуШаги(Элементы.СтраницаПолученияНастроек);
				СменитьСтраницуКомандНавигации(Элементы.НазадОтмена);
				ПолучитьНастройкиИзСервиса();
			КонецЕсли;
			СменитьВидимостьПодменюЕще(ЭтотОбъект, Ложь);
		Иначе
			ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаКарточкаНастройки);
			СменитьСтраницуШаги(Элементы.СтраницаВариантыИВыборОрганизации);
		КонецЕсли;
		
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаВариантыИВыборОрганизации Тогда
		
		Отказ = Ложь;
		ПроверкаЗаполненияСтраницаВариантыИВыборОрганизации(Отказ);
		
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
		
		ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаВариантыИВыборОрганизации);
		
		Если СДоговором Тогда
			СменитьСтраницуШаги(Элементы.СтраницаПараметрыПодключенияКСервису);
		ИначеЕсли ОткрыватьСтраницуПереопределяемая Тогда
			СменитьСтраницуШаги(Элементы.СтраницаПереопределяемая);
		ИначеЕсли ОткрыватьСтраницуШаблоныСообщений Тогда
			СменитьСтраницуШаги(Элементы.СтраницаШаблоныСообщений);
		Иначе
			СменитьСтраницуШаги(Элементы.СтраницаКарточкаНастройки);
			СменитьСтраницуКомандНавигации(Элементы.НазадСохранитьОтмена);
		КонецЕсли;
			
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаПараметрыПодключенияКСервису Тогда
		
		Отказ = Ложь;
		ПроверкаЗаполненияСтраницаПараметрыПодключенияКСервису(Отказ);
		
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
		
		ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаПараметрыПодключенияКСервису);
		
		Если ОткрыватьСтраницуПереопределяемая Тогда
			СменитьСтраницуШаги(Элементы.СтраницаПереопределяемая);
		ИначеЕсли ОткрыватьСтраницуШаблоныСообщений Тогда
			СменитьСтраницуШаги(Элементы.СтраницаШаблоныСообщений);
		Иначе
			СменитьСтраницуШаги(Элементы.СтраницаКарточкаНастройки);
			СменитьСтраницуКомандНавигации(Элементы.НазадСохранитьОтмена);
		КонецЕсли;
		
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаПереопределяемая Тогда
		
		Если Не ПропуститьСтраницуПереопределяемая Тогда
			Отказ = Ложь;
			ПриЗакрытииСтраницыПереопределяемая(Отказ);
			Если Отказ Тогда
				Возврат;
			КонецЕсли;
			ЗаполнитьТаблицуДополнительныхНастроек();
			ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаПереопределяемая);
		КонецЕсли;
		
		Если ОткрыватьСтраницуШаблоныСообщений Тогда
			СменитьСтраницуШаги(Элементы.СтраницаШаблоныСообщений);
		Иначе
			СменитьСтраницуШаги(Элементы.СтраницаКарточкаНастройки);
			СменитьСтраницуКомандНавигации(Элементы.НазадСохранитьОтмена);
		КонецЕсли;
		
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаШаблоныСообщений Тогда
		
		ХронологияПереключенияСтраниц.Добавить(Элементы.СтраницаШаблоныСообщений);
		СменитьСтраницуШаги(Элементы.СтраницаКарточкаНастройки);
		СменитьСтраницуКомандНавигации(Элементы.НазадСохранитьОтмена);
		
	ИначеЕсли Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаПолученияНастроек Тогда
		
		СменитьСтраницуШаги(Элементы.СтраницаФинал);
		СменитьСтраницуКомандНавигации(Элементы.Готово);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Назад(Команда)

	ОтменитьАктивныеФоновыеОперации();
	ВернутьсяНаПредыдущуюСтраницу();

КонецПроцедуры

&НаКлиенте
Процедура Отмена(Команда)
	
	ОтменитьАктивныеФоновыеОперации();
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область КомандыЕще

&НаКлиенте
Процедура НастройкаНедействительна(Команда)
	
	Недействительна = Не Недействительна;
	
	ОтобразитьПризнакНедействительна();
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьДополнительныеНастройки(Команда)
	
	ПараметрыФормы = Новый Структура;
	ПараметрыФормы.Вставить("НастройкаЯндексКассы", Объект.Ссылка);
	ОткрытьФорму("РегистрСведений.СтатусОбменовСЯндексКассой.ФормаЗаписи", 
		ПараметрыФормы, 
		ЭтотОбъект,
		УникальныйИдентификатор); 
		
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Прочее

&НаСервере
Процедура ПриЧтенииСозданииНаСервере(ОбъектДанных)
	
	ПрочитатьРеквизитыДополнительныхНастроек();
	ЗаполнитьПараметрыФормы(ОбъектДанных);
	УстановитьВидимостьДоступностьЭлементовФормы();
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьПараметрыФормы(ОбъектДанных)
	
	Если РежимСоздания Тогда // новый
		
		Если ЗначениеЗаполнено(Параметры.Организация) Тогда
			Организация = Параметры.Организация;
		ИначеЕсли Параметры.Свойство("ЗначенияЗаполнения") И Параметры.ЗначенияЗаполнения.Свойство("Организация")
			И ЗначениеЗаполнено(Параметры.ЗначенияЗаполнения.Организация) Тогда
			Организация = Параметры.ЗначенияЗаполнения.Организация;
		КонецЕсли;
		
		НеПоказыватьСтраницуКарточкаНастроекПриОткрытии = Истина;
		
	Иначе  // редактирование
		
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ОбъектДанных);
		
	КонецЕсли;
	
	ИспользоватьНесколькоОрганизаций = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийЭД");
	
	Если Не ИспользоватьНесколькоОрганизаций И Не ЗначениеЗаполнено(Организация) Тогда 
		Организация = ЭлектронноеВзаимодействиеСлужебный.ОрганизацияПоУмолчанию();
	КонецЕсли;
	
	ОтображатьОрганизацию = ИспользоватьНесколькоОрганизаций;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаВыборОрганизации",
		"Видимость",
		ОтображатьОрганизацию);
		
	Элементы.Варианты.Заголовок = ?(ОтображатьОрганизацию,
		НСтр("ru = 'Выберите вариант использования сервиса и организацию'"),
		НСтр("ru = 'Выберите вариант использования сервиса'"));
	
	Если ОтображатьОрганизацию Тогда 
		УстановитьСписокНеПодключенныхОрганизаций(Элементы.Организация.СписокВыбора, Организация);
		Элементы.Организация.РежимВыбораИзСписка = ЗначениеЗаполнено(Элементы.Организация.СписокВыбора);
	КонецЕсли;
	
	ОтправкаЧековЧерезЯндекс = Объект.ОтправкаЧековЧерезЯндекс;
	
	ОткрыватьСтраницуШаблоныСообщений = ИспользоватьШаблоныСообщений();
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступностьЭлементовФормы()
	
	ОтобразитьПодсказку(ЭтотОбъект);
	СменитьВидимостьПодменюЕще(ЭтотОбъект, Не РежимСоздания);
	Элементы.КомандыНавигации.ОтображениеСтраниц = ОтображениеСтраницФормы.Нет;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОтветаПередЗакрытием(Ответ, ПараметрыВопроса) Экспорт
	
	Если Ответ = "Завершить" Тогда // завершить настройку
		
		Модифицированность = Ложь;
		Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Шапка

&НаКлиенте
Процедура ИзменитьЗаголовок()
	
	Если ЗначениеЗаполнено(Организация) Тогда 
		Шаблон = НСтр("ru = 'Настройка подключения %1 к сервису'");
		Элементы.Заголовок.Заголовок = Новый ФорматированнаяСтрока(СтрШаблон(Шаблон, Организация));
	Иначе
		Элементы.Заголовок.Заголовок = Новый ФорматированнаяСтрока(НСтр("ru = 'Настройка подключения к сервису'"));
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ОтобразитьПризнакНедействительна()
	
	Если Недействительна Тогда
		МассивПодстрок = Новый Массив;
		МассивПодстрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = '(Недействующая)'") + " ", Новый Шрифт(,,,Истина)));
		МассивПодстрок.Добавить(Элементы.Заголовок.Заголовок);
		Элементы.Заголовок.Заголовок = Новый ФорматированнаяСтрока(МассивПодстрок);
	Иначе 
		ИзменитьЗаголовок();
	КонецЕсли; 
					
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"КомандаНастройкаНедействительна",
		"Пометка",
		Недействительна);
		
	Если Элементы.Шаги.ТекущаяСтраница = Элементы.СтраницаКарточкаНастройки
		И ХронологияПереключенияСтраниц.Количество() Тогда 
		ПриОткрытииСтраницыКарточкаНастройки(Истина);
	КонецЕсли;
		
КонецПроцедуры

#КонецОбласти

#Область СтраницаКарточкаНастройки

&НаСервере
Процедура ПриОткрытииСтраницыКарточкаНастройки(СтраницаСохранения)
	
	Если СтраницаСохранения Тогда 
		КарточкаНастройки = Справочники.НастройкиЯндексКассы.ПолучитьТабличныйДокументКарточкиНастройки(ЭтотОбъект, ТекущиеДополнительныеНастройки);
	Иначе
		КарточкаНастройки = Справочники.НастройкиЯндексКассы.ПолучитьТабличныйДокументКарточкиНастройки(Объект, Объект.ДополнительныеНастройки);
	КонецЕсли;	
	
	МассивСтрок = Новый Массив;
	
	МассивСтрок.Добавить(НСтр("ru = 'Для сохранения настройки нажмите Сохранить, для изменения нажмите Назад, а для закрытия нажмите Отмена'"));
	МассивСтрок.Добавить(Символы.ПС);
	МассивСтрок.Добавить(НСтр("ru = 'Нажатие кнопки Сохранить означает согласие с'") + Символы.НПП);
	МассивСтрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Условиями использования сервиса'"),,,,"https://kassa-yandex.1c.ru/agreement"));
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, 
		"ПодсказкаЧтоДелатьНадпись",
		"Заголовок",
		?(СтраницаСохранения, 
			Новый ФорматированнаяСтрока(МассивСтрок),
			
			НСтр("ru = 'Для изменения настройки нажмите Далее, а для закрытия нажмите Отмена'")));
			
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы, 
		"ГруппаКарточкаНастройки",
		"Заголовок",
		?(СтраницаСохранения, 
			НСтр("ru = 'Сохранение настройки'"),
			НСтр("ru = 'Сводная информация'")));
			
	
КонецПроцедуры

#КонецОбласти

#Область СтраницаВариантыИВыборОрганизации

&НаКлиентеНаСервереБезКонтекста
Процедура ОтобразитьПодсказку(Форма)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы,
		"ГруппаПодсказки",
		"ТекущаяСтраница",
		?(Форма.СДоговором = 0, Форма.Элементы.ГруппаПодсказкиБезДоговора, Форма.Элементы.ГруппаПодсказкиСДоговора)); 
	
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверкаЗаполненияСтраницаВариантыИВыборОрганизации(Отказ)
	
	Если Не ЗначениеЗаполнено(Организация) Тогда
		
		Если ИспользоватьНесколькоОрганизаций Тогда
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Выберите организацию'"), , "Организация", , Отказ);
		Иначе 
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Настройте организацию и повторите попытку настройки'"),,,,Отказ);
		КонецЕсли;
		
	Иначе
		
		ПроверкаЗаполненияСтраницаВариантыИВыборОрганизацииНаСервере(Отказ);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПроверкаЗаполненияСтраницаВариантыИВыборОрганизацииНаСервере(Отказ)
	
	Если НЕ НастройкаПоОрганизацииУникальна() Тогда 
		ТекстСообщения = СтрШаблон(НСтр("ru = 'В информационной базе уже существует настройка для организации %1'"),
			Организация);
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "Организация", , Отказ);
	КонецЕсли;
	
	Если Не Отказ Тогда 
		// Проверка реквизитов организации
		ИнтеграцияСЯндексКассойСлужебный.ПроверитьОрганизациюНаСоответствиеТребованиямПриПодключенииКСервису(Организация,
			СДоговором, Отказ);
	КонецЕсли;	
	
КонецПроцедуры

&НаСервере
Функция НастройкаПоОрганизацииУникальна()
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТекущаяНастройка", Объект.Ссылка);
	Запрос.УстановитьПараметр("Организация", Организация);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	НастройкиЯндексКассы.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.НастройкиЯндексКассы КАК НастройкиЯндексКассы
	|ГДЕ
	|	НастройкиЯндексКассы.Организация = &Организация
	|	И НастройкиЯндексКассы.Ссылка <> &ТекущаяНастройка
	|	И НЕ НастройкиЯндексКассы.ПометкаУдаления
	|	И НЕ НастройкиЯндексКассы.Недействительна";
	Возврат Запрос.Выполнить().Пустой();
	
КонецФункции

&НаСервереБезКонтекста
Функция УстановитьСписокНеПодключенныхОрганизаций(СписокВыбора, ТекущаяОрганизация = Неопределено)
	
	СписокВыбора.Очистить();
	
	НазваниеСправочникаОрганизации =
		ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяПрикладногоСправочника("Организации");
	Если Не ЗначениеЗаполнено(НазваниеСправочникаОрганизации) Тогда
		НазваниеСправочникаОрганизации = "Организации";
	КонецЕсли;

	
	МенеджерОбъекта = ОбщегоНазначения.МенеджерОбъектаПоПолномуИмени(СтрШаблон("Справочник.%1",
		НазваниеСправочникаОрганизации));
		
	ПустаяСсылка = МенеджерОбъекта.ПустаяСсылка();
	Если ТекущаяОрганизация = Неопределено Тогда
		ТекущаяОрганизация = ПустаяСсылка;
	КонецЕсли;
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("ТекущаяОрганизация", ТекущаяОрганизация);
	Запрос.УстановитьПараметр("ПустаяСсылка", ПустаяСсылка);
	ТекстЗапроса =  
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	НастройкиЯндексКассы.Организация КАК Организация
	|ПОМЕСТИТЬ ПодключенныеОрганизации
	|ИЗ
	|	Справочник.НастройкиЯндексКассы КАК НастройкиЯндексКассы
	|ГДЕ
	|	НЕ НастройкиЯндексКассы.ПометкаУдаления
	|	И НЕ НастройкиЯндексКассы.Недействительна
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Ссылка КАК Организация,
	|	ПРЕДСТАВЛЕНИЕ(Организации.Ссылка) КАК Представление
	|ИЗ
	|	#СправочникОрганизации КАК Организации
	|ГДЕ
	|	НЕ Организации.Ссылка = &ТекущаяОрганизация
	|	И НЕ Организации.ПометкаУдаления
	|	И НЕ Организации.Ссылка В
	|				(ВЫБРАТЬ
	|					ПодключенныеОрганизации.Организация
	|				ИЗ
	|					ПодключенныеОрганизации)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	&ТекущаяОрганизация,
	|	ПРЕДСТАВЛЕНИЕ(&ТекущаяОрганизация)
	|ГДЕ
	|	НЕ &ТекущаяОрганизация = &ПустаяСсылка
	|
	|УПОРЯДОЧИТЬ ПО
	|	Организация";
	
	Запрос.Текст = СтрЗаменить(ТекстЗапроса, "#СправочникОрганизации", "Справочник." + НазваниеСправочникаОрганизации);
	
	Выборка = Запрос.Выполнить().Выбрать();
	Пока Выборка.Следующий() Цикл 
		СписокВыбора.Добавить(Выборка.Организация ,Выборка.Представление);
	КонецЦикла;
	
КонецФункции

#КонецОбласти

#Область СтраницаПараметрыПодключенияКСервису

&НаКлиенте
Процедура ПроверкаЗаполненияСтраницаПараметрыПодключенияКСервису(Отказ)
	
	Если Не ЗначениеЗаполнено(ИдентификаторМагазина) Тогда	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Укажите SHOP ID (идентификатор магазина)'"),
			, "ИдентификаторМагазина", , Отказ);
	ИначеЕсли Не НастройкаПоИдентификаторуМагазинаУникальна(Объект.Ссылка, ИдентификаторМагазина) Тогда 
		ТекстСообщения = НСтр("ru = 'В информационной базе уже существует настройка с таким идентификатором магазина'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения, , "ИдентификаторМагазина", , Отказ);
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ИдентификаторВитрины) Тогда	
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(НСтр("ru = 'Укажите SC ID (идентификатор витрины)'"),
			, "ИдентификаторВитрины", , Отказ);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НастройкаПоИдентификаторуМагазинаУникальна(НастройкаСсылка, ИдентификаторМагазина)
	
	Запрос = Новый Запрос;
	Запрос.УстановитьПараметр("НастройкаСсылка",       НастройкаСсылка);
	Запрос.УстановитьПараметр("ИдентификаторМагазина", ИдентификаторМагазина);
	Запрос.Текст = 
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ ПЕРВЫЕ 1
	|	НастройкиЯндексКассы.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.НастройкиЯндексКассы КАК НастройкиЯндексКассы
	|ГДЕ
	|	НастройкиЯндексКассы.Ссылка <> &НастройкаСсылка
	|	И НастройкиЯндексКассы.ИдентификаторМагазина = &ИдентификаторМагазина
	|	И НЕ НастройкиЯндексКассы.ПометкаУдаления
	|	И НастройкиЯндексКассы.СДоговором
	|	И НЕ НастройкиЯндексКассы.Недействительна";
	Возврат Запрос.Выполнить().Пустой();
	
КонецФункции

#КонецОбласти

#Область СтраницаПереопределяемая

&НаКлиентеНаСервереБезКонтекста
Функция КонтекстФормы(ЭтотОбъект) 
	
	Контекст = Новый Структура;
	Контекст.Вставить("Форма", ЭтотОбъект);
	Контекст.Вставить("Префикс", "_");
	Контекст.Вставить("НоваяНастройка", ЭтотОбъект.РежимСоздания);
	Контекст.Вставить("Организация", ЭтотОбъект.Организация);
	Контекст.Вставить("СДоговором", ЗначениеЗаполнено(ЭтотОбъект.СДоговором));
	
	Возврат Контекст;
	
КонецФункции

&НаСервере
Процедура ПриОткрытииСтраницыПереопределяемая(Отказ = Ложь)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойПереопределяемый.ПередНачаломРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗакрытииСтраницыПереопределяемая(Отказ = Ложь)
	
	Если ПропуститьСтраницуПереопределяемая Тогда
		Возврат;
	КонецЕсли;
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойПереопределяемый.ПередОкончаниемРедактированияДополнительныхНастроекЯндексКассы(Контекст, Отказ);
	
КонецПроцедуры

&НаСервере
Процедура СоздатьПереопределяемуюСтраницу()
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	РеквизитыДополнительныхНастроек = Новый Структура;
	
	ИнтеграцияСЯндексКассойПереопределяемый.ПриСозданииФормыНастроекЯндексКассы(
		ЭтотОбъект, Элементы.ГруппаПереопределяемая, Контекст.Префикс, РеквизитыДополнительныхНастроек);
		
	ПрочитатьРеквизитыДополнительныхНастроек();
	
	ОткрыватьСтраницуПереопределяемая = (Элементы.ГруппаПереопределяемая.ПодчиненныеЭлементы.Количество() > 0);
	
КонецПроцедуры

&НаСервере
Процедура ПрочитатьРеквизитыДополнительныхНастроек()
	
	Если РеквизитыДополнительныхНастроек = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Для каждого СтрокаНастроек Из Объект.ДополнительныеНастройки Цикл
		
		ИмяРеквизита = "";
		
		Если РеквизитыДополнительныхНастроек.Свойство(СтрокаНастроек.Настройка, ИмяРеквизита) Тогда
			
			ЭтотОбъект[ИмяРеквизита] = СтрокаНастроек.Значение;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуДополнительныхНастроек() 
	
	ТекущиеДополнительныеНастройки.Очистить();
	
	Для каждого КЗ Из РеквизитыДополнительныхНастроек Цикл
		
		НоваяСтрока = ТекущиеДополнительныеНастройки.Добавить();
		НоваяСтрока.Настройка = КЗ.Ключ;
		НоваяСтрока.Значение = ЭтотОбъект[КЗ.Значение];
		
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЭлементПриИзменении(Элемент)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.ЭлементФормыНастроекПриИзменении(Контекст, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЭлементНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.ЭлементФормыНастроекНачалоВыбора(Контекст, Элемент, ДанныеВыбора, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЭлементОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.ЭлементФормыНастроекОбработкаВыбора(Контекст, Элемент, ВыбранноеЗначение, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЭлементНажатие(Элемент)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.ЭлементФормыНастроекНажатие(Контекст, Элемент);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ЭлементСоздание(Элемент, СтандартнаяОбработка)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.ЭлементФормыНастроекСоздание(Контекст, Элемент, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура Подключаемый_ДействиеКоманды(Команда)
	
	Контекст = КонтекстФормы(ЭтотОбъект);
	
	ИнтеграцияСЯндексКассойКлиентПереопределяемый.КомандаФормыНастроекДействие(Контекст, Команда);
	
КонецПроцедуры

#КонецОбласти

#Область СтраницаШаблоныСообщений

&НаКлиенте
Процедура ПриОткрытииСтраницыШаблоныСообщений()
	
	ПроверитьНастроенныеУчетныеЗаписиЭлектроннойПочтыИОбработатьВидимостьПредупреждения();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьВидимостьПредупрежденияОНеобходимостиНастроитьЭлектроннуюПочту(Видимость)

	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаВниманиеНетУчетнойЗаписиЭлектроннойПочты",
		"Видимость",
		Видимость);
	
КонецПроцедуры	

&НаКлиенте
Процедура ПроверитьНастроенныеУчетныеЗаписиЭлектроннойПочтыИОбработатьВидимостьПредупреждения()
	
	Видимость = СоздатьШаблоныАвтоматически И НужноСоздатьУчетнуюЗаписьЭлектроннойПочты();
	ОбработатьВидимостьПредупрежденияОНеобходимостиНастроитьЭлектроннуюПочту(Видимость);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗакрытияФормыПомощникаСозданияУчетнойЗаписиЭлектроннойПочты(РезультатЗакрытия, ДополнительныеПараметры) Экспорт 
	
	ПроверитьНастроенныеУчетныеЗаписиЭлектроннойПочтыИОбработатьВидимостьПредупреждения();	
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция НужноСоздатьУчетнуюЗаписьЭлектроннойПочты()
	
	Возврат РаботаСПочтовымиСообщениями.ДоступнаОтправкаПисем()
		И РаботаСПочтовымиСообщениями.ДоступныеУчетныеЗаписи(Истина).Количество() = 0;
	
КонецФункции

&НаСервереБезКонтекста
Функция ИспользоватьШаблоныСообщений()
	
	ИспользоватьШаблоныСообщений = Ложь;
	ИнтеграцияСЯндексКассойПереопределяемый.ПроверитьИспользованиеШаблоновСообщений(ИспользоватьШаблоныСообщений);
	
	Если Не ИспользоватьШаблоныСообщений Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ШаблоныПисем = Новый Массив;
	ИнтеграцияСЯндексКассойПереопределяемый.ПредопределенныеШаблоныСообщений(ШаблоныПисем);
	
	Если Не ШаблоныПисем.Количество() Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	ЕстьФункционал = ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия")
		И ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.РаботаСПочтовымиСообщениями")
		И Не Метаданные.НайтиПоПолномуИмени("Справочник.ШаблоныСообщений") = Неопределено;
	
	Если Не ЕстьФункционал Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	СправочникШаблоныСообщений = Метаданные.НайтиПоПолномуИмени("Справочник.ШаблоныСообщений");
	
	ЕстьПравоИспользованияШаблонов = ПравоДоступа("Чтение", СправочникШаблоныСообщений) 
		И ПравоДоступа("Добавление", СправочникШаблоныСообщений);
	
	Если Не ЕстьПравоИспользованияШаблонов Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	Если ИнтеграцияСЯндексКассойСлужебный.ВсеШаблоныСозданы() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Возврат Истина;
	
КонецФункции

#КонецОбласти

#Область СтраницаПолученияНастроек

&НаКлиенте 
Процедура ПолучитьНастройкиИзСервиса()
	
	// Очистим параметры которые не доступны для заполнения вручную при схеме без договора.
	Если Не СДоговором Тогда 
		ИдентификаторМагазина = 0;
		ИдентификаторВитрины = 0;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"СтраницыПолученияНастроек",
		"ТекущаяСтраница",
		Элементы.СтраницаПолучениеНастроек);
			
	ПолучитьАктуальныеНастройкиИзСервиса();
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьАктуальныеНастройкиИзСервиса()
	
	ДлительнаяОперация = ВыполнитьМетодСервисаВФоне("ПолучитьНастройки", Неопределено, УникальныйИдентификатор);
	
	ИдентификаторЗаданияПолученияНастроек = ДлительнаяОперация.ИдентификаторЗадания;
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(ЭтотОбъект);
	ПараметрыОжидания.ТекстСообщения = НСтр("ru = 'Получение настроек по Яндекс.Кассе'");
	ПараметрыОжидания.ВыводитьПрогрессВыполнения = Ложь;
	ПараметрыОжидания.ВыводитьОкноОжидания = Ложь;
	ПараметрыОжидания.ОповещениеПользователя.Показать = Ложь;
	ПараметрыОжидания.ВыводитьСообщения = Истина;
	
	ПолучитьНастройкиЗавершение = Новый ОписаниеОповещения(
		"ПолучитьАктуальныеНастройкиИзСервисаЗавершение", ЭтотОбъект);
	
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация,
		ПолучитьНастройкиЗавершение,
		ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте 
Процедура ПолучитьАктуальныеНастройкиИзСервисаЗавершение(Результат, ДополнительныеПараметры) Экспорт 
	
	Отказ = Ложь;
	
	Если Результат = Неопределено Тогда  // отменено пользователем
		Отказ = Истина;
		Возврат;
	КонецЕсли;
	
	Если Результат.Свойство("Сообщения") Тогда 
		Для Каждого Сообщение Из Результат.Сообщения Цикл 
			Сообщение.Сообщить();
		КонецЦикла;
	КонецЕсли;
	
	Если Не Отказ И Результат.Статус = "Выполнено" Тогда
		
		Если ЗначениеЗаполнено(Результат.АдресРезультата) 
			И ЭтоАдресВременногоХранилища(Результат.АдресРезультата) Тогда 
			
			Настройки = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
			Если ТипЗнч(Настройки) = Тип("Структура") 
				И Настройки.Количество() Тогда 
				
				Настройки.Свойство("ИдентификаторМагазина", ИдентификаторМагазина);
				Настройки.Свойство("ИдентификаторВитрины", ИдентификаторВитрины);
				Отказ = Настройки.ЕстьОшибки;
				
			Иначе
				Отказ = Истина;
			КонецЕсли;
		Иначе
			Отказ = Истина;
		КонецЕсли;
		
	ИначеЕсли Результат.Статус = "Ошибка" Тогда
		ТекстСообщения = Результат.ПодробноеПредставлениеОшибки;
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
		Отказ = Истина;
	КонецЕсли;
	
	Если Отказ Тогда 
		ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
			"СтраницыПолученияНастроек",
			"ТекущаяСтраница",
			Элементы.СтраницаОшибкаПолученияНастроек);
	Иначе
		СменитьСтраницуШаги(Элементы.СтраницаФинал);
		СменитьСтраницуКомандНавигации(Элементы.Готово);
		СменитьВидимостьПодменюЕще(ЭтотОбъект, Ложь);
	КонецЕсли;
	
	ИдентификаторЗаданияПолученияНастроек = Неопределено;
	
КонецПроцедуры 

#КонецОбласти

#Область СтраницаФинал 

&НаКлиенте 
Процедура ПриОткрытииСтраницыФинал(Отказ)
	
	ПриОткрытииСтраницыФиналНаСервере(Отказ);
	
	Если Отказ Тогда 
		Возврат;
	КонецЕсли;
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"ГруппаСозданыШаблоныПисем",
		"Видимость",
		СозданныеШаблоныСообщений.Количество());
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Элементы,
		"СтраницыФинала",
		"ТекущаяСтраница",
		?(РежимСоздания,
		Элементы.СтраницаУспешноеПодключение,
		Элементы.СтраницаУспешноеСохранениеИзменений));
		
	Оповестить("Запись_НастройкиЯндексКассы", , НастройкаЯндексКассыСсылка);
	ОповеститьОбИзменении(НастройкаЯндексКассыСсылка);
		
КонецПроцедуры

&НаСервере
Процедура ПриОткрытииСтраницыФиналНаСервере(Отказ)
	
	Если Отказ Тогда 
		Возврат;
	КонецЕсли;
	
	// Настройка Яндекс.Кассы
	СоздатьЗаписатьНастройкуЯндексКассы(Отказ);
	
	// Шаблоны сообщений
	Если ИспользоватьШаблоныСообщений() И СоздатьШаблоныАвтоматически Тогда
		ПроверитьИВключитьФункциональныеОпцииРаботыСПочтовымиСообщениями();
		ПроверитьИВключитьФункциональныеОпцииШаблоновСообщений();
		
		ПредопределенныеШаблоныСообщений = ИнтеграцияСЯндексКассойСлужебный.СоздатьПредопределенныеШаблоныСообщений();
		СозданныеШаблоныСообщений.ЗагрузитьЗначения(ПредопределенныеШаблоныСообщений);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СоздатьЗаписатьНастройкуЯндексКассы(Отказ)
	
	Если РежимСоздания Тогда 
		НастройкиОбъект = Справочники.НастройкиЯндексКассы.СоздатьЭлемент();
	Иначе
		НастройкиОбъект = Объект.Ссылка.ПолучитьОбъект();
	КонецЕсли;
	
	СписокРеквизитов = "СДоговором, Организация, ИдентификаторМагазина, ИдентификаторВитрины, Недействительна, ОтправкаЧековЧерезЯндекс";
	
	НастройкиОбъект.Наименование = Организация;
	
	ЗаполнитьЗначенияСвойств(НастройкиОбъект, ЭтотОбъект, СписокРеквизитов);
	
	НастройкиОбъект.ДополнительныеНастройки.Очистить();
	Для каждого Настройка Из РеквизитыДополнительныхНастроек Цикл
		СтрокаНастроек = НастройкиОбъект.ДополнительныеНастройки.Добавить();
		СтрокаНастроек.Настройка = Настройка.Ключ;
		СтрокаНастроек.Значение = ЭтотОбъект[Настройка.Значение];
	КонецЦикла;
	
	НачатьТранзакцию();
	Попытка
		НастройкиОбъект.Записать();
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		Отказ = Истина;
		ЭлектронноеВзаимодействиеСлужебныйВызовСервера.ОбработатьОшибку(НСтр("ru = 'Запись настройки по Яндекс Кассе'"),
			ОписаниеОшибки(), НСтр("ru = 'Возникла ошибка при записи настройки по Яндекс.Кассе'"), 6);
	КонецПопытки;
		
	Модифицированность = Ложь;
	РазблокироватьДанныеФормыДляРедактирования();
	
	НастройкаЯндексКассыСсылка = НастройкиОбъект.Ссылка;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПроверитьИВключитьФункциональныеОпцииРаботыСПочтовымиСообщениями()
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.Взаимодействия") Тогда
		Возврат;
	КонецЕсли;
	
	МодульВзаимодействия = ОбщегоНазначения.ОбщийМодуль("Взаимодействия");
		
	Если Не МодульВзаимодействия.ИспользуетсяПочтовыйКлиент() Тогда
		
		Константы["ИспользоватьПочтовыйКлиент"].Установить(Истина);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ПроверитьИВключитьФункциональныеОпцииШаблоновСообщений()
	
	Если Не ОбщегоНазначения.ПодсистемаСуществует("СтандартныеПодсистемы.ШаблоныСообщений") Тогда
		Возврат;
	КонецЕсли;
	
	МодульШаблоныСообщенийСлужебный = ОбщегоНазначения.ОбщийМодуль("ШаблоныСообщенийСлужебный");
		
	Если Не МодульШаблоныСообщенийСлужебный.ИспользуютсяШаблоныСообщений() Тогда
		
		Константы["ИспользоватьШаблоныСообщений"].Установить(Истина);
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область Навигация

&НаКлиенте
Процедура СменитьСтраницуШаги(Знач НоваяСтраница)
	
	Элементы.КомандыНавигации.Доступность = Истина;
	
	КомандыСВозвратом = Элементы.НазадДалееОтмена;
	КомандыБезВозврата = Элементы.ДалееОтмена;
	
	Если НоваяСтраница = Элементы.СтраницаКарточкаНастройки Тогда 
		
		ПриОткрытииСтраницыКарточкаНастройки(ХронологияПереключенияСтраниц.Количество());
		
	ИначеЕсли НоваяСтраница = Элементы.СтраницаПереопределяемая Тогда
		
		Отказ = Ложь;
		ПропуститьСтраницуПереопределяемая = Ложь;
		ПриОткрытииСтраницыПереопределяемая(Отказ);
		Если Отказ Тогда
			Элементы.Шаги.ТекущаяСтраница = НоваяСтраница;
			ПропуститьСтраницуПереопределяемая = Истина;
			Далее(Неопределено);
			Возврат;
		КонецЕсли;
		
	ИначеЕсли НоваяСтраница = Элементы.СтраницаШаблоныСообщений Тогда 
		
		ПриОткрытииСтраницыШаблоныСообщений();
		
	ИначеЕсли НоваяСтраница = Элементы.СтраницаФинал Тогда 
		
		Отказ = Ложь;
		ПриОткрытииСтраницыФинал(Отказ);
		
		Если Отказ Тогда
			Возврат;
		КонецЕсли;
		
	КонецЕсли;
	
	Если ХронологияПереключенияСтраниц.Количество() Тогда
		СменитьСтраницуКомандНавигации(КомандыСВозвратом)
	Иначе
		СменитьСтраницуКомандНавигации(КомандыБезВозврата)
	КонецЕсли;
	
	Элементы.Шаги.ТекущаяСтраница = НоваяСтраница;
	
КонецПроцедуры

&НаКлиенте
Процедура СменитьСтраницуКомандНавигации(НоваяСтраница)
	
	Элементы.КомандыНавигации.ТекущаяСтраница = НоваяСтраница;
	
	Если НоваяСтраница = Элементы.ДалееОтмена Тогда
		Элементы.ДалееПервая.КнопкаПоУмолчанию = Истина;
		Элементы.ДалееПервая.АктивизироватьПоУмолчанию = Истина;
		ТекущийЭлемент = Элементы.ДалееПервая;
	ИначеЕсли НоваяСтраница = Элементы.НазадДалееОтмена Тогда
		Элементы.ДалееВторая.КнопкаПоУмолчанию = Истина;
		Элементы.ДалееВторая.АктивизироватьПоУмолчанию = Истина;
		ТекущийЭлемент = Элементы.ДалееВторая;
	ИначеЕсли НоваяСтраница = Элементы.НазадГотово Тогда
		Элементы.ГотовоПервая.КнопкаПоУмолчанию = Истина;
	ИначеЕсли НоваяСтраница = Элементы.Готово Тогда
		Элементы.ГотовоВторая.КнопкаПоУмолчанию = Истина;
	ИначеЕсли НоваяСтраница = Элементы.НазадСохранитьОтмена Тогда
		Элементы.ДалееТретья.КнопкаПоУмолчанию = Истина;
		Элементы.ДалееТретья.АктивизироватьПоУмолчанию = Истина;
		ТекущийЭлемент = Элементы.ДалееТретья;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВернутьсяНаПредыдущуюСтраницу()
	
	ПредыдущийШаг = ХронологияПереключенияСтраниц[ХронологияПереключенияСтраниц.ВГраница()];
	ХронологияПереключенияСтраниц.Удалить(ХронологияПереключенияСтраниц.ВГраница());
	СменитьСтраницуШаги(ПредыдущийШаг);

КонецПроцедуры

#КонецОбласти

#Область Подвал

&НаКлиентеНаСервереБезКонтекста
Процедура СменитьВидимостьПодменюЕще(Форма, Видимость)
	
	ОбщегоНазначенияКлиентСервер.УстановитьСвойствоЭлементаФормы(Форма.Элементы,
		"ПодменюЕще",
		"Видимость",
		Видимость);
		
КонецПроцедуры

#КонецОбласти

#Область РаботаСФоновымиЗаданиями

&НаСервереБезКонтекста
Функция ВыполнитьМетодСервисаВФоне(Знач ИмяМетода, Знач ВходящиеПараметры, Знач ИдентификаторФормы)
	
	ДлительнаяОперация = ИнтеграцияСЯндексКассойСлужебный.ВыполнитьМетодСервисаВФоне(ИмяМетода, ВходящиеПараметры, ИдентификаторФормы);
	
	Возврат ДлительнаяОперация;
	
КонецФункции

&НаКлиенте
Процедура ОтменитьАктивныеФоновыеОперации()
	
	Если Не ИдентификаторЗаданияПолученияНастроек = Неопределено Тогда 
		
		ОтменитьВыполнениеЗадания(ИдентификаторЗаданияПолученияНастроек);
		ИдентификаторЗаданияПолученияНастроек = Неопределено;

	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ОтменитьВыполнениеЗадания(ИдентификаторЗадания)
	
	ДлительныеОперации.ОтменитьВыполнениеЗадания(ИдентификаторЗадания);
	
КонецПроцедуры

&НаКлиенте
Процедура ПолучениеНастроекДлительнаяОперацияНадпись1ОбработкаНавигационнойСсылки(Элемент, НавигационнаяСсылкаФорматированнойСтроки, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	ОчиститьСообщения();
	
	ПолучитьНастройкиИзСервиса();
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

