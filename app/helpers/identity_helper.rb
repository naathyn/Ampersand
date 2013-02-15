module IdentityHelper
  def identified?(anObject)
    controller = controller_name.singularize.downcase
    identity = anObject.class.name.downcase
    controller == identity
  end
end
