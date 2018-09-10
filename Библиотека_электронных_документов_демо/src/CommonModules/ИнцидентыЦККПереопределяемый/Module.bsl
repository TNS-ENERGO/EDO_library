////////////////////////////////////////////////////////////////////////////////
// Подсистема "ПодсистемыЦККВМоделиСервиса".
//
////////////////////////////////////////////////////////////////////////////////


#Область СлужебныйПрограммныйИнтерфейс

// Процедура дополняет список типов инцидентов СписокТипов
//
// Параметры:
//  СписокТипов	 - Соответствие - Ключ: строка(100) с именем типа, Значение: структура со строковыми полями
//		УровеньИнцидента, Подсистема, Теги, ПроцедураПроверки.
//
Процедура СписокТиповИнцидентовПереопределяемый(СписокТипов) Экспорт
	
	// Здесь следует определить прикладные типы инцидентов и методы их проверки актуальности. Подробно см:
	
	// ИнцидентыЦККСервер.СоздатьОписаниеТипаИнцидента,
	// ИнцидентыЦККСервер.СоздатьЗаписьТипа.
	
	// Краткий пример: 
	
	// Описание = ИнцидентыЦККСервер.СоздатьОписаниеТипаИнцидента("ОстановиласьОчередьОбменаССайтом");
	// ИнцидентыЦККСервер.СоздатьЗаписьТипа(СписокТипов, Описание);

КонецПроцедуры


// В процедуре можно вызвать все прикладные проверки, связанные с периодическим мониторингом прикладной конфигурации.
// Процедура вызывается с помощью регламентной процедуры МониторингЦКК раз в минуту, если константа АдресЦКК заполнена.
Процедура ВыполнитьЗадачиМониторингаЦКК() Экспорт
	
КонецПроцедуры

#КонецОбласти

