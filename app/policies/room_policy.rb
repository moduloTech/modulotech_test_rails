class RoomPolicy < ApplicationPolicy

  class Scope < Scope

    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end

  end

  def show?
    true
  end

  def user_rooms?
    true
  end

  def destroy?
    record.user == user
  end

  def create?
    record.user == user
  end

end
