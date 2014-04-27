module Moonrope
  module Errors
    
    class Error < StandardError
    end
    
    class RequestError < Error
      attr_reader :options
      
      def initialize(options)
        @options = options
      end
      
      def data
        {:message => @options}
      end
    end
    
    class AccessDenied < RequestError
      def status
        'access-denied'
      end
    end
    
    class NotFound < RequestError
      def status
        'not-found'
      end
    end
    
    class ValidationError < RequestError
      def status
        'validation-error'
      end
      
      def data
        {:errors => @options}
      end
    end
    
    class ParameterError < RequestError
      def status
        'parameter-error'
      end
      
      def data
        {:errors => @options}
      end
    end
    
  end
end