# -*- coding: utf-8 -*-

require 'spreadsheet'
#require 'replacement_machine'

class ExportExcel

  def initialize(event_id, type_rashod_id)
=begin
  type_rashod_id = RASHOD_TYPES.select { |k, v| v[:title] == 'Агент (мероприятие)' }.keys.first
  type_rashod_id = RASHOD_TYPES.select { |k, v| v[:title] == 'Агент (лектор)' }.keys.first
=end

    @filter_regexp = /-\(-[^-]+-\)-/
    @replacement_pattern = %w[-(- -)-]

    event = Event.find(event_id)
    company = event.company
    documents = event.documents_beznal_rashods.where(type_rashod: type_rashod_id).order(:dogovor_num) # to load data instantly

    @replacement_machine = ReplacementMachine.new event, company, documents

    @from_xls = "#{Rails.root}/app/export_excels/clear_excels/clear_excel_#{documents.count}.xls"
    #@to_xls = 'excel.xls'
  end

  def create
    book = Spreadsheet.open @from_xls
    sheet = book.worksheet 0

    in_sheet_each_cell_with_index(sheet) do |row, cell, cell_index|
      unless (cell = cell.to_s).blank?
        row[cell_index] = process_cell(cell)
      end
    end

    book
  end

  def in_sheet_each_cell_with_index(sheet)
    sheet.each do |row|
      row.each_with_index do |cell, index|
        yield row, cell, index
      end
    end
  end

  def process_cell(cell)
    cell.scan(@filter_regexp).each do |replace_key|
      replace_value = replacement_tool replace_key.clone
      cell.gsub! replace_key, replace_value
    end
    cell
  end

  def replacement_tool(replace_key)
    filtered_replace_key = filter_replacement_pattern replace_key
    @replacement_machine.replace filtered_replace_key
  end

  def filter_replacement_pattern(replace_key)
    @replacement_pattern.each do |part|
      replace_key.gsub! part, ''
    end
    replace_key
  end

end
