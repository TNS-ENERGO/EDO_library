#Область ОбработчикиСобытий

&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ВидДокумента = ПредопределенноеЗначение("Перечисление.ВидыДокументов.СчетФактура");
	ЗначенияЗаполнения = Новый Структура("ВидДокумента", ВидДокумента);
	ПараметрыФормы = Новый Структура("ЗначенияЗаполнения", ЗначенияЗаполнения);
	ОткрытьФорму("Документ.СчетФактураВыданный.ФормаОбъекта",
		ПараметрыФормы,
		ПараметрыВыполненияКоманды.Источник, 
		ПараметрыВыполненияКоманды.Уникальность,
		ПараметрыВыполненияКоманды.Окно, 
		ПараметрыВыполненияКоманды.НавигационнаяСсылка);
	
КонецПроцедуры

#КонецОбласти