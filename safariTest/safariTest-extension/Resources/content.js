browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
  console.log("Received response: ", response);
});

browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
  console.log("Received request: ", request);
});

(() => {
  function getText (node) {
    if (node.hasChildNodes()) {
      node.childNodes.forEach(getText);
    } else if (node.nodeType === Node.TEXT_NODE) {
      if (node.textContent.includes("Green")) {
        node.textContent = node.textContent.replaceAll("Green", "🍏");
      }
    }
  }
  
  getText(document.body);
})();
