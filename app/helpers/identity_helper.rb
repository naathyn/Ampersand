module IdentityHelper
  def identified?(current_view)
    controller = controller_name.singularize.downcase
    identity = current_view.class.name.downcase
    controller == identity
  end
end
