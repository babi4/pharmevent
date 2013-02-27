# -*- coding: utf-8 -*-

require 'spreadsheet'
#require 'replacement_machine'

class ExportExcel

  def initialize(event_id, type_rashod_id)
    @filter_regexp = /-\(-[^-]+-\)-/
    @replacement_pattern = %w[-(- -)-]

    @prefilter_regexp = /\[[^\[]+-\(-[^\[]+-\)-[^\[]+\]/

    event = Event.find(event_id)
    company = event.company
    documents = event.documents_beznal_rashods.where(type_rashod: type_rashod_id).order(:dogovor_num) # to load data instantly

    @replacement_machine = ReplacementMachine.new event, company, documents

    @from_xls = "#{Rails.root}/app/export_excels/clear_excels/clear_#{documents.count}.xls"
  end

  def create
    book = Spreadsheet.open @from_xls
    sheet = book.worksheet 0

    prefilter_all_data sheet
    replace_all_data sheet

    book
  end

  def prefilter_all_data(sheet)
    in_sheet_each_cell_with_index(sheet) do |row, row_index, cell, cell_index|
      unless (cell = cell.to_s).blank?
        cell.scan(@prefilter_regexp).each do |prefilter_object|
          prefilter_object.gsub! /\[|\]/, ''
          prefilter_options = prefilter_object.split ','
          prefilter_options += [sheet, row_index, cell_index]
          self.send *prefilter_options
        end
      end
    end
  end

  def repeat_cell(text_to_repeat, repeats_count, repeat_step, sheet, row_index, cell_index)
    repeat_step   = repeat_step.to_i
    repeats_count = repeats_count.to_i

    repeats_count.times do |repeat_index|
      text = text_to_repeat.gsub 'NUM', repeat_index.to_s
      sheet[row_index+repeat_index*repeat_step, cell_index] = text
    end
  end

  def replace_all_data(sheet)
    in_sheet_each_cell_with_index(sheet) do |row, row_index, cell, cell_index|
      unless (cell = cell.to_s).blank?
        old_content = cell.clone
        new_content = process_cell(cell)
        row[cell_index] = new_content if old_content.to_s != new_content.to_s
      end
    end
  end

  def in_sheet_each_cell_with_index(sheet)
    sheet.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        yield row, row_index, cell, cell_index
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
