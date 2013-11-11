require 'spec_helper'

describe Admin::ArticlesController do
  login_admin

  let(:journal) { create(:journal) }
  let(:person) { create(:person) }
  let(:article) { create(:article) }

  describe "GET 'index'" do

    before :each do
      get "index"
    end

    it "returns http success" do
      response.should be_success
    end

    it "returns all articles" do
      articles = assigns(:articles)
      articles.should_not be_nil
    end

    it "renders the index view" do
      response.should render_template "index"
    end
  end

  context "as a nested resource" do

    describe "get #new" do

      before :each do
        get "new", person_id: person
      end

      it "returns http success" do
        response.should be_success
      end

      it "creates a blank resource" do
        article = assigns(:article)
        article.new_record?.should eq(true)
      end
    end


    describe "get #edit" do

      before :each do
        get "edit", person_id: person, id: article
      end

      it "returns http success" do
        response.should be_success
      end

      it "gets an article by the supplied id" do
        article = assigns(:article)
        article.new_record?.should eq(false)
      end
    end

    describe "put #update" do

      before :each do
        put :update, person_id: person, id: article, article: {title: "Hott Dogs"}
      end

      it "finds record to update" do
        article = assigns(:article)
        article.should_not be_nil
      end

      it "updates the record" do
        article = assigns(:article)
        article.title.should eq("Hott Dogs")
      end

      it "populates the flash with a success message" do
        flash[:notice].should_not be_nil
      end

      it "redirects to the index on successful update" do
        response.should redirect_to admin_articles_path
      end
    end

    context "new record" do
      describe "post #create" do

        context "success" do

          before :each do
            post :create, person_id: person,
              journal: {
                title: journal.title
              },
              article: {
                title: "Society of the Spectacle",
                date_published: "1969-07-26",
                pages: "12-120"
              },
              authors_articles_attributes: {
                person_id: person.id
              }
          end

          it "creates a new article record" do
            article = assigns(:article)
            article.should be_valid
          end

          it "populates the flash with a success notice" do
            flash[:notice].should_not be_nil
          end

          it "redirects to the articles index" do
            response.should redirect_to admin_articles_path
          end

        end

        context "failure" do

          before :each do
            post :create, person_id: person, article: {}
          end

          it "returns errors" do
            article = assigns(:article)
            article.errors.should_not be_nil
          end

          it "renders the new page" do
            response.should render_template "new"
          end

        end

      end
    end
  end

  describe "delete #destroy" do
    it "removes the record" do
      article = create(:article, title: "Argumentative Debates")
      lambda do
        delete :destroy, id: article
      end.should(change(Article, :count).by(-1))
    end

    it "redirects to the articles index" do
      delete :destroy, id: article
      response.should redirect_to admin_articles_path
    end 
  end
end

