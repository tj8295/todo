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

  describe "#display_text" do
    # let(:todo) { Todo.create(name: "cook dinner") }
    let(:todo) { Fabricate(:todo) }
    subject { todo.display_text }

    # 0, 1, many, boundry condition   when test deals with numbers
    context "no tags" do
      it { should eq("cook dinner") }
    end

    context "one tag" do
      before { todo.tags.create(name: "tomorrow") }
        it { should eq("cook dinner (tag: tomorrow)") }
    end

    context "multiple tags" do
      before do
        todo.tags.create(name: "tomorrow")
        todo.tags.create(name: "fast")
      end
      it { should eq("cook dinner (tags: tomorrow, fast)") }
    end

    context "more than four tags" do
      before do
        todo.tags.create(name: "tomorrow")
        todo.tags.create(name: "fast")
        todo.tags.create(name: "food")
        todo.tags.create(name: "home")
        todo.tags.create(name: "late")
      end

      it { should eq("cook dinner (tags: tomorrow, fast, food, home, more...)") }
    end
  end
end



