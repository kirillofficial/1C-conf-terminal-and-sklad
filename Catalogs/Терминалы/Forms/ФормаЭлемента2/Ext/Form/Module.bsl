﻿#Область ПроцедурыФормы

	//от здесь
	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		ТекущаяМетка = ПолучитьМетку(Объект.Ссылка);
		Организация = ПолучитьДанныеСРегистра(Объект.Ссылка).Организация;
		Договор = ПолучитьДанныеСРегистра(Объект.Ссылка).ДоговорАрендРегистр;
		ДатаПослОпл = ПолучитьДанныеОбОплАренд(Договор).ДатаРегОпл;
		ФД = ПолучитьФормуДоговора(Договор); 
		Если ФД  = ПолучитьПеречислениеФормыДоговораПисьменный() тогда
			НаРуках = истина;
		иначе 
			НаРуках = Ложь;
		КонецЕсли;
	КонецПроцедуры

#КонецОбласти

#Область КомандыКнопок

	//Отбор для вывода Истории терминалов
	&НаКлиенте
	Процедура Команда2(Команда)
		ЗначОтб = Новый Структура("Терминал",Объект.Ссылка);
		ПарамВыбор = Новый Структура("Отбор",ЗначОтб);
		ОткрытьФорму("РегистрСведений.ДвижениеТерминалов.Форма.ФормаСписка",ПарамВыбор);
	КонецПроцедуры

	&НаКлиенте
	Процедура КомплектующиеНаТермин(Команда)
		ЗначОтб = Новый Структура("Терминал",Объект.Ссылка);
		ПарамВыбор = Новый Структура("Отбор",ЗначОтб);
		ОткрытьФорму("РегистрСведений.ДвижениеОсновныхДеталей.Форма.ФормаДляТерминалов",ПарамВыбор);
	КонецПроцедуры

	&НаКлиенте
	Процедура РасходныеНаТерминал(Команда)
		ЗначОтб = Новый Структура("ТерминалРасх",Объект.Ссылка);
		ПарамВыбор = Новый Структура("Отбор",ЗначОтб);
		ОткрытьФорму("РегистрНакопления.Используется.Форма.ФормаДляТерминала",ПарамВыбор);
	КонецПроцедуры

#КонецОбласти

#Область НужноПеренести

	&НаСервере
	Функция СрезПоследнихДанныхПоТерминалу(Терминал)
		Отбор = Новый Структура;
		Отбор.Вставить("Терминал", Терминал);
		Данные = РегистрыСведений.ДвижениеТерминалов.ПолучитьПоследнее(ТекущаяДата(),Отбор);
		Возврат Данные;
	КонецФункции

	&НаСервере
	Функция ПолучитьДанныеСРегистра(Терминал);
		Возврат СрезПоследнихДанныхПоТерминалу(Терминал);
	КонецФункции

	&НаСервере
	Функция СрезПоследнихДанныхПоОплАренд(Договор)
		Отбор = Новый Структура;
		Отбор.Вставить("Договор", Договор);
		Данные = РегистрыСведений.РегистрОплатаАренды.ПолучитьПоследнее(ТекущаяДата(),Отбор);
		Возврат Данные;
	КонецФункции

	&НаСервере
	Функция ПолучитьДанныеОбОплАренд(Договор);
		Возврат СрезПоследнихДанныхПоОплАренд(Договор);
	КонецФункции

	//Получаем группу договоров
	&НаСервере
	Функция ПолучитьГруппуДоговор(Договор,ОтноситсяКГруппе)
		возврат СрезПоследнихПолучитьДогорГруппа(Договор,ОтноситсяКГруппе);
	КонецФункции

	&НаСервере
	Функция ПолучитьМетку(Терминал)
		Данные = СрезПоследнихДанныхПоТерминалу(Терминал);
		Возврат Данные.Метка;
	КонецФункции

	//ПолучитьГруппуДоговора
	&НаСервере
	Функция СрезПоследнихПолучитьДогорГруппа(Договор,ОтноситсяКГруппе)
		Отбор = Новый Структура;
		Отбор.Вставить("Договор", Договор);
		Данные = РегистрыСведений.ДействующиеДоговора.ПолучитьПоследнее(ТекущаяДата(),Отбор);
		Возврат Данные.ОтноситсяКГрупе;

	КонецФункции

	&НаСервере
	Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
		Если Объект.Наименование = "" тогда
		Элементы.Кнопка1.Видимость = Ложь;
		Элементы.КомплектующиеНаТермин.Видимость = Ложь;
		Элементы.Группа4.Видимость = Ложь;
		Элементы.КомплектующиеНаТермин.Видимость = Ложь;
		КонецЕсли;
	КонецПроцедуры

	&НаСервереБезКонтекста
	Процедура ПослеЗаписиНаСервере(Терминал, Метка)
		//НДП = Документы.ПеремещениеТерминалов.СоздатьДокумент();
		//НДП.Дата = ТекущаяДата();
		//НДП.ПеремКуда = Терминал.Наименование;
		//НДП.НоваяМетка = Метка;
		//НДП.Записать("Posting");
	КонецПроцедуры

	//Получаю перечисление
	&НаСервере
	Функция ПолучитьПеречислениеФормыДоговораПисьменный()
		Возврат Перечисления.ФормаДоговора.ПисьменнаяФорма;
	КонецФункции

	//Обращаюсь к регистру Сведения о Договорах аренды
	&НаСервере
	функция ПолучитьФормуДоговора(Договор)
		Возврат Договор.ФормаДоговора;	
	КонецФункции

#КонецОбласти