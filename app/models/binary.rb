class Binary < ActiveRecord::Base
  has_many :uploads
  
  def file_data=(input_data)
    self.data = input_data.read
    puts input_data.read
    puts input_data.tempfile.read
    puts input_data
    puts IO.binread(input_data.tempfile.path)
    puts input_data.tempfile.size
  end
end