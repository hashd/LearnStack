const puppeteer = require('puppeteer');

(async () => {
	const path = 'hn.pdf';
	const format = 'A4';

	const browser = await puppeteer.launch();
	const page = await browser.newPage();
	page.setViewport({ width: 1920, height: 1080 });
	await page.goto('https://news.ycombinator.com', {waitUntil: 'networkidle'});
	await page.pdf({ path, format });

	browser.close();
})();