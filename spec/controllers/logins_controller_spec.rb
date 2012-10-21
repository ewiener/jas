require 'spec_helper'

describe LoginsController do
  describe 'Logging in to the page with a admin username' do
    it 'When I go to the login page, the textboxes should be blank' do
    end

    it 'When I fill in "Username" with "admin" and "Password" with "admin_password" and I click "Login", it should bring me to the "Jefferson PTA - Sessions" home page and I should see a "Create New Session" link' do
    end

  end

  describe 'Logging in to the page with a PTA instructor username' do
    it 'When I fill in "Username" with "pta_instructor" and "Password" with "pta_password" and I click "Login", it should bring me to the "Jefferson PTA - Sessions" home page without a "Create New Session" link' do
    end
  end


  describe 'Logging in to the page without proper password' do
    it 'When I am at the login page, I fill in "Username" with "admin" and "Password" with "random" and I click "Login", it should bring me back to the login page' do
    end

  end

