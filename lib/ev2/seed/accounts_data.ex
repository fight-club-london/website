defmodule Ev2.Seed.AccountsData do
  @moduledoc """
    This file stores default seed data that should be loaded into every build
    regardless of environment.

    ## Warning this data can not be edited or deleted. Only added to.
    When the need for editing data arrives, we need to re-write the
    seed helper functions in `Ev2.Seed.Accounts`
  """

  @doc """
  Seed permissions.
  This structure should probably change to an array of strings but
  this was the quickest way for now.
  """
  def permissions() do
     %{
      can_hard_delete_all: "can_hard_delete_all",
      can_manage_company:  "can_manage_company",
      can_create_vehicle:  "can_create_vehicle",
      can_create_project:  "can_create_project",
      can_edit_project:  "can_edit_project",
      can_view_roles_project:  "can_view_roles_project",
      can_manage_roles_project:  "can_manage_roles_project",
      can_view_approvers_project:  "can_view_approvers_project",
      can_manage_approvers_project:  "can_manage_approvers_project",
      can_view_offer:  "can_view_offer",
      can_create_offer:  "can_create_offer",
      can_send_offer:  "can_send_offer",
      can_receive_offer: "can_receive_offer"
    }
  end

  @doc """
  Use this helper to ensure the permission exists
  it will raise error if it doesn't
  """
  defp p(permission) do
    Map.fetch!(permissions(), permission)
  end

  def roles() do
    %{
      super_admin: [
        p(:can_hard_delete_all),
        p(:can_edit_project),
        p(:can_view_roles_project),
        p(:can_manage_roles_project),
        p(:can_view_approvers_project),
        p(:can_manage_approvers_project),
        p(:can_view_offer)
        ],
      company_admin: [
        p(:can_manage_company),
        p(:can_create_vehicle),
        p(:can_edit_project),
        p(:can_view_roles_project),
        p(:can_manage_roles_project),
        p(:can_view_approvers_project),
        p(:can_manage_approvers_project),
        p(:can_create_offer),
        p(:can_view_offer),
        p(:can_send_offer)
        ],
      production_controller: [
        p(:can_view_roles_project),
        p(:can_manage_roles_project),
        p(:can_view_approvers_project),
        p(:can_manage_approvers_project),
        p(:can_create_offer),
        p(:can_view_offer),
        p(:can_send_offer)
        ],
      production_admin: [
        p(:can_edit_project),
        p(:can_view_roles_project),
        p(:can_view_approvers_project),
        p(:can_manage_approvers_project),
        p(:can_create_offer),
        p(:can_view_offer)
        ],
      department_controller: [
        p(:can_create_offer),
        p(:can_view_offer),
        p(:can_send_offer)
        ],
      department_admin: [
        p(:can_create_offer),
        p(:can_view_offer)
        ],
      accounts_controller: [
        p(:can_view_roles_project),
        p(:can_view_approvers_project),
        p(:can_view_offer)
        ],
      accounts_admin: [
        p(:can_view_roles_project),
        p(:can_view_approvers_project),
        p(:can_view_offer)
        ],
      crew_member: [
        p(:can_receive_offer)
      ]
    }
  end

end
