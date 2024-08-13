namespace :slurp do
  desc "Add parts from CSV"
  task parts: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "parts.csv"))
    csv = CSV.parse(csv_text, headers: true, encoding: "ISO-8859-1")
    csv.each do |row|
      # Find or initialize a new part
      part = Part.find_or_initialize_by(id: row["id"].to_i)

      part.number = row["number"]
      part.revision = row["revision"]
      part.job = row["job"]
      part.base_material = row["base_material"]
      part.finish = row["finish"]
      part.measured_status = row["measured_status"] == "TRUE"

      if row["drawing"] == "TRUE"
        part.drawing.attach(
            io: File.open(Rails.root.join("db", "sample_files", "dummy_drawing.pdf")),
            filename: "dummy_drawing.pdf",
            content_type: "application/pdf"
          )
      end
      part.save!
    end
  end
  desc "Add subcomponent relationships from CSV"
  task subcomponents: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "subcomponents.csv"))
    csv = CSV.parse(csv_text, headers: true, encoding: "ISO-8859-1")

    csv.each do |row|
      subcomponent = Subcomponent.new
      subcomponent.parent_id = row["parent_id"].to_i
      subcomponent.child_id = row["child_id"].to_i

      subcomponent.save!
    end
  end
  desc "Add quality projects from CSV"
  task quality_projects: :environment do
    require "csv"

    csv_text = File.read(Rails.root.join("lib", "csvs", "quality_projects.csv"))
    csv = CSV.parse(csv_text, headers: true, encoding: "ISO-8859-1")

    csv.each do |row|
      quality_project = QualityProject.new
      quality_project.customer = row["customer"]
      quality_project.part_id = row["part_id"]
      quality_project.customer_request = row["customer_request"]
      quality_project.purchase_order = row["purchase_order"]

      case row["report_approval"]
      when nil
        quality_project.report_approval = nil
      when "TRUE"
        quality_project.report_approval = true
      when "FALSE"
        quality_project.report_approval = false
      end

      case row["report_approval"]
      when nil
        quality_project.record_approval = nil
      when "TRUE"
        quality_project.record_approval = true
      when "FALSE"
        quality_project.record_approval = false
      end

      if row["inspection_plan"] == "TRUE"
        quality_project.inspection_plan.attach(
                io: File.open(Rails.root.join("db", "sample_files", "dummy_inspection_plan.xlsx")),
                filename: "dummy_inspection_plan.xlsx",
                content_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
              )
      end

      if row["assembled_record"] == "TRUE"
        quality_project.assembled_record.attach(
            io: File.open(Rails.root.join("db", "sample_files", "dummy_assembled_record.pdf")),
            filename: "dummy_assembled_record.pdf",
            content_type: "application/pdf"
          )
      end

      quality_project.save!
    end
  end
end
