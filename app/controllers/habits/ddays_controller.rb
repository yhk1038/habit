class Habits::DdaysController < ApplicationController
    before_action :valid_session
    # before_action :gatekeeper
    before_action :set_project
    before_action :set_dday, only: [:show, :edit, :update, :destroy]


    # GET /habits/:project_id/ddays
    # GET /habits/:project_id/ddays.json
    def index
        @ddays = @project.ddays
    end

    # GET /habits/:project_id/ddays/1
    # GET /habits/:project_id/ddays/1.json
    def show
    end

    # GET /habits/:project_id/ddays/new
    def new
        @dday = Dday.new
    end

    # GET /habits/:project_id/ddays/1/edit
    def edit
    end

    # POST /habits/:project_id/ddays
    # POST /habits/:project_id/ddays.json
    def create
        @dday = Dday.new(dday_params)

        respond_to do |format|
            if @dday.save
                format.html { redirect_to @dday, notice: 'Dday was successfully created.' }
                format.json { render :show, status: :created, location: @dday }
            else
                format.html { render :new }
                format.json { render json: @dday.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /habits/:project_id/ddays/1
    # PATCH/PUT /habits/:project_id/ddays/1.json
    def update
        respond_to do |format|
            if @dday.update(dday_params)
                format.html { redirect_to @dday, notice: 'Dday was successfully updated.' }
                format.json { render :show, status: :ok, location: @dday }
            else
                format.html { render :edit }
                format.json { render json: @dday.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /habits/:project_id/ddays/1
    # DELETE /habits/:project_id/ddays/1.json
    def destroy
        @dday.destroy
        respond_to do |format|
            format.html { redirect_to ddays_url, notice: 'Dday was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_dday
        @dday = Dday.find(params[:id])
    end

    def set_project
        @project = Project.find(params[:project_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dday_params
        params.require(:dday).permit(:project_id, :day, :success)
    end
end
