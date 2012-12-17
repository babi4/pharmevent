# -*- coding: utf-8 -*-

puts 'CREATING ROLES'
%w(general_director admin administrative_director chief_accountant manager).each { |t| Role.create().update_attribute(:name, t) }

puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :first_name => 'First', :last_name => 'User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
puts 'New user created: ' << user.name
user.roles << Role.find_by_name(:admin)

Client.create!(
  {
    birthday: Time.now - 21.years,
    degree: 'д.м.н.',
    name:   'Иван Помидоров',
    notes:  'хороший человек',
    passport_number: '123456',
    position: 'начальник',
    work: 'ООО НаноПилюля',
    zagran_passport_number: '654321',
    zagran_passport_use_before: Time.now + 1.year
  }
)

Client.create!(
  {
    birthday: Time.now - 12.years,
    degree: 'к.м.н.',
    name:   'Помидор Иванов',
    notes:  'плохой человек',
    passport_number: '123456',
    position: 'рабочий',
    work: 'ООО МегаПилюля',
    zagran_passport_number: '654321',
    zagran_passport_use_before: Time.now + 21.days
  }
)

company1 = Company.create!(
  {
    name: 'Лечим и Калечим',
    ur_zip_code: 123123,
    ur_city: 'Москва',
    ur_street: 'Первая',
    ur_hous: '1'
  }
)

company2 = Company.create!(
  {
    name: 'Бабушкины травки',
    ur_zip_code: 123123,
    ur_city: 'Москва',
    ur_street: 'Вторая',
    ur_hous: '25'
  }
)

company1.company_members.create!(
  {
    name: 'Иван Радужный',
    email: 'aaa@mail.ru',
    position: 'менеджер',
    telephone: '12345412'
  }
)

company1.company_members.create!(
  {
    name: 'Вячеслав Баранов',
    email: 'vvv@mail.ru',
    position: 'директор',
    telephone: '12345412'
  }
)

event1 = company1.events.create!(
  {
    city: 'Бердск',
    date_end: Time.now + 5.days,
    date_start: Time.now - 5.days,
    name: 'Конференция: Электрический ток - вымысел или реальность?',
    state: 'Новосибирская область',
    user_id: user[:id]
  }
)

event1.documents_nal_prihods.create!(
  {
    company: 'ЗАО Слесари и Слесарки',
    date: Time.now - 1.day,
    description: 'взнос за участие',
    name: 'Егор Безпалов',
    summ: 2000,
    telephone: '123123213',
    user_id: user[:id]
  }
)

event1.documents_nal_rashods.create!(
  {
    company: 'МастерГруз',
    date: Time.now,
    description: 'доставка людей',
    name: 'Егор Дверной',
    summ: 5000,
    telephone: '1231231213',
    lectors: true,
    entire: false,
    user_id: user[:id]
  }
)

event1.documents_beznal_rashods.create!(
  {
    company: 'Козипупкина',
    type_company: 'ИП',
    description: 'питание',
    name: 'Томара Козипупкина',
    summ: 11000,
    telephone: '1231231213',
    lectors: false,
    entire: true,
    user_id: user[:id],
    num_schet: 432,
    date_schet: Time.now - 1.day,
    nds: 1000
  }
)

event1.documents_beznal_schets.create!(
  {
    company_id: company2[:id],
    description: 'рекламное место',
    name: 'Игора Правая',
    summ: 15000,
    nds: 1300,
    telephone: '1231231213',
    user_id: user[:id],
    num_schet: 41,
    date_schet: Time.now - 1.day,
  }
)


