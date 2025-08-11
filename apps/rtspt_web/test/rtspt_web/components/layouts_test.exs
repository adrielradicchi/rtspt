defmodule RtsptWeb.LayoutsTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  alias RtsptWeb.Layouts

  test "flash_group renders with id and flash" do
    html = render_component(&Layouts.flash_group/1, flash: %{info: "ok"}, id: "custom-id")
    assert html =~ "custom-id"
  end
end
