require("dotenv").config();
const express = require("express");
const cors = require("cors");
const app = express();
const bodyParser = require("body-parser");
const dns = require("dns");

// Basic Configuration
const port = process.env.PORT || 3000;

app.use(cors());

app.use("/public", express.static(`${process.cwd()}/public`));

app.use(bodyParser.urlencoded({ extended: false }));

app.get("/", function (req, res) {
	res.sendFile(process.cwd() + "/views/index.html");
});

// Your first API endpoint
app.get("/api/hello", function (req, res) {
	res.json({ greeting: "hello API" });
});
// 2. You can POST a URL to /api/shorturl and get a JSON response with original_url and short_url properties.
// Here's an example: { original_url : 'https://freeCodeCamp.org', short_url : 1}
// 3. When you visit /api/shorturl/<short_url>, you will be redirected to the original URL.

let urlDatabase = {};
const validUrl = /^https?:\/\/(www\.)?[a-zA-Z0-9\-\.]+\.[a-z]{2,}.*$/;

app.post("/api/shorturl", function (req, res) {
	const original_url = req.body.url;

	let urlObj;
	try {
		urlObj = new URL(original_url);
	} catch (e) {
		return res.json({ error: "invalid url" });
	}

	if (urlObj.protocol !== "http:" && urlObj.protocol !== "https:") {
		return res.json({ error: "invalid url" });
	}

	dns.lookup(urlObj.hostname, (err) => {
    if (err) {
      return res.json({ error: "invalid url" });
    }

		const short_url = Math.floor(Math.random() * 1000);
		urlDatabase[short_url] = original_url;

		res.json({
			original_url,
			short_url,
		});
	});
});

app.get("/api/shorturl/:short_url", function (req, res) {
	const short_url = req.params.short_url;
	const original_url = urlDatabase[short_url];
	if (original_url) {
		res.redirect(original_url);
	} else {
		res.json({ error: "invalid url" });
	}
});

app.listen(port, function () {
	console.log(`Listening on port ${port}`);
});
