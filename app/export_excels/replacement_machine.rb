# -*- coding: utf-8 -*-
Kernel.load "#{Rails.root}/app/export_excels/replacement_rules.rb"

require 'russian'
require 'configuration'

class ReplacementMachine

  def initialize(event, company, documents)
    @event     = event
    @company   = company
    @documents = documents

    add_string_methods(@documents.count) # TODO need remove methods ?!

    @replacement_rules = Configuration.for 'replacement_machine'
  end

  def replace(replace_key)
    replace_action = key_to_action replace_key
    # p "#{replace_key} -> #{replace_action}"
    eval(replace_action).to_s
  end

  private

    def strftime_if_exist(value)
      if value.is_a?(Date)
        value.strftime("%d.%m.%y")
      else
        ''
      end
    end

    def key_to_action(key)
      #with_string_patching(@documents.count) do
      send_key_parts key.split('.')
      #end
    end

    def send_key_parts(keys_array)
      action_str = @replacement_rules
      keys_array.each do |method|
        action_str = action_str.send method
      end
      raise() unless action_str.is_a?(String) #неполный ключ
      action_str
    rescue => e
      p e
      raise() #невалидный ключ
    end

    def with_string_patching(count)
      add_string_methods(count)
      yield
      remove_string_methods(count)
    end

    def add_string_methods(count)
      count.times do |i|
        String.send(:define_method, "item_#{i}") do
          self.gsub 'document.', "documents[#{i}]."
        end
      end
    end

    def remove_string_methods(count)
      count.times do |i|
        String.send(:remove_method, "item_#{i}")
      end
    end
end
