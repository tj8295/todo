require 'spec_helper'

describe TodosController do

  before { set_current_user }

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

    it_behaves_like "require_sign_in" do
      let(:action) { get :index }
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

    it_behaves_like "require_sign_in" do
      let(:action) { get :new }
    end
  end

  describe "POST create" do
    it "creates the @todo variable from params on valid input" do
      post :create, todo: { name: "cook", description: "I like cooking" }
      Todo.first.name.should == "cook"
      Todo.first.description.should == "I like cooking"
    end

    it "redirects to the root path on valud input" do
      post :create, todo: { name: "cook", description: "I like cooking" }
      response.should redirect_to root_path
    end

    it "does not create a new record in the db with invalid input" do
      post :create, todo: { description: "I like cooking" }
      Todo.count.should == 0
    end

    it "renders :new template on invlaid input" do
      post :create, todo: { description: "I like cooking" }
      response.should render_template :new
    end

    it "can create tags without inline locations" do
      post :create, todo: { name: "cook" }
      Tag.count.should == 0
    end

    it "does not create tags from tags with at in a word" do
      post :create, todo: { name: "eat an apple" }
      Tag.count.should == 0
    end

    it "creates a tag with upcase AT" do
      post :create, todo: { name: "Shop AT the Apple Store" }
      Tag.all.map(&:name).should == ['location:the Apple Store']
    end

    context "email sending" do
      it "sends out the email" do
       post :create, todo: { name: "Shop AT the Apple Store" }
       ActionMailer::Base.deliveries.should_not be_empty
      end

      it "sends to the right recipient" do
        john = Fabricate(:user)
        set_current_user(john)
       post :create, todo: { name: "Shop AT the Apple Store" }
        message = ActionMailer::Base.deliveries.last
        message.to.should == [john.email]
      end

      it "has the right content" do
       post :create, todo: { name: "Shop AT the Apple Store" }
        message = ActionMailer::Base.deliveries.last
        message.body.should include("Shop AT the Apple Store")
      end
    end

    context "with inline locations" do
      it "creates a tag with one location" do
        post :create, todo: { name: "cook AT  home" }
        Tag.all.map(&:name).should == ['location:home']
      end

      it "creates two tags with two locations" do
        post :create, todo: { name: "cook AT  home and work" }
        Tag.all.map(&:name).should == ['location:home', 'location:work']
      end

      it "creates multiple tags with four locations" do
        post :create, todo: { name: "cook AT  home, work, school and library" }
        Tag.all.map(&:name).should == ['location:home', 'location:work', 'location:school', 'location:library']
      end

    it_behaves_like "require_sign_in" do
      let(:action) { post :create, todo: { name: "cook AT  home, work, school and library" } }
    end


    end
  end
end
