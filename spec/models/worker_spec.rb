require 'rails_helper'

RSpec.describe Worker, type: :model do
  describe 'validations' do
    it 'is invalid without a name' do
      worker = Worker.new(name: nil)
      expect(worker).not_to be_valid
    end
  end

  describe 'associations' do
    it 'has many shifts' do
      association = described_class.reflect_on_association(:shifts)
      expect(association.macro).to eq :has_many
    end
  end

  describe 'creating a worker' do
    it 'is valid with valid attributes' do
      worker = Worker.new(name: 'John Doe')
      expect(worker).to be_valid
    end
  end
end
