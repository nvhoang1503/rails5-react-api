# == Schema Information
#
# Table name: examples
#
#  id         :integer          not null, primary key
#  photo      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Example, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
