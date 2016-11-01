require 'rails_helper'

RSpec.describe Content, type: :model do
  it {should validate_presence_of(:href)}
end
