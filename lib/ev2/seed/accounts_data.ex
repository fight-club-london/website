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
      CAN_HARD_DELETE_ALL: "CAN_HARD_DELETE_ALL",
      CAN_MANAGE_COMPANY:  "CAN_MANAGE_COMPANY",
      CAN_CREATE_VEHICLE:  "CAN_CREATE_VEHICLE",
      CAN_CREATE_PROJECT:  "CAN_CREATE_PROJECT",
      CAN_EDIT_PROJECT:  "CAN_EDIT_PROJECT",
      CAN_VIEW_ROLES_PROJECT:  "CAN_VIEW_ROLES_PROJECT",
      CAN_MANAGE_ROLES_PROJECT:  "CAN_MANAGE_ROLES_PROJECT",
      CAN_VIEW_APPROVERS_PROJECT:  "CAN_VIEW_APPROVERS_PROJECT",
      CAN_MANAGE_APPROVERS_PROJECT:  "CAN_MANAGE_APPROVERS_PROJECT",
      CAN_VIEW_OFFER:  "CAN_VIEW_OFFER",
      CAN_CREATE_OFFER:  "CAN_CREATE_OFFER",
      CAN_SEND_OFFER:  "CAN_SEND_OFFER",
      CAN_RECEIVE_OFFER: "CAN_RECEIVE_OFFER"
    }
  end

  @doc """
  Use this helper to ensure the permission exists
  it will raise error if it doesn't
  """
  defp p(permission) do
    Map.fetch!(permissions(), permission)
  end


  @doc """
  Do not edit or delete as it will result in duplicates.
  If you need to edit/delete, then re-write `Ev2.Seed.Accounts`
  inserting functions
  """
  def roles() do
    %{
      SUPER_ADMIN: [
        p(:CAN_HARD_DELETE_ALL),
        p(:CAN_EDIT_PROJECT),
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_MANAGE_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_MANAGE_APPROVERS_PROJECT),
        p(:CAN_VIEW_OFFER)
        ],
      COMPANY_ADMIN: [
        p(:CAN_MANAGE_COMPANY),
        p(:CAN_CREATE_VEHICLE),
        p(:CAN_EDIT_PROJECT),
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_MANAGE_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_MANAGE_APPROVERS_PROJECT),
        p(:CAN_CREATE_OFFER),
        p(:CAN_VIEW_OFFER),
        p(:CAN_SEND_OFFER)
        ],
      PRODUCTION_CONTROLLER: [
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_MANAGE_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_MANAGE_APPROVERS_PROJECT),
        p(:CAN_CREATE_OFFER),
        p(:CAN_VIEW_OFFER),
        p(:CAN_SEND_OFFER)
        ],
      PRODUCTION_ADMIN: [
        p(:CAN_EDIT_PROJECT),
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_MANAGE_APPROVERS_PROJECT),
        p(:CAN_CREATE_OFFER),
        p(:CAN_VIEW_OFFER)
        ],
      DEPARTMENT_CONTROLLER: [
        p(:CAN_CREATE_OFFER),
        p(:CAN_VIEW_OFFER),
        p(:CAN_SEND_OFFER)
        ],
      DEPARTMENT_ADMIN: [
        p(:CAN_CREATE_OFFER),
        p(:CAN_VIEW_OFFER)
        ],
      ACCOUNTS_CONTROLLER: [
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_VIEW_OFFER)
        ],
      ACCOUNTS_ADMIN: [
        p(:CAN_VIEW_ROLES_PROJECT),
        p(:CAN_VIEW_APPROVERS_PROJECT),
        p(:CAN_VIEW_OFFER)
        ],
      CREW_MEMBER: [
        p(:CAN_RECEIVE_OFFER)
      ]
    }
  end

end
