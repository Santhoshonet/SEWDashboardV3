class Material < ActiveRecord::Base
    belongs_to :project

    validates_presence_of :assetnumber,:description, :capacity,:ifc,:scheduledhour,:unavailablehour,:utilizedhours,:theoreticalconsumption, :actualconsumption,:theoreticaloutput, :actualoutput
    validates_numericality_of :ifc,:scheduledhour,:unavailablehour,:utilizedhours,:theoreticalconsumption, :actualconsumption,:theoreticaloutput, :actualoutput
end
