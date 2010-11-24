# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
require "csv"

months = Hash.new
months[:Jan] = 1
months[:Feb] = 2
months[:Mar] = 3
months[:Apr] = 4
months[:May] = 5
months[:Jun] = 6
months[:Jul] = 7
months[:Aug] = 8
months[:Sep] = 9
months[:Oct] = 10
months[:Nov] = 11
months[:Dec] = 12


proj = Project.new
proj.name = "Sew NH26"
proj.location = "Trichy"
proj.save



CSV.open("TDR.csv","rb").each do |row|

  proj =  Projectdetail.new
  d = row[0].split('-')
  dt = DateTime.new(d[1].to_i + 2000,d[0].to_i,1)
  proj.month = dt

  proj.projid = 1

  if row[1].nil? or row[1].empty?
      proj.OriginalBaselinePlan = 0
  else
      proj.OriginalBaselinePlan = row[1]
  end

  if row[2].nil? or row[2].empty?
      proj.LreSite = 0      
  else
      proj.LreSite = row[2]
  end

  if row[3].nil? or row[3].empty?
      proj.LrePmc = 0
  else
      proj.LrePmc = row[3]
  end


  if row[4].nil? or row[4].empty?
      proj.Ac = 0
  else
      proj.Ac = row[4]
  end


  if row[4].nil? or row[4].empty?
      proj.PercentageProgress = 0
  else
      proj.PercentageProgress = (row[5].to_f * 100).to_f
  end


  unless proj.save
    proj.errors.each do |msg|
      puts msg
    end
  end

end

CSV.open("material.csv","rb").each do |row|

  mat = MaterialActual.new

  mat.projid = 1
  mat.name = row[0].to_s
  mat.unit = row[1].to_s
  mat.availableqty = row[2].to_f
  mat.consumptionqty= row[3].to_f

  mat.save

end



CSV.open("machinery.csv","rb").each do |row|

  machinery = Material.new

  machinery.projid = 1

  if row[0].nil? or row[0].empty?
    machinery.assetnumber = ''
  else
    machinery.assetnumber = row[0]
  end

  if row[1].nil? or row[1].empty?
    machinery.description = ''
  else
    machinery.description = row[1]
  end

  if row[2].nil? or row[2].empty?
      machinery.capacity = 0
  else
      machinery.capacity = row[2]
  end

  if row[3].nil? or row[3].empty?
      machinery.ifc = 0
  else
      machinery.ifc = row[3]
  end

  if row[4].nil? or row[4].empty?
      machinery.scheduledhour = 0
  else
      machinery.scheduledhour = row[4]
  end

  if row[5].nil? or row[5].empty?
      machinery.unavailablehour = 0
  else
      machinery.unavailablehour = row[5]
  end

  if row[6].nil? or row[6].empty?
      machinery.utilizedhours = 0
  else
      machinery.utilizedhours = row[6]
  end

  if row[7].nil? or row[7].empty?
      machinery.theoreticaloutput = 0
  else
      machinery.theoreticaloutput = row[7]
  end

  if row[8].nil? or row[8].empty?
      machinery.actualoutput = 0
  else
      machinery.actualoutput = row[8]
  end

  if row[9].nil? or row[9].empty?
      machinery.theoreticalconsumption = 0
  else
      machinery.theoreticalconsumption = row[9]
  end

  if row[10].nil? or row[10].empty?
    machinery.actualconsumption = 0
  else
    machinery.actualconsumption = row[10]
  end

  unless machinery.valid?
    machinery.errors.each do |err|
      puts err
    end
  else
    machinery.save
  end

end

