class Sump < ApplicationRecord
  belongs_to :sensor, inverse_of: :sump
end
