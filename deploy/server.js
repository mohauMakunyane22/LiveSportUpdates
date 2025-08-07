import express from "express";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 8080;

// Serve frontend static files
app.use(express.static(path.join(__dirname, "frontend")));

// For React routes
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "frontend/index.html"));
});

// Example API route
app.get("/api/hello", (req, res) => {
  res.json({ msg: "Hello from LiveSportUpdates backend", timestamp: new Date().toISOString() });
});

app.listen(PORT, () => {
  console.log(`LiveSportUpdates server running on port ${PORT}`);
});
