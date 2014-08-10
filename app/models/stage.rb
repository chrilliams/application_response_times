class Stage < ActiveRecord::Base
  skip_callback :create
end
