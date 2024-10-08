class PartsController < ApplicationController
  include Cleanable
  before_action :set_part, only: %i[ show edit update destroy remove_drawing]
  before_action :destroy_duds, only: %i[ index ]
  before_action { authorize @part || Part }

  def index
    @part_query = Part.ransack(params[:q])
    @parts = @part_query.result.page(params[:page])
  end

  def remove_drawing
    purge_attachment(@part, :drawing, "drawing")
  end

  def new
    @part = Part.new
  end


  def edit
  end


  def create
    @part = Part.new(part_params)
    respond_to do |format|
      if @part.save
        child_hash = params[:subcomponents]
        if child_hash
          create_children(@part, child_hash)
        end
        format.html { redirect_to new_quality_project_url(part_id: @part.id), notice: "Part was successfully created." }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_children(parent_part, child_hash)
    child_hash.each do |key, child_params|
      delete_empty_params child_params
      permitted_child_params = child_params.permit(:number, :revision, :drawing, :base_material, :finish)

      child_part = Part.new(permitted_child_params)
      if child_part.save
        Subcomponent.create(
          parent_id: parent_part.id,
          child_id: child_part.id
        )
      end
    end
  end


  def update
    child_hash = params[:subcomponents]
    if child_hash
      create_children(@part, child_hash)
    end
    respond_to do |format|
      if @part.update(part_params)
        format.html { redirect_to part_url(@part), notice: "Part was successfully updated." }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @part.destroy

    respond_to do |format|
      format.html { redirect_to parts_url, notice: "Part was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_part
      @part = Part.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def part_params
      part_params = params.require(:part)
      delete_empty_params part_params # ensure that the empty strings submitted by the form are converted to nil
      part_params.permit(:number, :revision, :job, :drawing, :base_material, :finish, :measured_status)
    end

    # destroy top parts that do not have associated quality projects (created if interrupted midway during new project creation)
    def destroy_duds
      Part.top_parts.each do |part|
        unless part.quality_project
          part.children.destroy_all
          part.destroy
        end
      end
    end
end
