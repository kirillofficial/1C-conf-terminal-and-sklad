﻿
Процедура ОбработкаПроведения(Отказ, Режим)
	// регистр ДвижениеОсновныхДеталей
	Движения.ДвижениеОсновныхДеталей.Записывать = Истина;
	Для Каждого ТекСтрокаОсновныеДетали Из ОсновныеДетали Цикл
		Движение = Движения.ДвижениеОсновныхДеталей.Добавить();
		Движение.Период = Дата;
		Движение.Деталь = ТекСтрокаОсновныеДетали.ДетальПередатьНеиспр;
		Движение.Статус = Перечисления.СтатусДетали.Неисправно;
		Движение.Комментарий = ТекСтрокаОсновныеДетали.НеисправностьДет;
		Если ИсточникПоступленияНеисправно = Перечисления.СтатусДетали.ВЗапас или ИсточникПоступленияНеисправно = Перечисления.СтатусДетали.Используется тогда
			Движение.Исполнитель = Менеджер;
		КонецЕсли;
	КонецЦикла;

	Если ИсточникПоступленияНеисправно = Перечисления.СтатусДетали.Используется тогда
	// регистр Используется Расход
		Движения.Используется.Записывать = Истина;
		Для Каждого ТекСтрокаРасходныеДетали Из РасходныеДетали Цикл
			Движение = Движения.Используется.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ДетальРасх = ТекСтрокаРасходныеДетали.ДетальРасходНеиспр;
			Движение.ТерминалРасх = Терминал;
			Движение.КоличествоРасх = ТекСтрокаРасходныеДетали.КоличествоРасхНеиспр;
			Движение.ИсполнительРасхИсп = Менеджер;
			Движение.КомментарийРасхИсп = ТекСтрокаРасходныеДетали.КомментарийРасх;
		КонецЦикла;
		
	ИначеЕсли ИсточникПоступленияНеисправно = Перечисления.СтатусДетали.ВЗапас тогда
		// регистр ВЗапас Расход
		Движения.ВЗапас.Записывать = Истина;
		Для Каждого ТекСтрокаРасходныеДетали Из РасходныеДетали Цикл
			Движение = Движения.ВЗапас.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ДетальРасхЗапас = ТекСтрокаРасходныеДетали.ДетальРасходНеиспр;
			Движение.МенеджерРасхЗапас = Менеджер;
			Движение.КоличествоРасхЗапас = ТекСтрокаРасходныеДетали.КоличествоРасхНеиспр;
			Движение.ИсполнительРасхЗапас = Менеджер;
			Движение.КомментарийРасхЗапас = ТекСтрокаРасходныеДетали.КомментарийРасх;
		КонецЦикла;

	 ИначеЕсли ИсточникПоступленияНеисправно = Перечисления.СтатусДетали.НаСкладе тогда
	// регистр НаСклад Расход
		Движения.НаСклад.Записывать = Истина;
		Для Каждого ТекСтрокаРасходныеДетали Из РасходныеДетали Цикл
			Движение = Движения.НаСклад.Добавить();
			Движение.ВидДвижения = ВидДвиженияНакопления.Расход;
			Движение.Период = Дата;
			Движение.ДетальРасхНаСклад = ТекСтрокаРасходныеДетали.ДетальРасходНеиспр;
			Движение.КоличествоРасхНаСклад = ТекСтрокаРасходныеДетали.КоличествоРасхНеиспр;
			Движение.ИсполнительРасхНаСклад = Менеджер;
			Движение.КомментарийРасхНаСклад = ТекСтрокаРасходныеДетали.КомментарийРасх;
		КонецЦикла;
	КонецЕсли;
	
	// регистр Неисправно Приход
	Движения.Неисправно.Записывать = Истина;
	Для Каждого ТекСтрокаРасходныеДетали Из РасходныеДетали Цикл
		Движение = Движения.Неисправно.Добавить();
		Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
		Движение.Период = Дата;
		Движение.ДетальРасхНаРем = ТекСтрокаРасходныеДетали.ДетальРасходНеиспр;
		Движение.КоличествоРасхНаСклад = ТекСтрокаРасходныеДетали.КоличествоРасхНеиспр;
		Движение.ИсполнительРасхНаСклад = Менеджер;
		Движение.КомментарийРасхНаСклад = ТекСтрокаРасходныеДетали.КомментарийРасх;
	КонецЦикла;

	//}}__КОНСТРУКТОР_ДВИЖЕНИЙ_РЕГИСТРОВ
КонецПроцедуры
