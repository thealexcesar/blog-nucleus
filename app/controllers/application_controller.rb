class ApplicationController < ActionController::Base
  enum type: { commun: 0, admin: 1 }
end
