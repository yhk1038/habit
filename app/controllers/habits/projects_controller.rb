class Habits::ProjectsController < ApplicationController
    before_action :login_first
    # before_action :gatekeeper
    before_action :set_project, only: [:show, :edit, :update, :destroy]

    # GET /habits
    # GET /habits.json
    def index
        @projects = current_user.projects
    end

    # GET /habits/1
    # GET /habits/1.json
    def show
    end

    # GET /habits/new
    def new
        @project = Project.new
    end

    # GET /habits/1/edit
    def edit
    end

    # POST /habits
    # POST /habits.json
    def create
        @project = Project.new(project_params)

        respond_to do |format|
            if @project.save
                format.html { redirect_to @project, notice: 'Project was successfully created.' }
                format.json { render :show, status: :created, location: @project }
            else
                format.html { render :new }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /habits/1
    # PATCH/PUT /habits/1.json
    def update
        respond_to do |format|
            if @project.update(project_params)
                format.html { redirect_to @project, notice: 'Project was successfully updated.' }
                format.json { render :show, status: :ok, location: @project }
            else
                format.html { render :edit }
                format.json { render json: @project.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /habits/1
    # DELETE /habits/1.json
    def destroy
        @project.destroy
        respond_to do |format|
            format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
            format.json { return render json: {status: :ok, path: projects_url} }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
        @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
        params.require(:project).permit(:user_id, :title, :description, :success)
    end
end
