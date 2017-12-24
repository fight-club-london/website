defmodule LfcWeb.ComponentHelpers do
  @moduledoc """
  Provides helper functions for rendering HTML components
  """

  alias LfcWeb.ComponentView

  def component(template, assigns \\ []) do
    ComponentView.render(template, assigns)
  end

  # Used for rendering nested components (unused so far)
  # def component(template, assigns, do: block) do
  #   ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  # end
end
