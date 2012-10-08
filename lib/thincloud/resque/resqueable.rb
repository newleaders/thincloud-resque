module Thincloud
  module Resque

    module Resqueable
      extend ActiveSupport::Concern

      module ClassMethods
        def resqueable(options={})
          instance_variable_set :"@queue",
            (options[:queue] || self.new.class.collection.name).to_sym
        end

        def perform(id, method, *args)
          find(id).send(method, *args)
        end
      end

      def async(method, *args)
        Resque.enqueue(self.class, id, method, *args)
      end
    end

  end
end