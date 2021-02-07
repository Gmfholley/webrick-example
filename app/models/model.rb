# frozen_string_literal: true

require 'csv'
require_relative 'concerns/persistence'

require 'json'

class Model
  include Persistence

  def self.filename
    tablename
  end

  def self.table
    read_from_store
  end

  def self.read_from_store
    IO.readlines(filename)
  end

  def self.record_from_store(id)
    read_from_store[id - 1]
  end

  def next_id
    self.class.count + 1
  end

  def save_to_store(id, content)
    all_contents = self.class.read_from_store
    all_contents[id - 1] = "#{content}\n"

    File.open(self.class.filename, 'wb') { |file| file.write(all_contents.join) }
  end
end
