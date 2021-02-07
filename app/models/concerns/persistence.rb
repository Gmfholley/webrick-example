# frozen_string_literal: true

require 'csv'

# Common concern to add persistance
module Persistence
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def find(id)
      new(attributes_for(id))
    end

    def count
      table.size
    end

    def tablename
      "db/#{self.name}.csv"
    end

    def attributes_for(id)
      # Not sure why this loop is needed
      attrs = record_from_store(id)
      while attrs.is_a?(String)
        attrs = JSON.parse(attrs)
      end
      attrs.transform_keys(&:to_sym)
    rescue TypeError
      {}
    end
  end

  def save
    @id = next_id if id.nil?
    save_attrs
  end

  def attrs
    instance_variables.map { |ivar| [ivar.to_s.gsub('@', ''), instance_variable_get(ivar)] }.to_h
  end

  def to_json
    JSON.generate(attrs)
  end

  private

  def save_attrs
    save_to_store(id, to_json)
  end
end
