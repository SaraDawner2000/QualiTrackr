# == Schema Information
#
# Table name: parts
#
#  id              :bigint           not null, primary key
#  number          :string           not null
#  revision        :string           not null
#  job             :string
#  base_material   :string
#  finish          :string
#  measured_status :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require "rails_helper"

RSpec.describe Part, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
