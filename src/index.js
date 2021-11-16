const express = require("express");
const Gun = require("gun");

const PORT = process.env.PORT || 8000;
const TEMPORAL_DIR = "gundata";

const startServer = () => {
  const app = express();

  app.use(Gun.serve);
  app.use(express.static(__dirname));

  const server = app.listen(PORT, "0.0.0.0", () => {
    console.log(`Listening at: http://localhost:${PORT}`);
  });

  Gun({ file: TEMPORAL_DIR, web: server });
};

startServer();
