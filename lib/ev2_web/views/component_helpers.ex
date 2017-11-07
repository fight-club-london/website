defmodule Ev2Web.ComponentHelpers do
  def component(template, assigns \\ []) do
    Ev2Web.ComponentView.render(template, assigns)
  end

  def component(template, assigns, do: block) do
    Ev2Web.ComponentView.render(template, Keyword.merge(assigns, [do: block]))
  end
end
