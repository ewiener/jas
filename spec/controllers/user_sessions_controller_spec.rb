require 'spec_helper'

describe UserSessionsController do
  describe 'Create a user session'
  it 'I create a user session' do
    UserSession.should_receive(:new)
    end
  end
end


