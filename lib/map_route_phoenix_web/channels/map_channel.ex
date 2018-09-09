defmodule MapRoutePhoenixWeb.MapChannel do
  use MapRoutePhoenixWeb, :channel
  alias MapRoutePhoenix.Presence

  def join("map:route", _, socket) do
    send self(), :after_join
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    Presence.track(socket, socket.assigns.user, %{
      online_at: :os.system_time(:milli_seconds)
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end
end
