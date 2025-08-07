import express from "express";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || 8080;

// Example API route - must come before static files
app.get("/api/hello", (req, res) => {
  res.json({ 
    msg: "Hello from LiveSportUpdates backend - Deploy Test!", 
    timestamp: new Date().toISOString(),
    version: "1.0.0",
    status: "running"
  });
});

// Serve frontend static files
app.use(express.static(path.join(__dirname, "../frontend-dist")));

// For React routes - catch-all route (must be last)
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "../frontend-dist/index.html"));
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
