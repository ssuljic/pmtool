class Period < ActiveRecord::Base
	belongs_to :meeting
	has_many :user_periods
end
