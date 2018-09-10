
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Если Не БизнесСеть.ПравоНастройкиОбменаДокументами(Истина) Тогда
		Отказ = Истина;
		Возврат;
	КонецЕсли;
		
	ОбновитьДанныеАутентификации();
	
	ОдиночнаяРегистрация = ЗначениеЗаполнено(Параметры.Ссылка);
	ИспользуетсяНесколькоОрганизаций = ПолучитьФункциональнуюОпцию("ИспользоватьНесколькоОрганизацийЭД");
	
	Если Не ОдиночнаяРегистрация И Не ИспользуетсяНесколькоОрганизаций Тогда
		Параметры.Ссылка = ЭлектронноеВзаимодействиеСлужебный.ОрганизацияПоУмолчанию();
		Если ЗначениеЗаполнено(Параметры.Ссылка) Тогда
			ОдиночнаяРегистрация = Истина;
		КонецЕсли;
	КонецЕсли;
	
	Если ОдиночнаяРегистрация Тогда
		РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца;
		ЗаполнитьРеквизитыПоСсылке(Параметры.Ссылка);
	КонецЕсли;
	Элементы.КомандаЗакрытьОдиночная.Видимость = ОдиночнаяРегистрация;
	
	ИнициализацияДинамическогоСписка();
	
	ДанныеКонтекста = Неопределено;
	Если Параметры.Свойство("ДанныеКонтекста") И ТипЗнч(Параметры.ДанныеКонтекста) = Тип("Структура") Тогда
		ДанныеКонтекста = Новый Структура;
		ДанныеКонтекста.Вставить("РежимПоставщика", Ложь);
		ДанныеКонтекста.Вставить("РежимПокупателя", Ложь);
		ЗаполнитьЗначенияСвойств(ДанныеКонтекста, Параметры.ДанныеКонтекста);
	КонецЕсли;
	УстановкаВидимостиЭлементовПодсистемыТорговыеПредложения();
	
	КлючСохраненияПоложенияОкна = СтрШаблон("%1_%2", ОдиночнаяРегистрация, ОрганизацияЗарегистрирована);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	ОбновитьВидимостьДоступностьЭлементов();

КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Если ИмяСобытия = "ИнтернетПоддержкаОтключена" Тогда
		Логин = "";
		ОтобразитьСостояниеПодключенияИПП(ЭтотОбъект, Логин);
	ИначеЕсли ИмяСобытия = "ИнтернетПоддержкаПодключена" Тогда
		ОбновитьДанныеАутентификации();
	ИначеЕсли ИмяСобытия = "БизнесСеть_РегистрацияОрганизаций" И Источник <> ЭтотОбъект Тогда
		Если ОдиночнаяРегистрация Тогда
			ЗаполнитьРеквизитыПоСсылке(Параметры.Ссылка);
			ОбновитьВидимостьДоступностьЭлементов();
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗарегистрироватьОрганизации(Команда)
	
	ОчиститьСообщения();
	ЕстьПодключениеКСервису = Неопределено;
	ОбновитьДанныеАутентификации(ЕстьПодключениеКСервису);

	Если Не ЕстьПодключениеКСервису Тогда
		ИнтернетПоддержкаПользователейКлиент.ПодключитьИнтернетПоддержкуПользователей(
			Новый ОписаниеОповещения("ЗарегистрироватьОрганизацииПродолжение", ЭтотОбъект), ЭтотОбъект);
	Иначе
		ЗарегистрироватьОрганизацииПродолжение(Неопределено, ЭтотОбъект);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОрганизации(Команда)
	
	Если ОдиночнаяРегистрация Тогда
		ТекстВопроса =
			НСтр("ru = 'Будет произведено отключение организации от сервиса 1С:БизнесСеть в программе (информационной базе).
			|При этом, для других участников сервиса организация будет отображаться как зарегистрированные.'");
	Иначе
		ТекстВопроса =
			НСтр("ru = 'Организации будут отключены от сервиса 1С:БизнесСеть в программе (информационной базе).
			|При этом, для других участников сервиса организации будут отображаться как зарегистрированные.'");
	КонецЕсли;
	
	ПоказатьВопрос(Новый ОписаниеОповещения("ОтключитьОрганизацииЗавершение", ЭтотОбъект), ТекстВопроса, РежимДиалогаВопрос.ОКОтмена);
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьОрганизацииВСервисе(Команда)
	
	Если ОдиночнаяРегистрация Тогда
		ТекстВопроса = НСтр("ru = 'Организация будет удалена в сервисе 1С:БизнесСеть.
		|Обмен электронными документами и другие функции сервиса будут недоступны.'");
	Иначе
		ТекстВопроса = НСтр("ru = 'Выбранные организации будут удалены в сервисе 1С:БизнесСеть.
		|Обмен электронными документами и другие функции сервиса будут недоступны.'");
	КонецЕсли;
	
	ПоказатьВопрос(Новый ОписаниеОповещения("УдалитьОрганизацииВСервисЗавершение", ЭтотОбъект),
		ТекстВопроса, РежимДиалогаВопрос.ОКОтмена);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьПрофильАбонента(Команда)
	
	Если ОбщегоНазначенияКлиент.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ТорговыеПредложения") Тогда
		ИмяОткрываемойФормы = "Обработка.ТорговыеПредложения.Форма.ПрофильАбонента";
		ОчиститьСообщения();
		ОткрытьФорму(ИмяОткрываемойФормы);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьДанныеАутентификации(ЕстьПодключениеКСервису = Неопределено)
	
	Если ОбщегоНазначения.РазделениеВключено() Тогда
		Элементы.ДекорацияЛогинИПП.Видимость = Ложь;
		ЕстьПодключениеКСервису = Истина;
	Иначе
		УстановитьПривилегированныйРежим(Истина);
		ПараметрыАутентификации = ИнтернетПоддержкаПользователей.ДанныеАутентификацииПользователяИнтернетПоддержки();
		УстановитьПривилегированныйРежим(Ложь);
		
		Если ТипЗнч(ПараметрыАутентификации) = Тип("Структура") Тогда
			Логин = ПараметрыАутентификации.Логин;
			ЕстьПодключениеКСервису = Истина;
		Иначе
			Логин = "";
			ЕстьПодключениеКСервису = Ложь;
		КонецЕсли;
		ОтобразитьСостояниеПодключенияИПП(ЭтотОбъект, Логин);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиентеНаСервереБезКонтекста
Процедура ОтобразитьСостояниеПодключенияИПП(Форма, Логин)
	
	Если ЗначениеЗаполнено(Логин) Тогда
		МассивСтрок = Новый Массив;
		ШаблонЛогина    = НСтр("ru = 'Интернет-поддержка: подключена для пользователя <b>%1</b>'");
		ШаблонПодсказки = НСтр("ru = 'Регистрация организаций производится с присоединением к учетной записи Интернет-поддержки <b>%1</b>.'");
		ШаблонЛогина = СтрШаблон(ШаблонЛогина, Логин);
		ШаблонПодсказки = СтрШаблон(ШаблонПодсказки, Логин);
	Иначе
		ШаблонЛогина    = НСтр("ru = 'Интернет-поддержка: требуется подключение.'");
		ШаблонПодсказки = НСтр("ru = 'Требуется подключение Интернет-поддержки в программе.
									 |Регистрация организаций производится с присоединением к учетной записи Интернет-поддержки.'");
	КонецЕсли;
	Форма.Элементы.ДекорацияЛогинИПП.Заголовок = СтроковыеФункцииКлиентСервер.ФорматированнаяСтрока(ШаблонЛогина);
	Форма.Элементы.ДекорацияЛогинИПП.РасширеннаяПодсказка.Заголовок = СтроковыеФункцииКлиентСервер.ФорматированнаяСтрока(ШаблонПодсказки);

КонецПроцедуры

&НаКлиенте
Процедура ЗарегистрироватьОрганизацииПродолжение(Знач ПараметрыАутентификации, Контекст) Экспорт
	
	ПараметрыКоманды = Неопределено;
	Если ТипЗнч(ПараметрыАутентификации)= Тип("Структура") Тогда
		Логин = ПараметрыАутентификации.Логин;
	ИначеЕсли ПараметрыАутентификации <> Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Отказ = Ложь;
	ТребуетсяОбновитьИнтерфейс = Ложь;
	
	ЗарегистрироватьОрганизацию(ТребуетсяОбновитьИнтерфейс, Отказ);
	
	Если ТребуетсяОбновитьИнтерфейс Тогда
		#Если НЕ ВебКлиент Тогда
		ОбновитьИнтерфейс();
		#КонецЕсли
		ОбновитьПовторноИспользуемыеЗначения();
		Оповестить("Запись_НаборКонстант",, "ИспользоватьОбменБизнесСеть");
	КонецЕсли;
	
	Если Не Отказ Тогда
		Если ОдиночнаяРегистрация Тогда
			СсылкаОповещения = ПолучитьНавигационнуюСсылку(Параметры.Ссылка);
			ОповеститьОбИзменении(Параметры.Ссылка);
		Иначе
			СсылкаОповещения = Неопределено;
		КонецЕсли;
		ТекстОповещения = НСтр("ru = 'Регистрация организации успешно выполнена.'");
		ПоказатьОповещениеПользователя(НСтр("ru = '1С:Бизнес-сеть'"), СсылкаОповещения, ТекстОповещения, 
			БиблиотекаКартинок.БизнесСеть);
			
		// Скрытие подсказок, если они были видимы.
		Элементы.ГруппаПодсказкиТорговыеПредложения.Видимость = Ложь;
		Оповестить("БизнесСеть_РегистрацияОрганизаций",, ЭтотОбъект);
	КонецЕсли;
	
	Если Не Отказ И (ОдиночнаяРегистрация
		ИЛИ ЭтотОбъект.РежимОткрытияОкна = РежимОткрытияОкнаФормы.БлокироватьОкноВладельца) Тогда
		// Успешная регистрация.
		Закрыть(Истина);
	Иначе
		Элементы.Список.Обновить();
	КонецЕсли;
	
	ОбновитьВидимостьДоступностьЭлементов();
	
КонецПроцедуры

&НаСервере
Процедура ПроверитьСсылкиРегистрации(МассивСсылок, Отказ)
	
	Запрос = Новый Запрос;
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Организации.Ссылка КАК Ссылка,
	|	Организации.ИНН КАК ИНН
	|ИЗ
	|	&Организации КАК Организации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОрганизацииБизнесСеть КАК ОрганизацииБизнесСеть
	|		ПО (ОрганизацииБизнесСеть.Организация = Организации.Ссылка)
	|ГДЕ
	|	Организации.Ссылка В(&МассивСсылок)
	|	И ОрганизацииБизнесСеть.Организация ЕСТЬ NULL";
	
	ИмяСправочникаОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяПрикладногоСправочника("Организации");
	ИННОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("ИННОрганизации");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Организации.ИНН", "Организации." + ИННОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Организации", "Справочник." + ИмяСправочникаОрганизации);
	Запрос.Текст = ТекстЗапроса;
	
	Запрос.УстановитьПараметр("МассивСсылок", МассивСсылок);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		ТекстОшибки = НСтр("ru = 'Команда не может быть выполнена для выделенных строк.'");
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки,,,, Отказ);
		Возврат;
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	МассивСсылок.Очистить();
	Пока Выборка.Следующий() Цикл
		Если ПустаяСтрока(Выборка.ИНН) Тогда
			ТекстОшибки = НСтр("ru = 'Не заполнено свойство ""ИНН"" %1 ""%2"".'");
			ТекстОшибки = СтрШаблон(ТекстОшибки,
				НРег(ИмяСправочникаОрганизации), Выборка.Ссылка);
			ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстОшибки, Выборка.Ссылка);
		Иначе
			МассивСсылок.Добавить(Выборка.Ссылка);
		КонецЕсли;
	КонецЦикла;
	
	Если МассивСсылок.Количество() = 0 Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОтключитьОрганизацииЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	Если ОдиночнаяРегистрация Тогда
		ВыполнитьОтключениеОрганизацииОдиночное(Ложь);
	Иначе
		ВыполнитьОтключениеОрганизаций(Ложь);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура УдалитьОрганизацииВСервисЗавершение(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Отмена Тогда
		Возврат;
	КонецЕсли;
	
	Если ОдиночнаяРегистрация Тогда
		ВыполнитьОтключениеОрганизацииОдиночное(Истина);
	Иначе
		ВыполнитьОтключениеОрганизаций(Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьРеквизитыПоСсылке(Ссылка)
	
	СокращенноеНаименованиеОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("СокращенноеНаименованиеОрганизации");
	ИННОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("ИННОрганизации");
	КППОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("КППОрганизации");
	
	Запрос = Новый Запрос;
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Наименование КАК Наименование,
	|	Организации.ИНН КАК ИНН,
	|	Организации.КПП КАК КПП,
	|	ВЫБОР
	|		КОГДА ОрганизацииБизнесСеть.Организация ЕСТЬ NULL 
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК ОрганизацияЗарегистрирована
	|ИЗ
	|	&Организации КАК Организации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОрганизацииБизнесСеть КАК ОрганизацииБизнесСеть
	|		ПО Организации.Ссылка = ОрганизацииБизнесСеть.Организация
	|ГДЕ
	|	Организации.Ссылка = &Ссылка";
	
	Запрос.УстановитьПараметр("Ссылка", Параметры.Ссылка);
	ИмяСправочникаОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяПрикладногоСправочника("Организации");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Организации", "Справочник." + ИмяСправочникаОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Организации.Наименование", "Организации." + СокращенноеНаименованиеОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Организации.ИНН", "Организации." + ИННОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "Организации.КПП", "Организации." + КППОрганизации);
	
	Запрос.Текст = ТекстЗапроса;
	Выборка = Запрос.Выполнить().Выбрать();
	
	ОрганизацияЗарегистрирована = Ложь;
	ОрганизацияНаименование = "";
	ОрганизацияИНН = "";
	ОрганизацияКПП = "";
	
	Если Выборка.Следующий() Тогда
		ОрганизацияНаименование = Выборка.Наименование;
		ОрганизацияИНН = Выборка.ИНН;
		ОрганизацияКПП = Выборка.КПП;
		ОрганизацияЗарегистрирована = Выборка.ОрганизацияЗарегистрирована;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимостьДоступностьЭлементов()
	
	Элементы.ГруппаОдиночное.Видимость             = ОдиночнаяРегистрация;
	Элементы.ГруппаСписок.Видимость                = Не ОдиночнаяРегистрация;
	Элементы.ОрганизацияЗарегистрирована.Видимость     = ОрганизацияЗарегистрирована;
	Элементы.Подключить.Доступность                = Не ОрганизацияЗарегистрирована;
	Элементы.ГруппаКПП.Видимость                   = ЗначениеЗаполнено(ОрганизацияКПП);
	
КонецПроцедуры

&НаСервере
Процедура ИнициализацияДинамическогоСписка()
	
	ТекстЗапроса =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|	Организации.Ссылка КАК Ссылка,
	|	ВЫБОР
	|		КОГДА ОрганизацииБизнесСеть.Организация ЕСТЬ NULL
	|			ТОГДА ЛОЖЬ
	|		ИНАЧЕ ИСТИНА
	|	КОНЕЦ КАК Регистрация,
	|	Организации.ИНН КАК ИНН,
	|	Организации.КПП КАК КПП
	|ИЗ
	|	&Организации КАК Организации
	|		ЛЕВОЕ СОЕДИНЕНИЕ РегистрСведений.ОрганизацииБизнесСеть КАК ОрганизацииБизнесСеть
	|		ПО Организации.Ссылка = ОрганизацииБизнесСеть.Организация";
	
	ИмяСправочникаОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяПрикладногоСправочника("Организации");
	ИННОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("ИННОрганизации");
	КППОрганизации = ЭлектронноеВзаимодействиеСлужебныйПовтИсп.ИмяНаличиеОбъектаРеквизитаВПрикладномРешении("КППОрганизации");
	
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&Организации", "Справочник." + ИмяСправочникаОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, ".ИНН", "." + ИННОрганизации);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, ".КПП", "." + КППОрганизации);
	
	СвойстваСписка = ОбщегоНазначения.СтруктураСвойствДинамическогоСписка();
	СвойстваСписка.ОсновнаяТаблица = "Справочник." + ИмяСправочникаОрганизации;
	СвойстваСписка.ДинамическоеСчитываниеДанных = Истина;
	СвойстваСписка.ТекстЗапроса = ТекстЗапроса;
	ОбщегоНазначения.УстановитьСвойстваДинамическогоСписка(Элементы.Список, СвойстваСписка);	
	
КонецПроцедуры
 
&НаСервере
Процедура ЗарегистрироватьОрганизацию(ТребуетсяОбновитьИнтерфейс, Отказ)
	
	ОтобразитьСостояниеПодключенияИПП(ЭтотОбъект, Логин);
	
	Если ОдиночнаяРегистрация Тогда
		МассивСсылок = Новый Массив;
		МассивСсылок.Добавить(Параметры.Ссылка);
	Иначе
		МассивСсылок = Элементы.Список.ВыделенныеСтроки;
		ПроверитьСсылкиРегистрации(МассивСсылок, Отказ);
	КонецЕсли;
		
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	БизнесСеть.ЗарегистрироватьОрганизации(МассивСсылок, Отказ, ТребуетсяОбновитьИнтерфейс);
	
	Если Отказ Тогда
		Возврат;
	КонецЕсли;
	
	Если ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ТорговыеПредложения") 
		И Элементы.ГруппаПодсказкиТорговыеПредложения.Видимость = Истина Тогда
		
		// Сохранение значений вывода подсказок.
		УстановитьПривилегированныйРежим(Истина);
		Константы["ПоказыватьПодсказкиПоставщиковБизнесСеть"].Установить(Константа_ПоказыватьПодсказкиПоставщиков);
		Константы["ПоказыватьПодсказкиПокупателейБизнесСеть"].Установить(Константа_ПоказыватьПодсказкиПокупателей);
		
		// Изменение регламентного задания.
		БизнесСеть.ИзменитьРегламентноеЗадание("ОбновлениеПодсказокТорговыеПредложения",
			"Использование", Макс(Константа_ПоказыватьПодсказкиПоставщиков, Константа_ПоказыватьПодсказкиПокупателей));
		УстановитьПривилегированныйРежим(Ложь);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОтключениеОрганизаций(РежимУдаленияВСервисе)
	
	ОчиститьСообщения();
	
	Отказ = Ложь;
	МассивСсылок = Элементы.Список.ВыделенныеСтроки;
	
	ТребуетсяОбновитьИнтерфейс = Ложь;
	БизнесСетьВызовСервера.ОтключитьОрганизации(МассивСсылок, РежимУдаленияВСервисе, Отказ, ТребуетсяОбновитьИнтерфейс);

	Если ТребуетсяОбновитьИнтерфейс Тогда
		#Если НЕ ВебКлиент Тогда
		ОбновитьИнтерфейс();
		#КонецЕсли
	 	ОбновитьПовторноИспользуемыеЗначения();
		Оповестить("Запись_НаборКонстант",, "ИспользоватьОбменБизнесСеть");
	КонецЕсли;
	
	Если Не Отказ Тогда
		Если РежимУдаленияВСервисе Тогда
			ТекстОповещения = НСтр("ru = 'Удаление организаций в сервисе успешно выполнено.'");
		Иначе
			ТекстОповещения = НСтр("ru = 'Отключение организаций в программе успешно выполнено.'");
		КонецЕсли;
		ПоказатьОповещениеПользователя(НСтр("ru = '1С:Бизнес-сеть'"),, ТекстОповещения, БиблиотекаКартинок.БизнесСеть);
		Оповестить("БизнесСеть_РегистрацияОрганизаций",, ЭтотОбъект);
	КонецЕсли;
	
	Элементы.Список.Обновить();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьОтключениеОрганизацииОдиночное(РежимУдаленияВСервисе)
	
	ОчиститьСообщения();
	
	Отказ = Ложь;
	Массив = Новый Массив;
	Массив.Добавить(Параметры.Ссылка);
	ТребуетсяОбновитьИнтерфейс = Ложь;
	БизнесСетьВызовСервера.ОтключитьОрганизации(Массив, РежимУдаленияВСервисе, Отказ, ТребуетсяОбновитьИнтерфейс);

	Если ТребуетсяОбновитьИнтерфейс Тогда
		#Если НЕ ВебКлиент Тогда
		ОбновитьИнтерфейс();
		#КонецЕсли
	 	ОбновитьПовторноИспользуемыеЗначения();
		Оповестить("Запись_НаборКонстант",, "ИспользоватьОбменБизнесСеть");
	КонецЕсли;
	
	Если Не Отказ Тогда
		Если РежимУдаленияВСервисе Тогда
			ТекстОповещения = НСтр("ru = 'Удаление организации в сервисе успешно выполнено.'");
		Иначе
			ТекстОповещения = НСтр("ru = 'Отключение организации в программе успешно выполнено.'");
		КонецЕсли;
		ПоказатьОповещениеПользователя(НСтр("ru = '1С:Бизнес-сеть'"),, ТекстОповещения, БиблиотекаКартинок.БизнесСеть);
		ОрганизацияЗарегистрирована = Истина;
		
		Оповестить("БизнесСеть_РегистрацияОрганизаций",, ЭтотОбъект);
	КонецЕсли;
	
	Закрыть();
	
КонецПроцедуры

&НаСервере
Процедура УстановкаВидимостиЭлементовПодсистемыТорговыеПредложения()
	
	// Проверка видимости торговых предложений.
	ОбщийМодульТорговыеПредложения = Неопределено;
	ПравоНастройки = Ложь;
	Если ОбщегоНазначения.ПодсистемаСуществует("ЭлектронноеВзаимодействие.ТорговыеПредложения") Тогда
		ОбщийМодульТорговыеПредложения = ОбщегоНазначения.ОбщийМодуль("ТорговыеПредложения");
		ПравоНастройки = ОбщийМодульТорговыеПредложения.ПравоНастройкиТорговыхПредложений();
	КонецЕсли;
	
	Если ОбщийМодульТорговыеПредложения = Неопределено Или ПравоНастройки = Ложь Тогда
		Элементы.ОткрытьПрофильАбонента.Видимость = Ложь;
		Элементы.ГруппаПодсказкиТорговыеПредложения.Видимость = Ложь;
		Возврат;
	КонецЕсли;
	
	ЕстьЗарегистрированныеОрганизации = БизнесСеть.ОрганизацияЗарегистрирована();
	
	МассивПодстрок = Новый Массив;
	МассивПодстрок.Добавить(Элементы.КраткоеОписание.Заголовок);
	МассивПодстрок.Добавить(Символы.ПС + "• ");
	МассивПодстрок.Добавить(Новый ФорматированнаяСтрока(НСтр("ru = 'Торговые предложения'"),,,, "https://portal.1c.ru/applications/60"));
	МассивПодстрок.Добавить(Новый ФорматированнаяСтрока(" — " 
		+ НСтр("ru = 'торговая площадка в программах 1С:Предприятие для поставщиков и покупателей (закупщиков).
		|Поставщикам - сервис помогает упростить процессы обработки заказов и получить новых клиентов;
		|Покупателям - найти выгодных поставщиков и сократить время оформления заказов.'")));
	Элементы.КраткоеОписание.Заголовок = Новый ФорматированнаяСтрока(МассивПодстрок);
	
	// Прочитать значения вывода подсказок.
	УстановитьПривилегированныйРежим(Истина);
	Константа_ПоказыватьПодсказкиПоставщиков = Константы["ПоказыватьПодсказкиПоставщиковБизнесСеть"].Получить();
	Константа_ПоказыватьПодсказкиПокупателей = Константы["ПоказыватьПодсказкиПокупателейБизнесСеть"].Получить();
	УстановитьПривилегированныйРежим(Ложь);
		
	// Установка видимости подсказок.
	// Подсказка отображается, если есть соответствующий контекст формы и еще не установлена константа показа
	// или еще не зарегистрирована ни одна организация.
	ВидимостьПоставщика = (ДанныеКонтекста = Неопределено И Не ЕстьЗарегистрированныеОрганизации)
		ИЛИ (ТипЗнч(ДанныеКонтекста) = Тип("Структура") И ДанныеКонтекста.РежимПоставщика
		     И Не Константа_ПоказыватьПодсказкиПоставщиков);
	Элементы.ПоказыватьПодсказкиПоставщиков.Видимость = ВидимостьПоставщика;
	Если ВидимостьПоставщика Тогда
		Константа_ПоказыватьПодсказкиПоставщиков = Истина;
	КонецЕсли;
	
	ВидимостьПокупателя = (ДанныеКонтекста = Неопределено И Не ЕстьЗарегистрированныеОрганизации)
		ИЛИ (ТипЗнч(ДанныеКонтекста) = Тип("Структура") И ДанныеКонтекста.РежимПокупателя
		     И Не Константа_ПоказыватьПодсказкиПокупателей);
	Элементы.ПоказыватьПодсказкиПокупателей.Видимость = ВидимостьПоставщика;
	Если ВидимостьПокупателя Тогда
		Константа_ПоказыватьПодсказкиПокупателей = Истина;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
