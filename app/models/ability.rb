# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :view, CardCollection, is_public: true

    if user.present?
      if user.is_admin
        # Grant all permissions to admin
        can :manage, :all
      end

      # Users can manage their own collections
      can :manage, CardCollection, user_id: user.id
    end
  end
end
