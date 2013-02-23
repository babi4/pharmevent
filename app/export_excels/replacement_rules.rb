# -*- coding: utf-8 -*-

Configuration.for('replacement_machine') {

  event {
    name '@event.name'
    city '@event.city'

    date {
      end_day   '@event.date_end.day'
      end_month 'Russian::strftime(@event.date_end, \'%b\')'
      end_year  '@event.date_end.strftime(\'%Y\')'
      range     '@event.date_range_str'
    }
  }

  company {
    name            '@company.name'
    ur_full_address '"Юридический адрес: #{@company.ur_full_address}"'
    telephone       '"Тел. #{@company.telephone}"'
    email           '"E-mail: #{@company.email}"'
    inn             '"ИНН #{@company.inn}"'
    kpp             '"КПП #{@company.kpp}"'
    ogrn            '"ОГРН #{@company.ogrn}"'
    bank_account    '"Р/с № #{@company.bank_account} в"'
    bank_name       '@company.bank_name'
    bank_city       '"г. #{@company.bank_city}"'
    bank_corr_account '"к/с #{@company.bank_corr_account}"'
    bank_bik        '"БИК #{@company.bank_bik}"'
    ispolnitel      '@company.ispolnitel'
    osnovanie_ispolnitel '@company.osnovanie_ispolnitel'
  }

  document {
    company     '@document.company'
    description '@document.description'
    num_pp      '@document.info_pp'
    schet          '"Счет № #{@document.num_schet}. #{strftime_if_exist(@document.date_schet)}"'
    schet_factura  '"Счет фактура № #{@document.info_schet_factura}. #{strftime_if_exist(@document.info_date_schet)}"'
    info_act       '"Акт № #{@document.info_act}. #{strftime_if_exist(@document.info_date_act)}"'
    dogovor        '"Договор № #{@document.dogovor_num}. #{strftime_if_exist(@document.dogovor_date)}"'
    summ  '"#{@document.summ}р."'
    nds   '"#{@document.nds}р."'
  }

  documents {
    summ '"#{@documents.map(&:summ).reduce(:+)} р."'
    nds  '"#{@documents.map(&:nds).reduce(:+)} р."'
  }

  today {
    day   'Time.now.to_date.day'
    month 'Russian::strftime(Time.now.to_date, \'%b\')'
    year  'Time.now.to_date.strftime(\'%Y\')'
  }
}
