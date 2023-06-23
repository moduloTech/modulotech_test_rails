# frozen_string_literal: true

RSpec.shared_context 'with authenticated current_user' do
  let(:current_user) { create(:user, email: "admin@admin.com", password: '12342323') }

  before do
    sign_in current_user
  end
end
