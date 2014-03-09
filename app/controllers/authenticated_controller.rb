class AuthenticatedController < ApplicationController
  before_filter :ensure_sign_in


end
