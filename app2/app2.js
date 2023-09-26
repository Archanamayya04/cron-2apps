// app2.js
const http = require('http');
const port = 3002;

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from App 2!\n');
});

server.listen(port, () => {
  console.log(`App 2 is running on port ${port}`);
});

