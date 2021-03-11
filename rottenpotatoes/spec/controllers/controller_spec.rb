require 'rails_helper'

describe MoviesController do
    
    ## Stubbing the Views
    describe 'GET Index functionality' do
        
        it 'should render the index template' do
          get :index
          expect(response).to render_template('index')
        end
    end
    
    describe 'GET New functionality' do
        it 'should render the new template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'GET Show functionality' do
        
        let!(:movie) {FactoryBot.create(:movie)}
        before(:each) do
          get :show, id: movie.id
        end

        it 'should find the movie' do
          expect(assigns(:movie)).to eql(movie)
        end

        it 'should render the show template' do
          expect(response).to render_template('show')
        end
    end
    describe 'GET Edit functionality' do
        let!(:movie) {FactoryBot.create(:movie) }
        before do
          get :edit, id: movie.id
        end
        it 'should render the edit template' do
          expect(response).to render_template('edit')
        end
    end
    
    describe 'PUT Update functionality' do
        let!(:movie) {FactoryBot.create(:movie)}
        
        before(:each) do
          put :update, id: movie.id, movie: FactoryBot.attributes_for(:movie, title: 'Modified') ## Returns a hash
        end
    
        it 'updates an existing movie' do
          movie.reload
          expect(movie.title).to eql('Modified')
        end
    
        it 'redirects to the movie page' do
          expect(response).to redirect_to(movie_path(movie))
        end
    end
    
    describe "Search functionality" do
      it "should call Movie.same_movies" do
        expect(Movie).to receive(:same_movies).with('Star Wars')
        get :search, { title: 'Star Wars' }
      end
      
      it "should return movies with same director" do
        movies = ["Star Wars", "THX-1138"]
        expect(Movie).to receive(:same_movies).with('Star Wars').and_return(movies)
        get :search, { title: 'Star Wars' }
        expect(assigns(:same_movies)).to eql(movies)
      end
      
      it "should give flash notice" do
        expect(Movie).to receive(:same_movies).with('Alien').and_return(nil)
        get :search, {title: 'Alien'}
        expect(response).to redirect_to(movies_path)
        expect(flash[:alert])
      end
    end
    
    describe "POST create functionality" do
        let!(:movie) {FactoryBot.create(:movie) }
        before do
          post :create, movie: FactoryBot.attributes_for(:movie)
        end
        it "should redirect to home page" do
          expect(response).to redirect_to(movies_path)
          expect(flash[:alert])
        end
      
    end
end