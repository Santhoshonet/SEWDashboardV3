class Project < ActiveRecord::Base
             has_many :projectdetails
             has_many :materials

  validates_presence_of :location, :name
  validates_uniqueness_of :name


end
