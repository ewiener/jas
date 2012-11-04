require 'spec_helper'

describe TeachersController do
  describe 'Create a new teacher', :type => :request do
    it 'When I create a new teacher, it should take me to the teachers page' do
      get :new, {:semester_id => 5}
      response.should redirect_to(teachers_path)
    end
  end


end
