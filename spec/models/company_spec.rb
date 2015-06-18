require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:url) }

    it "should allow valid values for email" do
      should allow_value("dotun@dotunsoga.com", "a@b.co.uk", "eliza+hash@example.com").for(:email)
    end

    describe "should be invalid if email is not formatted correctly" do
      it { should_not allow_value("elizabrock.com").for(:email) }
      it { should_not allow_value("eliza@examplecom").for(:email) }
      it { should_not allow_value("@.com").for(:email) }
    end
    
    it "should have a working factory" do
      Fabricate.build(:company).should be_valid
    end
  end
end
