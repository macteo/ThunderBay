class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :app

  enum type: {region: 'region', purchase: 'purchase', other: 'other'}
  enum subtype: {nothing: 'nothing', enter: 'enter', exit: 'exit', range: 'range'}

  # To be able to use type as parameter
  self.inheritance_column = :_type_disabled

end
