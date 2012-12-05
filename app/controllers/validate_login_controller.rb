#This a shim controller that is used to automatically filter out any user that is not logged in on any controller that requires a logged in user
#Simply inherit from this controller if the controller requires a logged in user
class ValidateLoginController < ApplicationController

end
