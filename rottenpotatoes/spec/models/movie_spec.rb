require 'rails_helper'

describe Movie do
    
    describe 'find_same_movies' do
        let!(:movie1) {FactoryBot.create(:movie, title: 'Star Wars', rating: 'PG', release_date: '1977-05-25',director: 'George Lucas') }
        let!(:movie2) {FactoryBot.create(:movie, title: 'Blade Runner', rating: 'PG', release_date: '1982-06-25', director: 'Ridley Scott') }
        let!(:movie3) {FactoryBot.create(:movie, title: 'Alien' ,rating: 'R', release_date: '1979-05-25')}
        let!(:movie4) {FactoryBot.create(:movie, title: 'THX-1138', rating: 'R', release_date: '1971-03-11', director: 'George Lucas') }
    
        context 'To test if director exists' do
            it 'finds movies with same director' do
                expect(Movie.same_movies(movie1.title)).to eql(['Star Wars', "THX-1138"])
                expect(Movie.same_movies(movie2.title)).to eql(['Blade Runner'])
            end
        end

        context 'To test if director does not exist' do
            it 'should handles sad path' do
                expect(Movie.same_movies(movie3.title)).to eql(nil)
            end
        end
    end
    describe 'To print all_ratings' do
        it 'should return all ratings' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end
end