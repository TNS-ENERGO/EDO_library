
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда // Возврат при получении формы для анализа.
		Возврат;
	КонецЕсли;
	
	Файл = Параметры.Файл;
	Сообщение = Параметры.Сообщение;
	
	РежимСозданияФайла = 1;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СохранитьФайл(Команда)
	
	Закрыть(РежимСозданияФайла);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьКаталог(Команда)
	
	РаботаСФайламиСлужебныйКлиент.ОткрытьПроводникСФайлом(Файл);
	
КонецПроцедуры

#КонецОбласти
