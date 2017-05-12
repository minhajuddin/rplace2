// socket setup
import {Socket} from "phoenix"
let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("canvas:1", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
// end of socket setup

let canvas = document.getElementById('canvas'),
  ctx = canvas.getContext('2d'),
  currentLine = [];

let eventToPoint = e => ({x: e.pageX - canvas.offsetLeft, y: e.pageY - canvas.offsetTop });
let startLine = e => {
  currentLine = [];
  ctx.beginPath();
  let {x, y} = eventToPoint(e);
  ctx.moveTo(x, y)
  canvas.addEventListener('mousemove', paintLine);
};

let paintLine = e => {
  let point = eventToPoint(e),
    {x, y} = point;
  ctx.lineTo(x, y);
  ctx.stroke();
  currentLine.push(point);
}

let endLine = e => {
  if (currentLine.length == 0) return;
  canvas.removeEventListener('mousemove', paintLine);
  channel.push("new_message", {line: currentLine});
  currentLine = [];
}

canvas.addEventListener('mousedown', startLine);
document.addEventListener('mouseup', endLine);

canvas.width = 500;
canvas.height = 500;
ctx.strokeStyle = 'lime';
ctx.lineWidth = 3;

ctx.beginPath();
ctx.moveTo(10, 10);
ctx.lineTo(40, 40);
ctx.lineTo(10, 40);
ctx.lineTo(40, 10);
ctx.lineTo(10, 10);
ctx.stroke();

let drawLine = line => {
  let {x, y} = line[0];

  ctx.beginPath();
  ctx.moveTo(x, y);
  line.forEach((point) => {
    let {x, y} = point;
    ctx.lineTo(x, y);
    ctx.stroke();
  })
}

channel.on("recv_message", msg => {
  console.log("recv_message", msg);
  drawLine(msg.line)
})

channel.push("ready", {})
  .receive("ok", resp => {
    console.log("ready")
    resp.lines.forEach(drawLine)
  });
