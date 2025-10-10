browser.runtime.onMessage.addListener(async (message) => {
  if (message.type === "SHARE_LINK") {
    // 앱으로 데이터 전송
    const data = encodeURIComponent(JSON.stringify(message));
    const url = `scraper://share?data=${data}`;
    await browser.tabs.create({ url });
  }
});
