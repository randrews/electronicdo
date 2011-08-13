class PilgrimsController < ApplicationController
  # GET /pilgrims
  # GET /pilgrims.xml
  def index
    @pilgrims = Pilgrim.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pilgrims }
    end
  end

  # GET /pilgrims/1
  # GET /pilgrims/1.xml
  def show
    @pilgrim = Pilgrim.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pilgrim }
    end
  end

  # GET /pilgrims/new
  # GET /pilgrims/new.xml
  def new
    @pilgrim = Pilgrim.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pilgrim }
    end
  end

  # GET /pilgrims/1/edit
  def edit
    @pilgrim = Pilgrim.find(params[:id])
  end

  # POST /pilgrims
  # POST /pilgrims.xml
  def create
    @pilgrim = Pilgrim.new(params[:pilgrim])

    respond_to do |format|
      if @pilgrim.save
        format.html { redirect_to(@pilgrim, :notice => 'Pilgrim was successfully created.') }
        format.xml  { render :xml => @pilgrim, :status => :created, :location => @pilgrim }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pilgrim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pilgrims/1
  # PUT /pilgrims/1.xml
  def update
    @pilgrim = Pilgrim.find(params[:id])

    respond_to do |format|
      if @pilgrim.update_attributes(params[:pilgrim])
        format.html { redirect_to(@pilgrim, :notice => 'Pilgrim was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pilgrim.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pilgrims/1
  # DELETE /pilgrims/1.xml
  def destroy
    @pilgrim = Pilgrim.find(params[:id])
    @pilgrim.destroy

    respond_to do |format|
      format.html { redirect_to(pilgrims_url) }
      format.xml  { head :ok }
    end
  end
end
