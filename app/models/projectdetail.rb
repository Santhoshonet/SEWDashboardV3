class Projectdetail < ActiveRecord::Base
                          belongs_to :project

  validates_presence_of :month, :OriginalBaselinePlan , :LreSite, :LrePmc, :Ac, :PercentageProgress
  validates_numericality_of :OriginalBaselinePlan , :LreSite, :LrePmc, :Ac, :PercentageProgress

end
