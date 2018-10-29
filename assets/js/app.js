import "phoenix_html"
import {Socket, Presence} from "phoenix"

let user = document.getElementById("user").innerText
let socket = new Socket("/socket", {params: {user: user}})
socket.connect()

let presences = {}

let formatedTimestamp = (TS) => {
  let date = new Date(TS)
  return date.toLocaleDateString()
}

let listBy = (user, {metas: metas}) => {
  return {
    user: user,
    onlineAt: formatedTimestamp(metas[0].online_at)
  }
}

let userList = document.getElementById("userList")

let render = (presences) => {
  userList.innerHTML = Presence.list(presences, listBy)
    .map(presence =>
      `<li>
        ${presence.user}
        <br>
        <small>online since ${presence.onlineAt}</small>
      </li>`)
      .join("")
}

let map = socket.channel("map:route", {})
map.on("presence_state", state => {
  presences = Presence.syncState(presences, state)
  render(presences)
})

map.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff)
  render(presences)
})

map.join()

let messageInput = document.getElementById("newMessage")
messageInput.addEventListener("keypress", (e) => {
  if (e.keyCode == 13 && messageInput.value != "") {
    map.push("message:new", messageInput.value)
    messageInput.value = ""
  }
})

let messageList = document.getElementById("messageList")
let renderMessage = (message) => {
  let messageElement = document.createElement("li")
  messageElement.innerHTML = `
    <b>${message.user}</b>
    <i>${formatedTimestamp(message.timestamp)} from ${message.location}</i>
    <p>${message.body}</p>
    `

  messageList.appendChild(messageElement)
  messageList.scrollTop = messageList.scrollHeight;
}

map.on("message:new", message => renderMessage(message))
