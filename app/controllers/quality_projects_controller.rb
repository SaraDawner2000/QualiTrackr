class QualityProjectsController < ApplicationController
  include Cleanable

  before_action :set_quality_project, only: %i[ show edit update destroy remove_assembled_record remove_inspection_plan]
  before_action { authorize @quality_project || QualityProject }
  # GET /quality_projects or /quality_projects.json
  def index
    @quality_project_query = QualityProject.ransack(params[:q])

    if params.dig(:quality_project_query, :report_approval_eq) == "nil"
      @quality_projects = QualityProject.where(report_approval: nil)
    elsif params.dig(:quality_project_query, :record_approval_eq) == "nil"
      @quality_projects = QualityProject.where(record_approval: nil)
    else
      @quality_projects = @quality_project_query.result
    end
    @quality_projects = @quality_projects.page(params[:page])
  end

  # GET /quality_projects/1 or /quality_projects/1.json
  def show
  end

  # GET /quality_projects/new
  def new
    @quality_project = QualityProject.new
    @part_id = params[:part_id]
  end

  # GET /quality_projects/1/edit
  def edit
  end

  # POST /quality_projects or /quality_projects.json
  def create
    @quality_project = QualityProject.new(quality_project_params)

    respond_to do |format|
      if @quality_project.save
        format.html { redirect_to quality_project_url(@quality_project), notice: "Quality project was successfully created." }
        format.json { render :show, status: :created, location: @quality_project }
      else
        @part_id = @quality_project.part_id
        format.html { render :new, locals: { part_id: @part_id }, status: :unprocessable_entity }
        format.json { render json: @quality_project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quality_projects/1 or /quality_projects/1.json
  def update
    respond_to do |format|
      if @quality_project.update(quality_project_params)
        set_customer_approval @quality_project
        format.html { redirect_to quality_project_url(@quality_project), notice: "Quality project was successfully updated." }
        format.json { render :show, status: :ok, location: @quality_project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quality_project.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_customer_approval(quality_project)
    if quality_project.record_approval
      quality_project.customer_approval = "ready"
      quality_project.save
    end
  end

  # DELETE /quality_projects/1 or /quality_projects/1.json
  def destroy
    @quality_project.destroy

    respond_to do |format|
      format.html { redirect_to quality_projects_url, notice: "Quality project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_inspection_plan
    purge_attachment(@quality_project, :inspection_plan, "inspection plan")
  end

  def remove_assembled_record
    purge_attachment(@quality_project, :assembled_record, "assembled record")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quality_project
      @quality_project = QualityProject.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quality_project_params
      quality_project_params = params.require(:quality_project)
      delete_empty_params quality_project_params
      quality_project_params.permit(:part_id, :customer, :customer_request, :purchase_order, :inspection_plan, :report_approval, :assembled_record, :record_approval, :customer_approval)
    end
end
