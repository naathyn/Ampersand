module PrivateMessagesHelper
  class ActiveRecord::Relation
    def clean?
      size == 0
    end
  end

  class ActiveRecord::AssociationRelation
    def clean?
      size == 0
    end
  end
end
