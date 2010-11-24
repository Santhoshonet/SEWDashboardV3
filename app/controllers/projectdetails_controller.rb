class ProjectdetailsController < ApplicationController
  # GET /projectdetails
  # GET /projectdetails.xml
  def index
    project_id = session[:project_id]
    unless project_id.nil?
        @projectdetails = Projectdetail.find(:all,:order => "month",:conditions => "projid = #{project_id}")
        @projectdetail = Projectdetail.new
        session[:project_id] = project_id
        @currentyear = Time.new.year - 5
    else
        @projectdetails = Array.new
        @projectdetail = nil
        session[:project_id] = nil
    end
    @projectlist = Project.find(:all, :order => "name")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projectdetails }
    end
  end

  # GET /projectdetails/1/edit
  def edit
    @projectdetail = Projectdetail.find(params[:id])
    unless session[:project_id].nil? or session[:project_id].empty?
      @projectdetail.projid = session[:project_id]
    end    
    @currentyear = Time.new.year - 5 
    @month = @projectdetail.month.month
    @year = @projectdetail.month.year
  end

  # POST /projectdetails
  # POST /projectdetails.xml
  def create
    @projectdetail = Projectdetail.new(params[:projectdetail])
    unless session[:project_id].nil? or session[:project_id].empty?
      @projectdetail.projid = session[:project_id]
    end
    @currentyear = Time.new.year - 5
    respond_to do |format|
      if @projectdetail.save
        format.html { redirect_to(projectdetails_path, :notice => 'Projectdetail was successfully created.') }
        format.xml  { render :xml => @projectdetail, :status => :created, :location => @projectdetail }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @projectdetail.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projectdetails/1
  # PUT /projectdetails/1.xml
  def update
    @projectdetail = Projectdetail.find(params[:id])
    unless session[:project_id].nil? or session[:project_id].empty?
      @projectdetail.projid = session[:project_id]
    end
    @currentyear = Time.new.year - 5
    respond_to do |format|
      if @projectdetail.update_attributes(params[:projectdetail])
        format.html { redirect_to(projectdetails_path, :notice => 'Projectdetail was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @projectdetail.errors, :status => :unprocessable_entity }
      end
    end
  end


  def show
    session[:project_id] = params[:id]
    redirect_to :action => "index"
  end

  # DELETE /projectdetails/1
  # DELETE /projectdetails/1.xml
  def destroy
    @projectdetail = Projectdetail.find(params[:id])
     unless session[:project_id].nil? or session[:project_id].empty?
      @projectdetail.projid = session[:project_id]
    end
    @projectdetail.destroy
    respond_to do |format|
      format.html { redirect_to(projectdetails_url) }
      format.xml  { head :ok }
    end
  end
end
