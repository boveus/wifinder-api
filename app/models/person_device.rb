class PersonDevice < ApplicationRecord
  belongs_to :person
  belongs_to :device
end
