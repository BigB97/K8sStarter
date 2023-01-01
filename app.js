const express = require("express");
const app = express();

app.get("/foo", (req, res) => {
  res.json({ myFavouriteColor: "Blue" });
});

// 404 handler
app.all("*", (req, res) => {
  res.status(404).json({ error: "Not found" });
});

app.listen(8080, () => {
  console.log("Server running on port 8080");
});
