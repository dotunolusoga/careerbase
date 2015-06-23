require 'rails_helper'

RSpec.describe Note, type: :model do
  describe "validations" do
    it { should validate_presence_of(:content) }
    it { should validate_length_of(:content).is_at_most(140) }
    it { should validate_presence_of(:user) }

    it "should have a working factory" do
      Fabricate.build(:note).should be_valid
    end
  end
end
