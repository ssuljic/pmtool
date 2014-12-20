class Binary < ActiveRecord::Base
  has_many :uploads
  
  def file_data=(input_data)
    self.data = input_data.read
  end
end