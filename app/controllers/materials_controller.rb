class MaterialsController < ApplicationController
  # GET /materials
  # GET /materials.xml
  def index
    project_id = session[:project_id]
    filtercriteria = ''
    unless params[:filtercriteria].nil?
      project_id = 1
      session[:project_id] = "1"
      if params[:filtercriteria].to_s == "Crusher Metso"
        filtercriteria = 'Crusher-Metso'
      elsif params[:filtercriteria].to_s == "Wet Plant"
        filtercriteria = 'Wet Mix'
      else
        filtercriteria = params[:filtercriteria].to_s
      end
    end
    if !project_id.nil?
      unless params[:filtercriteria].nil?
        @materials = Material.find(:all,:conditions => "projid = #{project_id} and description like '%" + filtercriteria + "%'" )
      else
        @materials = Material.find(:all,:conditions => "projid = #{project_id}")
      end
       @material = Material.new
    else
       @materials = Array.new
       @material = nil
       session[:project_id] = nil
    end
    @projectlist = Project.find(:all, :order => "name")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @materials }
    end
  end

  # GET /materials/1/edit
  def edit
    @material = Material.find(params[:id])
    unless session[:project_id].nil?
      @material.projid = session[:project_id]
    end
  end

  def show
    session[:project_id] = params[:id]
    puts  params[:filter]
    redirect_to :action => "index"
  end

  # POST /materials
  # POST /materials.xml
  def create
    @material = Material.new(params[:material])
    unless session[:project_id].nil? 
      @material.projid = session[:project_id]
    end
    respond_to do |format|
      if @material.save
        format.html { redirect_to(@material, :notice => 'Material was successfully created.') }
        format.xml  { render :xml => @material, :status => :created, :location => @material }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /materials/1
  # PUT /materials/1.xml
  def update
    @material = Material.find(params[:id])
    unless session[:project_id].nil?
      @material.projid = session[:project_id]
    end
    respond_to do |format|
      if @material.update_attributes(params[:material])
        format.html { redirect_to(:action => "index" , :notice => 'Material was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /materials/1
  # DELETE /materials/1.xml
  def destroy
    @material = Material.find(params[:id])
    @material.destroy

    respond_to do |format|
      format.html { redirect_to(materials_url) }
      format.xml  { head :ok }
    end
  end
end
