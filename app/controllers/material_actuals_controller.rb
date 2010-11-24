class MaterialActualsController < ApplicationController
  # GET /material_actuals
  # GET /material_actuals.xml
  def index
    project_id = session[:project_id]
    unless project_id.nil?
        @material_actuals = MaterialActual.find(:all,:conditions => "projid = #{project_id}")
        @material_actual = MaterialActual.new
    else
       @material_actuals = Array.new
       @material_actual = nil
       session[:project_id] = nil
    end
    @projectlist = Project.find(:all, :order => "name")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @material_actuals }
    end
  end


  # GET /material_actuals/new
  # GET /material_actuals/new.xml
  def new
    @material_actual = MaterialActual.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @material_actual }
    end
  end

  # GET /material_actuals/1/edit
  def edit
    @material_actual = MaterialActual.find(params[:id])
    unless session[:project_id].nil?
      @material_actual.projid = session[:project_id]
    end
  end


  def show
    session[:project_id] = params[:id]
    redirect_to :action => "index"
  end
  

  # POST /material_actuals
  # POST /material_actuals.xml
  def create
    @material_actual = MaterialActual.new(params[:material_actual])
    unless session[:project_id].nil?
      @material_actual.projid = session[:project_id]
    end
    respond_to do |format|
      if @material_actual.save
        format.html { redirect_to(@material_actual, :notice => 'MaterialActual was successfully created.') }
        format.xml  { render :xml => @material_actual, :status => :created, :location => @material_actual }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @material_actual.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /material_actuals/1
  # PUT /material_actuals/1.xml
  def update
    @material_actual = MaterialActual.find(params[:id])
    unless session[:project_id].nil?
      @material_actual.projid = session[:project_id]
    end
    respond_to do |format|
      if @material_actual.update_attributes(params[:material_actual])
        format.html { redirect_to(:action => "index", :notice => 'MaterialActual was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @material_actual.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /material_actuals/1
  # DELETE /material_actuals/1.xml
  def destroy
    @material_actual = MaterialActual.find(params[:id])
    @material_actual.destroy

    respond_to do |format|
      format.html { redirect_to(material_actuals_url) }
      format.xml  { head :ok }
    end
  end
end
