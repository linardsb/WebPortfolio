# Fix for Rails 5.2 + Ruby 3.1+ compatibility with ActionDispatch::Static
# Ruby 3.1+ changed how keyword arguments are handled, causing issues with the
# Static middleware initialization

module ActionDispatch
  class Static
    def initialize(app, path, *args, index: 'index', headers: {}, **kwargs)
      @app = app
      @file_handler = FileHandler.new(path, index: index, headers: headers)
    end
  end
end
