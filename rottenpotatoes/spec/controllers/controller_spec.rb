require 'rails_helper'

describe MoviesController do
    
    describe 'Index functionality' do
        
        it 'should render the index template' do
          get :index
          expect(response).to render_template('index')
        end
    end
    
    describe 'New functionality' do
        it 'should render the new template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'Show functionality' do
        
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
end