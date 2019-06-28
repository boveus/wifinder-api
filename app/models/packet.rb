class Packet < ApplicationRecord
  def self.newest
    order('created_at DESC').first
  end
end
