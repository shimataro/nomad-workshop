require('http')
  .createServer((req, res) => {
    res.writeHead(200, {
      "Content-Type": "text/plain",
    });
  
    // 地獄の言葉
    res.end("Hell Word\n");
  })
  .listen(3000);
