class DashboardController < ApplicationController

  def index

      @project_details = Projectdetail.find(:all,:order => 'month')

      @contract_budget_confidence = Hash.new
      @contract_reestimate_confidence = Hash.new

      @pv_cummulative = Hash.new
      @lre_site = Hash.new
      @lre_pmc = Hash.new
      @cpi_cummulative = Hash.new
      @spi_cummulative = Hash.new


      @sum_of_all_pv = 0.00
      @sum_of_all_lrepmc = 0.00
      @sum_of_all_procurred_asphault = 0.00
      @sum_of_all_billed_asphault = 0.00
      @sum_of_all_procurred_concrete = 0.00
      @sum_of_all_billed_concrete = 0.00
      @sum_of_all_procurred_hsteel = 0.00
      @sum_of_all_billed_hsteel = 0.00
      @sum_of_all_procurred_rsteel = 0.00
      @sum_of_all_billed_rsteel = 0.00
      @sum_of_all_machine_availability = 0.00
      @sum_of_all_machine_usage = 0.00
      @sum_of_all_manpower_availability = 0.00
      @sum_of_all_manpower_usage = 0.00

      @lre_maximum = 0
      @lre_minimum = 0


      flash[:issuelastmonth] == ''
      flash[:issuelastbeforemonth] == ''

      if @project_details.length > 0
        @lre_minimum = @project_details[0].LrePmc
      end

      # flash values for labels
      flash[:budgetconfidenceIndex] = 0
      flash[:estimateconfidenceIndex] = 0
      flash[:confidencelastmonth] = ""
      flash[:plannedValue] = 0
      flash[:lresite] = 0
      flash[:lrepmc] = 0
      flash[:cpi] = 0
      flash[:spi] = 0

      # For Calculating all the summary values  here
      @project_details.each do |projdetail|
          begin
            unless projdetail.OriginalBaselinePlan.nil? and projdetail.OriginalBaselinePlan.empty?
              @sum_of_all_pv += projdetail.OriginalBaselinePlan
            end
          rescue
          end

          begin
            unless projdetail.LrePmc.nil? and projdetail.empty?
              @sum_of_all_lrepmc += projdetail.LrePmc
              @lre_maximum = @sum_of_all_lrepmc
            end
          rescue
          end
      end


    # Actual Calculation goes here
    @sum_of_cum_pv =0.00
    @sum_of_cum_actualcost = 0.00
    @sum_of_cum_ev = 0.00
    @sum_of_cum_ev1 = 0.00
    @sum_of_cum_lresite = 0.00
    @sum_of_cum_lrepmc = 0.00

    @previous_pv_cum = 0.00
    @previous_lre_site_cum = 0.00
    @previous_lre_pmc_cum = 0.00

    @startmonth = 0
    @startyear = 0
    @endmonth = 0
    @endyear = 0

    if flash[:fromMonth].nil?

      @startmonth = 1;
    else
      @startmonth = flash[:fromMonth].to_i;
    end

    if flash[:fromYear].nil?
      @startyear = 2005;
    else
      @startyear = flash[:fromYear].to_i;
    end


    if flash[:toMonth].nil?
      @endmonth = DateTime.now.month;
    else
      @endmonth = flash[:toMonth].to_i;
    end

    if flash[:toYear].nil?
      @endyear = DateTime.now.year;
    else
      @endyear = flash[:toYear].to_i;
    end

    if flash[:filter].nil?
        flash[:filter] = false      
    end
      
    @project_details.each_with_index do |projdetail,index|

      projmonth = projdetail.month.month;
      projyear = projdetail.month.year;
      # Section of Calculating the basic cummulative values
      begin
          if !projdetail.OriginalBaselinePlan .nil? and !projdetail.PercentageProgress.nil? and !projdetail.Ac.nil?
              @sum_of_cum_pv += projdetail.OriginalBaselinePlan
              result =  @sum_of_cum_pv.to_d * (projdetail.PercentageProgress.to_s.to_d / 100)
              @sum_of_cum_ev = result
              @sum_of_cum_actualcost += projdetail.Ac
          end
          unless projdetail.LreSite.nil?
            @sum_of_cum_lresite += projdetail.LreSite
          end
          unless projdetail.LrePmc.nil?
            @sum_of_cum_lrepmc += projdetail.LrePmc
          end
        @sum_of_cum_ev1 = (@sum_of_cum_lresite * projdetail.PercentageProgress.to_d / 100) 
      rescue Exception => exc
        puts "Error at generating values for basic cummulative values due to  " + exc.message
      end

      flag = false;
      if projyear >= @startyear and projyear <= @endyear
        if projyear == @endyear
          if projmonth < @endmonth
            flag = true
          end
        elsif projyear == @startyear
          if projmonth >= @startmonth
            flag = true
          end
        else
          flag = true
        end
      end

      # For Graph 1 [Contract budget confidence & Contract re-estimate confidence]
      begin
          cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
          if cpi.nan? or cpi.infinite?
            cpi = 0
          end
          # for contract_budget_confidence
          cbci = (@sum_of_all_pv - @sum_of_cum_ev) / (@sum_of_all_pv - @sum_of_cum_actualcost)
          cbci = cpi / cbci
          cbci = (cbci - 1) * 10
          if cbci.nan? or cbci.infinite?
            cbci = 0
          end
          # for contract_reestimate_confidence
          crci = ( ( (cpi) / ( (@sum_of_all_pv - @sum_of_cum_ev1) / ( @sum_of_all_lrepmc - @sum_of_cum_actualcost) ) ) - 1 ) * 10
          if crci.nan? or crci.infinite?
            crci = 0
          end

          if flag == true
            if !@contract_budget_confidence.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @contract_budget_confidence[projdetail.month.strftime("%Y-%b-1")] = cbci
                @contract_reestimate_confidence[projdetail.month.strftime("%Y-%b-1")] = crci
            end
          end

          begin
              currentmonth = Time.new.month
              currentyear = Time.new.year
              if (projdetail.month.month < currentmonth  and currentyear == projdetail.month.year) or (projdetail.month.year < currentyear )
                flash[:budgetconfidenceIndex] = cbci.to_f.round(2);
                flash[:estimateconfidenceIndex] = crci.to_f.round(2);
                flash[:confidencelastmonth] = projdetail.month.strftime("%b - %Y")
              end
          rescue
          end

       rescue Exception => exc
          puts "Error at generating values for @contract_budget_confidence due to " + exc.message
       end


      # For Graph 2 [Estimate Confidence] [LRE Site & LRE PMC]
      begin
          #if flag == true
            if !@pv_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                if @previous_pv_cum != @sum_of_cum_pv
                  @pv_cummulative[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_pv
                  @previous_pv_cum = @sum_of_cum_pv
                end
            end
            if !@lre_site.has_key?(projdetail.month.strftime("%Y-%b-1"))
                if @previous_lre_site_cum != @sum_of_cum_lresite
                  @lre_site[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lresite
                  @previous_lre_site_cum = @sum_of_cum_lresite
                end
            end
            if !@lre_pmc.has_key?(projdetail.month.strftime("%Y-%b-1"))
                if @previous_lre_pmc_cum != @sum_of_cum_lrepmc
                  @lre_pmc[projdetail.month.strftime("%Y-%b-1")] = @sum_of_cum_lrepmc
                  @previous_lre_pmc_cum = @sum_of_cum_lrepmc
                end
            end
          #end

          begin
              currentmonth = Time.new.month
              currentyear = Time.new.year
              #if (projdetail.month.month < currentmonth  and currentyear == projdetail.month.year) or (projdetail.month.year < currentyear )
                flash[:plannedValue] =  @sum_of_cum_pv.round(2)
                flash[:lresite] = @sum_of_cum_lresite.round(2)
                flash[:lrepmc] = @sum_of_cum_lrepmc.round(2) 
              #end
          rescue
          end
      rescue Exception => exc
          puts "Error at generating values for Estimate Confidence due to " + exc.message
      end


      # For Graph 3 [Cost vs Schedule]
      begin
        cpi = (@sum_of_cum_ev / @sum_of_cum_actualcost)
        spi = (@sum_of_cum_ev / @sum_of_cum_pv)
        if flag == true
          if cpi.nan? or cpi.infinite?
            cpi = 0
          end
          if spi.nan? or spi.infinite?
            spi = 0
          end
          if !@cpi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @cpi_cummulative[projdetail.month.strftime("%Y-%b-1")] = cpi
          end
          if !@spi_cummulative.has_key?(projdetail.month.strftime("%Y-%b-1"))
                @spi_cummulative[projdetail.month.strftime("%Y-%b-1")] = spi
          end
        end

        begin
          currentmonth = Time.new.month
          currentyear = Time.new.year
          if (projdetail.month.month < currentmonth  and currentyear == projdetail.month.year) or (projdetail.month.year < currentyear )
            flash[:cpi] = cpi.round(2)
            flash[:spi] = spi.round(2)
          end
       rescue
       end

      rescue Exception => exc
          puts "Error at generating values for Cost Vs Schedule due to " + exc.message
      end


    end



    flash[:lre_maximum] = @lre_maximum
    flash[:lre_minimum] = @lre_minimum


    # for contract_budget_confidence
    flash[:contract_budget_confidence] = ''
    @contract_budget_confidence.each_with_index do |cbc,index|
        if index < @contract_budget_confidence.length
          flash[:contract_budget_confidence] += "#{cbc[0]},#{cbc[1]}"
          if index < @contract_budget_confidence.length
            flash[:contract_budget_confidence] += '#'
          end
        end
    end


    # for contract_reestimate_confidence
    flash[:contract_reestimate_confidence] = ''
    @contract_reestimate_confidence.each_with_index do |crc,index|
        if index < @contract_reestimate_confidence.length
          flash[:contract_reestimate_confidence] += "#{crc[0]},#{crc[1]}"
          if index < @contract_reestimate_confidence.length
            flash[:contract_reestimate_confidence] += '#'
          end
        end
    end


    # for pv cummulative
    flash[:pv_cummulative] = ''
    @pv_cummulative.each_with_index do |crc,index|
        flash[:pv_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @pv_cummulative.length
          flash[:pv_cummulative] += '#'
        end
    end


    # for lresite cummulative
    flash[:lresite_cummulative] = ''
    @lre_site.each_with_index do |crc,index|
        flash[:lresite_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @lre_site.length
          flash[:lresite_cummulative] += '#'
        end
    end


    # for lrepmc cummulative
    flash[:lrepmc_cummulative] = ''
    @lre_pmc.each_with_index do |crc,index|
        flash[:lrepmc_cummulative] += "#{crc[0]},#{crc[1]}"
        if index < @lre_pmc.length
          flash[:lrepmc_cummulative] += '#'
        end
    end


    # for cpi cummulative
    flash[:cpi_cummulative] = ''
    @cpi_cummulative.each_with_index do |crc,index|
        if index < @cpi_cummulative.length
          flash[:cpi_cummulative] += "#{crc[0]},#{crc[1]}"
          if index < @cpi_cummulative.length
            flash[:cpi_cummulative] += '#'
          end
        end
    end
    # for spi cummulative
    flash[:spi_cummulative] = ''
    @spi_cummulative.each_with_index do |crc,index|
        if index < @spi_cummulative.length
          flash[:spi_cummulative] += "#{crc[0]},#{crc[1]}"
          if index < @spi_cummulative.length
            flash[:spi_cummulative] += '#'
          end

        end
    end

  end

  def filter

    flash[:fromMonth] = params["FromMonth"].to_s
    flash[:fromYear] =  params["FromYear"].to_s
    flash[:toMonth] = params["ToMonth"].to_s
    flash[:toYear] =  params["ToYear"].to_s    
    flash[:filter] = true
    redirect_to  :controller => "dashboard", :action => "index"
    
  end

  def resource

    flash[:filter] = false
    flash[:issuelastbeforemonth] = ''
    flash[:donuttitle_outer] = ''
    flash[:issuelastmonth] = ''
    flash[:donuttitle_inner] = ''
    flash[:issuelast2monthsback] = ''
    flash[:donuttitle_outer_most] = ''    

    @project_details = Projectdetail.find(:all,:order => 'month')

    currentmonth = DateTime.now.month;
    currentyear = DateTime.now.year;

    @project_details.each do |projdetail|

      projmonth = projdetail.month.month;
      projyear = projdetail.month.year;

       # For Issues Analysis
      begin
          if projyear == currentyear
            if projmonth == currentmonth - 1
              # yes it is lastmonth

              extiss = 0
              if !projdetail.ExternalIssues.nil?
                extiss = projdetail.ExternalIssues
              end

              if extiss != 0
                intiss = 0
                if !projdetail.InternalIssues.nil?
                  intiss = projdetail.InternalIssues
                end
                if intiss == 0
                  intiss = 0.1
                  extiss = 99.9                  
                end
              else
                intiss = 99.9
                extiss = 0.1
              end

              flash[:issuelastmonth] = "External Issues," + extiss.to_s + "#Internal Issues," + intiss.to_s
              flash[:donuttitle_outer_most] = projdetail.month.strftime('%b-%Y')
            elsif projmonth == currentmonth - 2
              # yes it is before to last month
              extiss = 0
              if !projdetail.ExternalIssues.nil?
                extiss = projdetail.ExternalIssues
              end

              if extiss != 0
                intiss = 0
                if !projdetail.InternalIssues.nil?
                  intiss = projdetail.InternalIssues
                end
                if intiss == 0
                  intiss = 0.1
                  extiss = 99.9
                end
              else
                intiss = 99.9
                extiss = 0.1
              end

              flash[:issuelastbeforemonth] = "External Issues," + extiss.to_s + "#Internal Issues," + intiss.to_s
              flash[:donuttitle_outer] = projdetail.month.strftime('%b-%Y')
            elsif projmonth == currentmonth - 3
              # yes it is last 2 months back
              extiss = 0
              if !projdetail.ExternalIssues.nil?
                extiss = projdetail.ExternalIssues
              end

              if extiss != 0
                intiss = 0
                if !projdetail.InternalIssues.nil?
                  intiss = projdetail.InternalIssues
                end
                if intiss == 0
                  intiss = 0.1
                  extiss = 99.9
                end
              else
                intiss = 99.9
                extiss = 0.1
              end
              flash[:issuelast2monthsback] = "External Issues," + extiss.to_s + "#Internal Issues," + intiss.to_s
              flash[:donuttitle_inner] = projdetail.month.strftime('%b-%Y')
            end
          end
      rescue Exception => exc
        puts "Error at generating values for Issue Analysis due to " + exc.message
      end

    end

    if flash[:issuelastmonth] == ''
        flash[:issuelastmonth] = "External Issues,0#Internal Issues,0"
    end

    if flash[:issuelastbeforemonth] == ''
        flash[:issuelastbeforemonth] == "External Issues,0#Internal Issues,0"
    end

    if flash[:issuelast2monthsback] == ''
      flash[:issuelastbeforemonth] == "External Issues,0#Internal Issues,0"  
    end


    material_actuals = MaterialActual.find(:all, :conditions => "projid = 1")

    flash[:hsteel_cummulative] = 0
    flash[:concrete_cummulative] = 0
    flash[:asphault_cummulative] = 0
    flash[:rsteel_cummulative] = 0

    begin
      if material_actuals.count() > 0
          material_actual = material_actuals[0]
          flash[:hsteel_cummulative] = ((material_actual.consumptionqty.to_f / material_actual.availableqty.to_f) * 10).round(2)
      end
    rescue
    end

    begin
      if material_actuals.count()  > 1
        material_actual = material_actuals[1]
        flash[:concrete_cummulative] =  ((material_actual.consumptionqty.to_f / material_actual.availableqty.to_f) * 10).round(2)
      end
    rescue
    end

    begin
      if material_actuals.count()  > 2
        material_actual = material_actuals[2]
        flash[:asphault_cummulative] = ((material_actual.consumptionqty.to_f / material_actual.availableqty.to_f) * 10).round(2)
      end
    rescue
    end

    begin
      if material_actuals.count()  > 3
        material_actual = material_actuals[3]
        flash[:rsteel_cummulative] = ((material_actual.consumptionqty.to_f / material_actual.availableqty.to_f) * 10).round(2)
      end
    rescue
    end

    @materials = Material.find(:all, :order => "id")


    @batchplant_count = 0
    @batchplant_prod_eff_sum = 0.0
    @batchplant_asset_eff_sum = 0.0

    @crushermetso_count = 0
    @crushermetso_prod_eff_sum = 0.0
    @crushermetso_asset_eff_sum = 0.0

    @motmixplant_count = 0
    @motmixplant_prod_eff_sum = 0.0
    @motmixplant_asset_eff_sum = 0.0

    @wetplant_count = 0
    @wetplant_prod_eff_sum = 0.0
    @wetplant_asset_eff_sum = 0.0

    @kerblaying_count = 0
    @kerblaying_prod_eff_sum = 0.0
    @kerblaying_asset_eff_sum = 0.0


    @materials.each do |material|
        if material.description.include?("Batching Plant")
          @batchplant_count += 1
          if material.theoreticaloutput.to_i != 0
            @batchplant_prod_eff_sum += (material.actualoutput / material.theoreticaloutput) * 100
          end
          if material.utilizedhours.to_i != 0
            @batchplant_asset_eff_sum += ( material.utilizedhours / (material.scheduledhour - material.unavailablehour) ) * 100
          end
        end

        if material.description.include?("Crusher-Metso")
          @crushermetso_count += 1
          if material.theoreticaloutput.to_i != 0
            @crushermetso_prod_eff_sum += (material.actualoutput / material.theoreticaloutput) * 100
          end
          if material.utilizedhours.to_i != 0
            @crushermetso_asset_eff_sum += ( material.utilizedhours / (material.scheduledhour - material.unavailablehour)) * 100
          end
        end

        if material.description.include?("HotMix Plant")
          @motmixplant_count += 1
          if material.theoreticaloutput.to_i != 0
            @motmixplant_prod_eff_sum += (material.actualoutput / material.theoreticaloutput) * 100
          end
          if material.utilizedhours.to_i != 0
            @motmixplant_asset_eff_sum += ( material.utilizedhours / (material.scheduledhour - material.unavailablehour)) * 100
          end
        end

        if material.description.include?("Wet Mix")
          @wetplant_count += 1
          if material.theoreticaloutput.to_i != 0
            @wetplant_prod_eff_sum += (material.actualoutput / material.theoreticaloutput) * 100
          end
          if material.utilizedhours.to_i != 0
            @wetplant_asset_eff_sum += ( material.utilizedhours / (material.scheduledhour - material.unavailablehour)) * 100
          end
        end

        if material.description.include?("Kerb Laying")
          @kerblaying_count += 1
          if material.theoreticaloutput.to_i != 0
            @kerblaying_prod_eff_sum += (material.actualoutput / material.theoreticaloutput) * 100
          end
          if material.utilizedhours.to_i != 0
            @kerblaying_asset_eff_sum += ( material.utilizedhours / (material.scheduledhour - material.unavailablehour)) * 100
          end
        end
    end


    flash[:batchflant_prod_eff] = (@batchplant_prod_eff_sum / @batchplant_count).round(2)
    flash[:batchflant_asset_eff] = (@batchplant_asset_eff_sum / @batchplant_count).round(2)

    flash[:crushermetso_prod_eff_sum] = (@crushermetso_prod_eff_sum / @crushermetso_count).round(2)
    flash[:crushermetso_asset_eff_sum] = (@crushermetso_asset_eff_sum / @crushermetso_count).round(2)

    flash[:motmixplant_prod_eff_sum] = (@motmixplant_prod_eff_sum / @motmixplant_count).round(2)
    flash[:motmixplant_asset_eff_sum] = (@motmixplant_asset_eff_sum / @motmixplant_count).round(2)

    flash[:wetplant_prod_eff_sum] = (@wetplant_prod_eff_sum / @wetplant_count).round(2)
    flash[:wetplant_asset_eff_sum] = (@wetplant_asset_eff_sum / @wetplant_count).round(2)

    flash[:kerblaying_prod_eff_sum] = (@kerblaying_prod_eff_sum / @kerblaying_count).round(2)
    flash[:kerblaying_asset_eff_sum] = (@kerblaying_asset_eff_sum / @kerblaying_count).round(2)

    flash[:productionEfficiency] = flash[:batchflant_prod_eff].to_s + ",1#" + flash[:crushermetso_prod_eff_sum].to_s + ",2#" + flash[:motmixplant_prod_eff_sum].to_s + ",3#" + flash[:wetplant_prod_eff_sum].to_s + ",4#" + flash[:kerblaying_prod_eff_sum].to_s + ",5"        
    flash[:assetEfficiency] = flash[:batchflant_asset_eff].to_s + ",1#" + flash[:crushermetso_asset_eff_sum].to_s + ",2#" + flash[:motmixplant_asset_eff_sum].to_s + ",3#" + flash[:wetplant_asset_eff_sum].to_s + ",4#" + flash[:kerblaying_asset_eff_sum].to_s + ",5"
=begin
    puts flash[:productionEfficiency]
    puts flash[:assetEfficiency]
    puts @batchplant_count
    puts @crushermetso_count
    puts @motmixplant_count
    puts @wetplant_count
    puts @kerblaying_count
=end

  end
  
end
