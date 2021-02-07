# frozen_string_literal: true

require_relative 'model'

class Word < Model
  attr_accessor :name

  def initialize(name: nil)
    @name = name
  end

  def self.random
    id = rand(1..count)
    find(id)
  end

  def matches?(letter)
    name.include? letter
  end

  # Overwrite this method
  def to_json
    name
  end

  # Overwrite this method
  def self.attributes_for(id)
    { name: record_from_store(id).chomp }
  end
end
