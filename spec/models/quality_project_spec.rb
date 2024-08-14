# == Schema Information
#
# Table name: quality_projects
#
#  id                :bigint           not null, primary key
#  part_id           :bigint           not null
#  customer_request  :string
#  purchase_order    :string
#  report_approval   :boolean
#  record_approval   :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  customer_approval :enum
#  customer          :enum             not null
#
require "rails_helper"

RSpec.describe QualityProject, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
