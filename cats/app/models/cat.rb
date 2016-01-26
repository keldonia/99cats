class Cat < ActiveRecord::Base
  CAT_COLORS = [
    'tabby',
    'black',
    'calico',
    'grey',
    'tortoiseshell',
    'white',
    'blue'
  ]

  validates :color, inclusion: CAT_COLORS, presence: true
  validates :sex, inclusion: ['M', 'F'], presence: true
  validates :birth_date, presence: true
  validates :name, presence: true

  def age
    ((Time.new.to_date - birth_date) / 365).to_i
  end

  def self.colors
    CAT_COLORS
  end
end
