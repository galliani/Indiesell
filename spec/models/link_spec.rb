require 'rails_helper'

RSpec.describe Link, type: :model do
  it { is_expected.to belong_to :purchase }
end
