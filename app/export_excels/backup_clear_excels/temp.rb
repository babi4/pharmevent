from_xls = "#{Rails.root}/app/export_excels/clear_excels/clear_excel_2.xls"
from_book = Spreadsheet.open from_xls  ; nil
from_sheet = from_book.worksheet 0 ; nil

rows_1 = (9..12).map { |i| from_sheet.row(i) }
rows_2 = (26..27).map { |i| from_sheet.row(i) }

(21..40).each do |index|
  to_xls = "#{Rails.root}/app/export_excels/clear_excels/clear_excel_#{index}.xls"
  to_book = Spreadsheet.open to_xls  ; nil
  to_sheet = to_book.worksheet 0 ; nil

  (9..12).each_with_index do |row_num, i|
    to_array = []
    rows_1[i].each do |from_cell|
      to_array <<
        if from_cell
          from_cell.gsub ',2,', ",#{index},"
        else
          nil
        end
    end
    to_sheet.row(row_num).replace to_array
  end

  row_2_start = 18+4*index

  (row_2_start..row_2_start+1).each_with_index do |row_num, i|
    to_array = []
    rows_2[i].each do |from_cell|
      to_array <<
        if from_cell
          from_cell.gsub ',2,', ",#{index},"
        else
          nil
        end
    end
    to_sheet.row(row_num).replace to_array
  end

  to_book.write "#{Rails.root}/app/export_excels/clear_excels/clear_#{index}.xls"
end
