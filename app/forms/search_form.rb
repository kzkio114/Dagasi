class SearchForm
  include ActiveModel::Model

  attr_accessor :keyword

  validates :keyword, presence: true, length: { minimum: 2 }
end