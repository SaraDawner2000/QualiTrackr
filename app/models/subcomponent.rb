# == Schema Information
#
# Table name: subcomponents
#
#  id         :bigint           not null, primary key
#  parent_id  :bigint           not null
#  child_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Subcomponent < ApplicationRecord
  belongs_to :parent, class_name: "Part"
  belongs_to :child, class_name: "Part"
end
