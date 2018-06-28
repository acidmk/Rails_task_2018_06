require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "validates name" do
    expect{Tag.create!}.to raise_error(Mongoid::Errors::Validations)
  end
end
