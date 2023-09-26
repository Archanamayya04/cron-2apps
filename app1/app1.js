// app1.js
const http = require('http');
const port = 3001;

const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('Hello from App 1!\n');
});

server.listen(port, () => {
  console.log(`App 1 is running on port ${port}`);
});

