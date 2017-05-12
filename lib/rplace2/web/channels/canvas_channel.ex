defmodule Rplace2.Web.CanvasChannel do
  use Rplace2.Web, :channel

  def join("canvas:1", payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_message", payload, socket) do
    broadcast_from socket, "recv_message", payload
    {:reply, {:ok, %{}}, socket}
  end

  ## Channels can be used in a request/response fashion
  ## by sending replies to requests from the client
  #def handle_in("ping", payload, socket) do
    #{:reply, {:ok, payload}, socket}
  #end

  ## It is also common to receive messages from the client and
  ## broadcast to everyone in the current topic (canvas:lobby).
  #def handle_in("shout", payload, socket) do
    #broadcast socket, "shout", payload
    #{:noreply, socket}
  #end
end
