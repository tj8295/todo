require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if description is nil" do
      shopping = Todo.create(name: "shopping")
      shopping.name_only?.should be_true
      # expect(shopping.name_only?).to be_true
    end

    it "returns false if has description and no name" do
      shopping = Todo.create(description: "shopping")
      expect(shopping.name_only?).to be_false
    end
    it "returns false if both name and description not nil" do
      shopping = Todo.create(description: "shopping")
      expect(shopping.name_only?).to be_false
    end

    it "returns true if description empty string" do
      shopping = Todo.create(description: "")
      expect(shopping.name_only?).to be_true
    end

  end
end
