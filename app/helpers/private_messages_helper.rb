module PrivateMessagesHelper
  module ActiveRecord
    class Relation
      def clean?
        size == 0
      end
    end
  end
end
