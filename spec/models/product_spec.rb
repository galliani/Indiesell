require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to have_one_attached   :display_picture  }
  it { is_expected.to have_many_attached  :images           }
  it { is_expected.to have_many_attached  :consumables      }
end
