# -*- coding: utf-8 -*-

# Тут ад.
# И не спрашивайте меня, как это работает.
# Сам наверняка уже не помню.

class DocumentsAggregator

  def initialize(ability)
    # Права. Кто к чему имеет доступ
    @ability = ability
    # Пишем сюда, если надо добавить вызываемый метод к документам
    @additional_scope = nil
    # Hash - который далее отправится в модели документов
    @search_params = {}
    # Просто перечислим все
    @all_doc_types = %w[documents_beznal_rashod documents_beznal_schet documents_nal_rashod documents_nal_prihod]
    # Те типы, что будем использовать
    @use_doc_types = %w[documents_beznal_rashod documents_beznal_schet documents_nal_rashod documents_nal_prihod]
    # Тот тип, что приходит к нам из контроллера
    @doc_type = nil
  end

  def add_doc_method(method)
    # Пишем сюда обычно uncompleted или completed или ничего или что-то еще
    @additional_scope = method
    self
  end

  def in_document_type(type)
    # Запоминаем тип, который от нас требуют
    @doc_type = type
    real_types = []

    # Далее - всякие махинации по преобразованию Типа из поля в реальный тип
    if type
      case type
        when 'all'
          real_types = @all_doc_types
        when 'company_consumption'
          real_types = %w[documents_beznal_rashod documents_nal_rashod]
          @search_params[:company_consumption] = true
        else
          # Проверяем на отсутствие херни
          real_types = [type] if @all_doc_types.include?(type)
      end
    end

    # Запоминаем есть есть что. Если нечего - получай все документы.
    @use_doc_types = real_types if real_types.any?
    self
  end

  def add_search(search_params)
    # Складываем присланные параметры и всякие другие параметры от разных правил
    @search_params.merge! search_params
    self
  end

  def prepend_rules
    # Преобразуем Тип из поля ввода в метод, который дальше скоупом в документах выдаст что надо
    if @doc_type == 'all'
      case @search_params['state']
        when 'completed'
          add_doc_method :completed
          @search_params['state'] = ''
        when 'new'
          add_doc_method :uncompleted
          @search_params['state'] = ''
      end
    end

    if @search_params['only_uncompleted'] == 'true'
      add_doc_method :for_closing
      @search_params['state'] = ''
    end
  end

  def group_by_events
    # Добавим всякие исключения
    prepend_rules

    # Создадим псевдо Евенты. Они абсолютно как настоящие, но документы там уже подгружены, да еще и в соответствии с правами на чтение!!
    pseudo_events = Event.accessible_by(@ability).map { |t| PseudoEvent.new(t.attributes) }
    # Добавим Несуществующий евент -> Расходы компании с id=0
    pseudo_events << PseudoEvent.company_event

    pseudo_event_ids = []

    # Пробежимся по типам, заданным ранее
    @use_doc_types.each do |doc_name|
      # Тип есть - а что за модель?
      docs_model = doc_name.camelize.constantize
      # Сразу поищем если надо.
      docs_model = docs_model.search(@search_params.symbolize_keys)  if @search_params && @search_params.any?

      # Добавим фильтр по правам доступа
      docs_in_event_id = docs_model.
          accessible_by(@ability).
          where(event_id: pseudo_events.map(&:id) )

      # Добавим методов, которые ранее завались по требованию
      docs_in_event_id = docs_in_event_id.send(@additional_scope) if @additional_scope
      # Небольшой фикс от N+1
      docs_in_event_id = docs_in_event_id.includes(:company)      if doc_name == 'documents_beznal_schet'
      # ЭЭЭээ Нам надо не просто документы - а документы по евентам. Групируем.
      docs_by_event_id = docs_in_event_id.group_by { |t| t[:event_id] }

      docs_by_event_id.each do |event_id, docs|
        # А тут делаем так, чтобы, прося у наших псевдо-евентов документы, мы и в правду получали документы, полученные ранее из базы.
        pseudo_event = pseudo_events.find { |t| t.id == event_id }
        pseudo_event.send "#{doc_name}s=", docs
        # И ещё - запишем, что данные евент "в деле"
        pseudo_event_ids << event_id
      end
    end

    # Назер те евенты, что не "в деле"
    pseudo_events.delete_if do |ps_event|
      !pseudo_event_ids.include? ps_event.id
    end

    # Вот, получите, евенты с документами.
    pseudo_events
  end

end
