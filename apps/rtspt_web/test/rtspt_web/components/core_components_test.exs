defmodule RtsptWeb.CoreComponentsTest do
  use ExUnit.Case, async: true
  import Phoenix.LiveViewTest
  alias RtsptWeb.CoreComponents

  test "flash renders info message" do
    html = render_component(&CoreComponents.flash/1, kind: :info, flash: %{info: "Hello!"})
    assert html =~ ""
  end

  test "flash renders error message" do
    html = render_component(&CoreComponents.flash/1, kind: :error, flash: %{error: "Oops!"})
    assert html =~ ""
  end

  test "input renders label and input" do
    html = render_component(&CoreComponents.input/1, name: "input-email", field: :email, label: "Email", type: :text, value: "foo@bar.com")
    assert html =~ "Email"
    assert html =~ "foo@bar.com"
    assert html =~ "input"
  end

  test "icon renders svg" do
    html = render_component(&CoreComponents.icon/1, name: "hero-x-mark", class: "w-5 h-5")
    assert html =~ "hero-x-mar"
    assert html =~ "w-5 h-5"
  end
end
