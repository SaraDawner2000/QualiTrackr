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
require "rails_helper"

RSpec.describe Subcomponent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
