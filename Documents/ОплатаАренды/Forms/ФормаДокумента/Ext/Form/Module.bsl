﻿#Область ПроцедурыФормы

	&НаКлиенте
	Процедура ПриОткрытии(Отказ)
		Если не Объект.Договор.Пустая() тогда
			Терминал = ПолучитьДанныеПоДоговору(Объект.Договор);
		КонецЕсли;
		ДатаПоследнейОплаты = ПолучитьДанныхПоОплатеАренды(Объект.Договор,Объект.Дата).ДатаРегОпл;
		Объект.Дата = ТекущаяДата();
	КонецПроцедуры

#КонецОбласти

#Область ПроцедурыРеквизитовФормы

	&НаКлиенте
	Процедура ТерминалПриИзменении(Элемент)
		Объект.Договор = ПолучитьДанныеПоТерминалу(Терминал,Объект.Дата);
		ДатаПоследнейОплаты = ПолучитьДанныхПоОплатеАренды(Объект.Договор,Объект.Дата).ДатаРегОпл;
	КонецПроцедуры

	&НаКлиенте
	Процедура ДоговорПриИзменении(Элемент)
		Если не Объект.Договор.Пустая() тогда	
			Терминал = ПолучитьДанныеПоДоговору(Объект.Договор);
		КонецЕсли;		
	КонецПроцедуры

#КонецОбласти

#Область НеобходимоПеренести

&НаСервере
Функция ПолучитьДанныхПоОплатеАренды(Договор,Дата)
	Отбор = новый Структура;
	Отбор.Вставить("Договор",Договор);
	Возврат  РегистрыСведений.РегистрОплатаАренды.ПолучитьПоследнее(Дата, Отбор);
КонецФункции
//Функция чтобы скопировать терминал при выборе договора
&НаСервере
Функция ПолучитьДанныеПоДоговору(Договор)
	Запрос = Новый Запрос("ВЫБРАТЬ ПЕРВЫЕ 1
	                      |	СвязиТерминаловИДоговоров.Терминал КАК Терминал
	                      |ИЗ
	                      |	РегистрСведений.СвязиТерминаловИДоговоров КАК СвязиТерминаловИДоговоров
	                      |ГДЕ
	                      |	СвязиТерминаловИДоговоров.Период <= &Период
	                      |	И СвязиТерминаловИДоговоров.ДействущийДоговор = &Договор");
	Запрос.УстановитьПараметр("Период", Договор.Дата);
	Запрос.УстановитьПараметр("Договор", Договор); 
	Список = Новый СписокЗначений;
	Список.ЗагрузитьЗначения(Запрос.Выполнить().Выгрузить().ВыгрузитьКолонку("Терминал"));
	Возврат Список[0].Значение.Ссылка;
КонецФункции

//Функция чтобы скопировать договор при выборе терминала
&НаСервере
Функция ПолучитьДанныеПоТерминалу(Терминал,Дата)
	Отбор = новый Структура;
	Отбор.Вставить("Терминал",Терминал);
	Результат = РегистрыСведений.СвязиТерминаловИДоговоров.ПолучитьПоследнее(Дата,Отбор);
		Возврат  Результат.ДействущийДоговор;
КонецФункции

&НаСервере
функция СкопироватьДоговор(Терминал)
	
	Запрос = Новый Запрос(
"ВЫБРАТЬ
|	ДвижениеТерминаловСрезПоследних.ДоговорАрендРегистр КАК ДоговорАрендРегистр,
|	ДвижениеТерминаловСрезПоследних.Терминал КАК Терминал,
|	ДвижениеТерминаловСрезПоследних.ДоговорАрендРегистр.Стоимость КАК ДоговорАрендРегистрСтоимость
|ИЗ
|	РегистрСведений.ДвижениеТерминалов.СрезПоследних КАК ДвижениеТерминаловСрезПоследних
|ГДЕ
|	ДвижениеТерминаловСрезПоследних.Терминал = &Терминал");

Запрос.УстановитьПараметр("Терминал", Терминал); // Терминал.

РезультатЗапроса = Запрос.Выполнить();
СписокЗначений = новый СписокЗначений;
СписокЗначений.ЗагрузитьЗначения(РезультатЗапроса.Выгрузить().ВыгрузитьКолонку("ДоговорАрендРегистрСтоимость"));

Возврат СписокЗначений;
КонецФункции

#КонецОбласти