module Errors
  class Exit < StandardError
    def initialize(msg: 'Exit game')
      super(msg)
    end
  end
end
