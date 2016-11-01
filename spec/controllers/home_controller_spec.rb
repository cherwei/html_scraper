require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET #show' do
    it 'should assign paginated Content' do
      mock = Kaminari.paginate_array([double(Content)]).page(nil)
      expect(Content).to receive(:page).with(nil).and_return(mock)
      get :show
      expect(assigns[:contents]).to eq(mock)
    end
  end
end
