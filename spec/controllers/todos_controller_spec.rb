require 'spec_helper'

describe TodosController do
  describe "GET index" do
    it "sets the @todos variable" do
      cook = Todo.create(name: "cook", description: "cooking")
      sleep = Todo.create(name: "sleep", description: "sleeping")

      get :index
      assigns(:todos).should == [cook, sleep]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET new" do
    it "sets the @todo variable" do
      get :new
      assigns(:todo).should be_instance_of(Todo)
    end
    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe "POST create" do
    it "creates the @todo variable from params on valid input" do
      post :create, todo => { name: "ok", description: "all" }
    end

    it "redirects to the root path on valud input" do
    end
    it
  end
end
